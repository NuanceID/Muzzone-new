import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_bloc.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_state.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_bloc.dart';
import 'package:muzzone/ui/pages/my_media_page/widgets/recent_tracks.dart';
import 'package:muzzone/ui/pages/show_all_page/show_all_page.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class MyMediaPage extends StatefulWidget {
  static const id = 'MyMediaPage';

  const MyMediaPage({Key? key}) : super(key: key);

  @override
  State<MyMediaPage> createState() => _MyMediaPageState();
}

class _MyMediaPageState extends State<MyMediaPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(() {
        bool contain = BlocProvider.of<MyPlayListsBloc>(context)
                .state
                .myPlayLists
                .firstWhereOrNull((e) =>
                    e.title.trim() == _textEditingController.text.trim()) !=
            null;

        if (_textEditingController.text.isNotEmpty) {
          if (contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
          } else if (!contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: true));
          }
        } else {
          BlocProvider.of<MyPlayListsBloc>(context).add(
              const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
        }
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: HeaderTitle(
                        title: LocaleKeys.my_media.tr(),
                        needIconBack: false,
                      )),
                      const Flexible(
                        child: RecentTracks(),
                      ),
                      Flexible(
                        child: SizedBox(height: availableHeight / 25),
                      ),
                      Flexible(
                          child: TitleWithButtonShowAll(
                        title: LocaleKeys.my_playlists.tr(),
                        item: const [],
                        fromPage: 'my_media',
                        isPlaylists: true,
                        createNewPlaylist: () {
                          if (BlocProvider.of<MyPlayListsBloc>(buildContext)
                                  .state
                                  .myPlayLists
                                  .length >
                              100) {
                            showDialog(
                                context: buildContext,
                                builder: (innerContext) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0.r))),
                                      backgroundColor: Theme.of(innerContext)
                                          .dialogBackgroundColor,
                                      contentPadding: EdgeInsets.only(
                                          left: 20.r, right: 20.r, top: 20.r),
                                      actionsPadding: EdgeInsets.zero,
                                      buttonPadding: EdgeInsets.zero,
                                      title: Text(
                                        LocaleKeys.playlist_limit_exceeded.tr(),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SizedBox(
                                        height: availableHeight / 12,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            innerContext);
                                                      },
                                                      child: Text(
                                                        LocaleKeys.cancel.tr(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: const Color(
                                                                    0xff3D6394)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                            return;
                          }

                          showDialog(
                              context: buildContext,
                              builder: (innerContext) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0.r))),
                                    backgroundColor: Theme.of(innerContext)
                                        .dialogBackgroundColor,
                                    contentPadding: EdgeInsets.only(
                                        left: 20.r, right: 20.r, top: 20.r),
                                    actionsPadding: EdgeInsets.zero,
                                    buttonPadding: EdgeInsets.zero,
                                    title: Text(
                                      LocaleKeys.new_playlist.tr(),
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: SizedBox(
                                      height: availableHeight / 6,
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  _textEditingController,
                                              cursorColor:
                                                  AppColors.primaryColor,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.sp,
                                              ),
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                counterText: '',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            availableWidth /
                                                                50),
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      5.0.r,
                                                    ),
                                                  ),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      5.0.r,
                                                    ),
                                                  ),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      5.0.r,
                                                    ),
                                                  ),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                filled: true,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              height: availableHeight / 50,
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          innerContext);
                                                    },
                                                    child: Text(
                                                      LocaleKeys.cancel.tr(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14.sp,
                                                              color: const Color(
                                                                  0xff3D6394)),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(child: BlocBuilder<
                                                    MyPlayListsBloc,
                                                    MyPlayListsState>(
                                                  builder: (context,
                                                      myPlayListsBlocState) {
                                                    return TextButton(
                                                      onPressed:
                                                          myPlayListsBlocState
                                                                  .isMyPlayListNameValidated
                                                              ? () {
                                                                  BlocProvider.of<MyPlayListsBloc>(context).add(PutMyPlayList(
                                                                      myPlayList: MyPlaylist(
                                                                          title: _textEditingController
                                                                              .value
                                                                              .text,
                                                                          uuid: const Uuid()
                                                                              .v1(),
                                                                          isMyPlayList:
                                                                              true)));

                                                                  _textEditingController
                                                                      .text = '';

                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                      child: Text(
                                                        LocaleKeys.create.tr(),
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.sp,
                                                            color: myPlayListsBlocState
                                                                    .isMyPlayListNameValidated
                                                                ? const Color(
                                                                    0xff3D6394)
                                                                : AppColors
                                                                    .greyColor),
                                                      ),
                                                    );
                                                  },
                                                ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        onPress: () {
                          Navigator.of(buildContext).pushNamed(ShowAllPage.id,
                              arguments: ShowAllPageArguments(
                                  item:
                                      BlocProvider.of<RecentTracksBloc>(context)
                                          .state
                                          .recentTracks,
                                  title: LocaleKeys.my_playlists.tr(),
                                  fromPage: 'main_page'));
                        },
                      )),
                      Flexible(
                        child: SizedBox(
                          height: availableHeight / 30,
                        ),
                      ),
                      Flexible(
                          child: BlocBuilder<MyPlayListsBloc, MyPlayListsState>(
                        builder: (buildContext, myPlayListsState) {
                          if (myPlayListsState.myPlayListsStatus ==
                                  MyPlayListsStatus.loading ||
                              myPlayListsState.myPlayListsStatus ==
                                  MyPlayListsStatus.initial) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: const SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: TrendsPlaceholder(),
                                ));
                          }

                          if (myPlayListsState.myPlayListsStatus ==
                                  MyPlayListsStatus.success &&
                              myPlayListsState.myPlayLists.isEmpty) {
                            return SizedBox(
                                height: availableHeight / 5.42,
                                child: Center(
                                    child: Text(LocaleKeys.no_my_playlists.tr(),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: AppColors.primaryColor,
                                        ))));
                          }

                          return ListView.builder(
                              itemCount: myPlayListsState.myPlayLists.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return PlaylistRow(
                                  playlist: myPlayListsState.myPlayLists[index],
                                  onPress: () {
                                    Navigator.of(context).pushNamed(
                                        ShowAllPage.id,
                                        arguments: ShowAllPageArguments(
                                            item: myPlayListsState
                                                .myPlayLists[index],
                                            title: myPlayListsState
                                                .myPlayLists[index].title,
                                            fromPage: 'my_media'));
                                  },
                                );
                              });
                        },
                      ))
                    ],
                  ))));
    });
  }
}
