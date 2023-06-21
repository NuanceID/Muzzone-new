import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/category.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

enum CategoriesStatus { initial, success, failure, loading }

class CategoriesState extends Equatable {
  final CategoriesStatus categoriesStatus;
  final CategoriesStatus categoryStatus;
  final String serverMessage;
  final List<Category> categories;
  final Category category;
  final List<MyPlaylist> categoriesList;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;
  final List<Track> tracksList;

  const CategoriesState(
      {this.categoriesStatus = CategoriesStatus.initial,
      this.categoryStatus = CategoriesStatus.initial,
      this.serverMessage = '',
      this.categories = const <Category>[],
      this.category = const Category(),
      this.categoriesList = const <MyPlaylist>[],
      this.hasReached = false,
      this.currentPage = -1,
      this.nextPage = -1,
      this.lastPage = -1,
      this.tracksList = const <Track>[]});

  @override
  List<Object?> get props => [
        categoriesStatus,
        categoryStatus,
        serverMessage,
        categories,
        category,
        categoriesList,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
        tracksList
      ];

  CategoriesState copyWith(
      {CategoriesStatus? categoriesStatus,
      CategoriesStatus? categoryStatus,
      String? serverMessage,
      List<Category>? categories,
      Category? category,
      List<MyPlaylist>? categoriesList,
      bool? hasReached,
      int? currentPage,
      int? nextPage,
      int? lastPage,
      List<Track>? tracksList}) {
    return CategoriesState(
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        categories: categories ?? this.categories,
        category: category ?? this.category,
        categoriesList: categoriesList ?? this.categoriesList,
        hasReached: hasReached ?? this.hasReached,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        tracksList: tracksList ?? this.tracksList);
  }
}
