import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/categories.dart';
import 'package:muzzone/data/models/category.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/categories/categories_event.dart';
import 'package:muzzone/logic/blocs/categories/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final BackendRepository _backendRepository;

  CategoriesBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const CategoriesState()) {
    on<GetFindCategory>(_getFindCategory);
    on<GetMoreCategories>(_getMoreCategories);
    on<GetCategories>(_getCategories);
    on<GetCategory>(_getCategory);
  }

  _getFindCategory(GetFindCategory event, Emitter<CategoriesState> emitter) async {
    emitter(state.copyWith(categoryStatus: CategoriesStatus.loading));

    var getFindCategoryResult = await _backendRepository.getFindCategory(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindCategoryResult is NetworkStateFailed) {
      return emitter(state.copyWith(categoryStatus: CategoriesStatus.failure));
    }

    if (getFindCategoryResult is NetworkStateSuccess) {

      return emitter(state.copyWith(
        categoriesStatus: CategoriesStatus.success,));
    }
  }

  _getMoreCategories(
      GetMoreCategories event, Emitter<CategoriesState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(categoriesStatus: CategoriesStatus.loading));

    var categoriesResult = await _backendRepository.getMoreCategories(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (categoriesResult is NetworkStateFailed) {
      return emitter(
          state.copyWith(categoriesStatus: CategoriesStatus.failure));
    }

    if (categoriesResult is NetworkStateSuccess) {
      Categories categories = categoriesResult.data?.data != null
          ? Categories.fromJson(categoriesResult.data?.data)
          : Categories();

      var categoriesList = categories.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isLanguage: true))
          .toList();

      var nextPage = categories.meta.currentPage < categories.meta.lastPage
          ? categories.meta.currentPage + 1
          : categories.meta.lastPage;

      return emitter(state.copyWith(
          categoriesStatus: CategoriesStatus.success,
          categoriesList: categoriesList,
          hasReached: categories.meta.currentPage >= categories.meta.lastPage,
          currentPage: categories.meta.currentPage,
          nextPage: nextPage,
          lastPage: categories.meta.lastPage));
    }
  }

  _getCategories(GetCategories event, Emitter<CategoriesState> emitter) async {
    emitter(state.copyWith(categoriesStatus: CategoriesStatus.loading));

    var categoriesResult = await _backendRepository
        .getCategories(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (categoriesResult is NetworkStateFailed) {
      return emitter(
          state.copyWith(categoriesStatus: CategoriesStatus.failure));
    }

    if (categoriesResult is NetworkStateSuccess) {
      Categories categories = categoriesResult.data?.data != null
          ? Categories.fromJson(categoriesResult.data?.data)
          : Categories();

      var categoriesList = categories.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isLanguage: true))
          .toList();

      return emitter(state.copyWith(
          categoriesStatus: CategoriesStatus.success,
          categoriesList: categoriesList));
    }
  }

  _getCategory(GetCategory event, Emitter<CategoriesState> emitter) async {
    emitter(state.copyWith(categoryStatus: CategoriesStatus.loading));

    var categoryResult = await _backendRepository.getCategory(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.categoryId);

    if (categoryResult is NetworkStateFailed) {
      return emitter(state.copyWith(categoryStatus: CategoriesStatus.failure));
    }

    if (categoryResult is NetworkStateSuccess) {
      Category category = const Category();
      if (categoryResult.data!.data['data'] != null) {
        category = Category.fromJson(categoryResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          categoryStatus: CategoriesStatus.success, category: category, tracksList: category.tracks));
    }
  }
}
