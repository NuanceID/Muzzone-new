import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_state.dart';
import 'package:muzzone/ui/controllers/main_controller.dart';
import 'package:muzzone/ui/pages/search/widgets/search_popular_and_new_songs.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/locale_keys.g.dart';

class SearchChosenGenrePage extends StatelessWidget {
  const SearchChosenGenrePage({super.key});

  static const id = '/choose_genre_page';

  @override
  Widget build(BuildContext context) {
    final initArgs =
        ModalRoute.of(context)!.settings.arguments as PageWithPlaylistArgument;

    Bloc bloc = GenresBloc(backendRepository: GetIt.I.get<BackendRepository>());

    final PagingController<int, Track> pagingController =
        PagingController<int, Track>(firstPageKey: 1);

    return BlocProvider<GenresBloc>(
        create: (BuildContext context) => bloc,
        child: BlocListener<GenresBloc, GenresState>(
            bloc: bloc as GenresBloc,
            listener: (context, state) {
              if (state.genreStatus == GenresStatus.success) {
                pagingController.appendLastPage(state.tracksList);

                /*if (state.hasReached) {
                          pagingController.appendLastPage(state.genresList);
                        } else {
                          pagingController.appendPage(
                              state.genresList, state.nextPage);
                        }*/
              }

              if (state.genreStatus == GenresStatus.failure) {
                pagingController.error = "Something went wrong";
              }
            },
            child: _SearchChosenGenrePage(
              bloc: bloc,
              pagingController: pagingController,
              genreId: initArgs.playlist.id,
            )));
  }
}

class _SearchChosenGenrePage extends StatefulWidget {
  const _SearchChosenGenrePage(
      {Key? key,
      required this.bloc,
      required this.pagingController,
      required this.genreId})
      : super(key: key);

  final Bloc bloc;
  final PagingController<int, Track> pagingController;
  final int genreId;

  @override
  State<_SearchChosenGenrePage> createState() => _SearchChosenGenrePageState();
}

class _SearchChosenGenrePageState extends State<_SearchChosenGenrePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  var currentPage = 0;
  final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

  final MainController con = GetIt.I.get<MainController>();

  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      widget.bloc.add(GetGenre(genreId: widget.genreId.toString()));
    });

    _scrollController = ScrollController();

    _tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 300));
    _scrollController.addListener(_scrollListener);
    _tabController.addListener(_smoothScrollToTop);
    super.initState();
  }

  void _scrollListener() {
    // обработка событий прокрутки
  }

  _smoothScrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 900),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    widget.pagingController.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PageWithPlaylistArgument;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(17.h),
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: HeaderTitle(
              title: args.playlist.title,
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorWeight: 0.1,
              unselectedLabelColor: AppColors.greyColor,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 12.sp),
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.symmetric(
                  horizontal: MyPadding.horizontalPadding, vertical: 3.h),
              indicatorColor: Theme.of(context).scaffoldBackgroundColor,
              indicator: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              tabs: [
                Tab(
                  text: LocaleKeys.popular.tr(),
                  height: 3.h,
                ),
                Tab(
                  text: LocaleKeys.new_songs.tr(),
                  height: 4.h,
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<GenresBloc, GenresState>(
            bloc: widget.bloc as GenresBloc,
            builder: (context, state) {
              return TabBarView(
                controller: _tabController,
                children: [
                  SearchPopularAndNewSongs(
                    pagingController: widget.pagingController,
                    isPopular: true,
                  ),
                  SearchPopularAndNewSongs(
                    pagingController: widget.pagingController,
                    isPopular: false,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
