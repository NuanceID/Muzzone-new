import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_bloc.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_state.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_bloc.dart';
import 'package:muzzone/ui/pages/main_page/widgets/bottom_sheet_button_create_new_playlist.dart';
import 'package:uuid/uuid.dart';

class AddMediaButton extends StatelessWidget {
  const AddMediaButton({
    super.key,
    required String from,
    required TextEditingController textEditingController,
  })  : _from = from,
        _textEditingController = textEditingController;

  final String _from;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding:
            MaterialStateProperty.all(EdgeInsets.all(availableHeight / 200)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.withOpacity(0.1);
          }
          return null;
        }),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              if (BlocProvider.of<MyPlayListsBloc>(context)
                  .state
                  .myPlayLists
                  .isEmpty) {
                return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(child: SizedBox.shrink()),
                        Flexible(
                            flex: 10,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(LocaleKeys.no_my_playlists.tr(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColors.primaryColor)))),
                        const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox.shrink()),
                        Flexible(
                            flex: 10,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: BottomSheetButtonCreateNewPlaylist(
                                  onPress: () {
                                    Navigator.pop(context);

                                    showDialog(
                                        context: context,
                                        builder: (innerContext) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.0.r))),
                                              backgroundColor:
                                                  Theme.of(innerContext)
                                                      .dialogBackgroundColor,
                                              contentPadding: EdgeInsets.only(
                                                  left: 20.r,
                                                  right: 20.r,
                                                  top: 20.r),
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
                                                        cursorColor: AppColors
                                                            .primaryColor,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .sentences,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.sp,
                                                        ),
                                                        autofocus: true,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: '',
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      availableWidth /
                                                                          50),
                                                          fillColor:
                                                              Colors.white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5.0.r,
                                                              ),
                                                            ),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5.0.r,
                                                              ),
                                                            ),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5.0.r,
                                                              ),
                                                            ),
                                                            borderSide:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          filled: true,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: SizedBox(
                                                        height:
                                                            availableHeight /
                                                                50,
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
                                                                LocaleKeys
                                                                    .cancel
                                                                    .tr(),
                                                                style: GoogleFonts.montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp,
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
                                                                            BlocProvider.of<MyPlayListsBloc>(context).add(PutMyPlayList(myPlayList: MyPlaylist(title: _textEditingController.value.text, uuid: const Uuid().v1(), isMyPlayList: true)));

                                                                            _textEditingController.text =
                                                                                '';

                                                                            Navigator.pop(context);
                                                                          }
                                                                        : null,
                                                                child: Text(
                                                                  LocaleKeys
                                                                      .create
                                                                      .tr(),
                                                                  style: GoogleFonts.montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.sp,
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
                                ))),
                        const Flexible(child: SizedBox.shrink()),
                      ],
                    ));
              }

              return Container(
                  color: Colors.white,
                  child: Column(children: [
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: AutoSizeText(
                          LocaleKeys.my_playlists.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        )),
                    Flexible(
                        flex: 20,
                        fit: FlexFit.tight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: BlocProvider.of<MyPlayListsBloc>(context)
                                .state
                                .myPlayLists
                                .length,
                            itemBuilder: (context, index) {
                              return Material(
                                  color: Colors.white,
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<MyPlayListsBloc>(
                                                context)
                                            .add(UpdateMyPlayListTrack(
                                                myPlayList: BlocProvider.of<
                                                            MyPlayListsBloc>(
                                                        context)
                                                    .state
                                                    .myPlayLists[index],
                                                track: BlocProvider.of<
                                                            RecentTracksBloc>(
                                                        context)
                                                    .state
                                                    .currentTrack));
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(
                                              availableHeight / 50),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .greyColor))),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      availableHeight / 150),
                                              child: Row(
                                                children: [
                                                  const Flexible(
                                                      flex: 3,
                                                      fit: FlexFit.tight,
                                                      child: SizedBox.shrink()),
                                                  Flexible(
                                                    flex: 30,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      BlocProvider.of<
                                                                  MyPlayListsBloc>(
                                                              context)
                                                          .state
                                                          .myPlayLists[index]
                                                          .title,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.sp,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              )))));
                            })),
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                  ]));
            });
      },
      child: Column(
        children: [
          Flexible(
              fit: FlexFit.tight,
              child: SvgPicture.asset(
                'assets/icons/like_add.svg',
                width: _from == 'bottom_player_buttons'
                    ? null
                    : availableHeight / 25,
                height: _from == 'bottom_player_buttons'
                    ? null
                    : availableHeight / 25,
                color: AppColors.greyColor,
              )),
        ],
      ),
    );
  }
}
