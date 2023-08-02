import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/path/path.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_bloc.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_state.dart';

enum ThreeDotsButtonItem { itemOne, itemTwo }

class ThreeDotsButton extends StatefulWidget {
  const ThreeDotsButton(
      {Key? key, this.playlist, this.audio, required this.fromPage})
      : super(key: key);

  final MyPlaylist? playlist;
  final dynamic audio;
  final String fromPage;

  @override
  State<ThreeDotsButton> createState() => _ThreeDotsButtonState();
}

class _ThreeDotsButtonState extends State<ThreeDotsButton> {
  late TextEditingController _textEditingController;
  List<MyPlaylist> list = <MyPlaylist>[];

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
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert_outlined),
      splashRadius: 25.r,
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                    flex: 18, fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                    flex: 12,
                    fit: FlexFit.tight,
                    child: Container(
                      margin: EdgeInsets.only(left: 20.r, right: 20.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13.r)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                              child: SizedBox(
                            height: availableHeight / 100,
                          )),
                          GestureDetector(
                            onTap: () {
                              if (widget.playlist != null) {
                                _textEditingController.text =
                                    widget.playlist!.title;
                              }

                              Navigator.pop(context);

                              showDialog(
                                  context: context,
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
                                          LocaleKeys.playlist_name.tr(),
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
                                                      TextCapitalization
                                                          .sentences,
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
                                                      borderSide:
                                                          const BorderSide(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
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
                                                          BorderRadius.all(
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
                                                          LocaleKeys.cancel
                                                              .tr(),
                                                          style: GoogleFonts
                                                              .montserrat(
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
                                                                      if (widget
                                                                              .playlist !=
                                                                          null) {
                                                                        BlocProvider.of<MyPlayListsBloc>(innerContext).add(UpdateMyPlayListName(
                                                                            myPlayList:
                                                                                widget.playlist!,
                                                                            playListName: _textEditingController.text));
                                                                        Navigator.pop(
                                                                            innerContext);
                                                                      }
                                                                    }
                                                                  : null,
                                                          child: Text(
                                                            LocaleKeys.change
                                                                .tr(),
                                                            style: GoogleFonts.montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                      )).then(
                                  (value) => _textEditingController.text = '');
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r)),
                                margin: EdgeInsets.only(
                                    left: availableHeight / 50,
                                    right: availableHeight / 50),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                        child: SizedBox(
                                      height: availableHeight / 100,
                                    )),
                                    Flexible(
                                        child: Row(
                                      children: [
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                        Flexible(
                                            flex: 4,
                                            fit: FlexFit.tight,
                                            child: SvgPicture.asset(
                                              '${iconsPath}edit.svg',
                                              color:
                                                  Theme.of(context).splashColor,
                                              fit: BoxFit.none,
                                            )),
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                        Flexible(
                                            flex: 50,
                                            fit: FlexFit.tight,
                                            child: Text(
                                              LocaleKeys.update_name_playlist
                                                  .tr(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                  color:
                                                      AppColors.primaryColor),
                                              maxLines: 1,
                                            )),
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                      ],
                                    )),
                                    Flexible(
                                        child: SizedBox(
                                      height: availableHeight / 100,
                                    )),
                                  ],
                                )),
                          ),
                          Flexible(
                              child: SizedBox(
                            height: availableHeight / 100,
                          )),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);

                              showDialog(
                                  context: context,
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
                                          LocaleKeys.delete_playlist_title.tr(),
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: SizedBox(
                                          height: availableHeight / 7.2,
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  LocaleKeys
                                                      .are_you_sure_delete_playlist
                                                      .tr(),
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
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
                                                          LocaleKeys.cancel
                                                              .tr(),
                                                          style: GoogleFonts
                                                              .montserrat(
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
                                                    Flexible(
                                                        child: TextButton(
                                                      onPressed: () {
                                                        if (widget.playlist !=
                                                            null) {
                                                          BlocProvider.of<
                                                                      MyPlayListsBloc>(
                                                                  innerContext)
                                                              .add(RemoveMyPlayList(
                                                                  myPlayList: widget
                                                                      .playlist!));
                                                          Navigator.pop(
                                                              innerContext);
                                                        }
                                                      },
                                                      child: Text(
                                                        LocaleKeys.yes.tr(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )).then(
                                  (value) => _textEditingController.text = '');
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r)),
                                margin: EdgeInsets.only(
                                    left: availableHeight / 50,
                                    right: availableHeight / 50),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                        child: SizedBox(
                                      height: availableHeight / 100,
                                    )),
                                    Flexible(
                                        child: Row(
                                      children: [
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                        Flexible(
                                            flex: 4,
                                            fit: FlexFit.tight,
                                            child: SvgPicture.asset(
                                              '${iconsPath}delete.svg',
                                              color:
                                                  Theme.of(context).splashColor,
                                              fit: BoxFit.none,
                                            )),
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                        Flexible(
                                            flex: 50,
                                            fit: FlexFit.tight,
                                            child: Text(
                                              LocaleKeys.delete_playlist.tr(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                  color:
                                                      AppColors.primaryColor),
                                              maxLines: 1,
                                            )),
                                        const Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox.shrink()),
                                      ],
                                    )),
                                    Flexible(
                                        child: SizedBox(
                                      height: availableHeight / 100,
                                    )),
                                  ],
                                )),
                          ),
                          Flexible(
                              child: SizedBox(
                            height: availableHeight / 100,
                          )),
                        ],
                      ),
                    )),
                const Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: SizedBox.shrink(),
                ),
                Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 20.r, right: 20.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(13.r)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: SizedBox(
                                height: availableHeight / 55,
                              )),
                              Flexible(
                                  child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        LocaleKeys.cancel.tr(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: AppColors.primaryColor),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      )),
                                ],
                              )),
                              Flexible(
                                  child: SizedBox(
                                height: availableHeight / 100,
                              )),
                            ],
                          )),
                    )),
                const Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
