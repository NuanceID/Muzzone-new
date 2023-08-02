import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muzzone/config/config.dart';

import '../../../generated/locale_keys.g.dart';
import '../../pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/bloc/edit_photo_bloc.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {Key? key,
      required this.needFunction,
      required this.icon,
      this.needBorder = false})
      : super(key: key);

  final bool needFunction;
  final IconData icon;
  final bool? needBorder;

  @override
  Widget build(BuildContext context) {
    final editPhotoBloc = context.read<EditPhotoBloc>();

    return Center(
      child: BlocBuilder<EditPhotoBloc, EditPhotoState>(
        builder: (context, state) {
          return Stack(
            children: [
              state.image != null
                  ? buildImage(context, editPhotoBloc)
                  : GestureDetector(
                      onTap: () async {
                        if (needFunction) {
                          final source = await showImageSource(context, editPhotoBloc);
                          if (source == null) return;
                          editPhotoBloc.add(FinalPickImage(source));
                          return Future.value();
                        }
                      },
                      child: Container(
                        decoration: needBorder!
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : null,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 65,
                          child: Icon(
                            size: 27.w,
                            icon,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget buildImage(BuildContext context, EditPhotoBloc editPhotoBloc) {
    final imagePath = editPhotoBloc.state.image!.path;
    final photo = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: needBorder!
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                )
              : null,
          child: Ink.image(
              image: photo as ImageProvider,
              fit: BoxFit.cover,
              width: 33.w,
              height: 33.w,
              child: InkWell(
                onTap: () async {
                  if (needFunction) {
                    final source = await showImageSource(context, editPhotoBloc);
                    if (source == null) return;
                    (source) => editPhotoBloc.add(FinalPickImage(source));
                  }
                },
              )),
        ),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context, EditPhotoBloc editPhotoBloc) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 1.h + Space.bottomBarHeight * 2,
              ),
              child: CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleKeys.camera.tr(),
                      style: TextStyle(
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.camera),
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleKeys.gallery.tr(),
                      style: TextStyle(
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.gallery),
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleKeys.cancel.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            );
          });

              /*BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 1.h + Space.bottomBarHeight * 2,
                    ),
                    child: CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          child: Text(
                            LocaleKeys.camera.tr(),
                            style: TextStyle(
                              color: Theme.of(context).splashColor,
                            ),
                          ),
                          onPressed: () =>
                              Navigator.of(context).pop(ImageSource.camera),
                        ),
                        CupertinoActionSheetAction(
                          child: Text(
                            LocaleKeys.gallery.tr(),
                            style: TextStyle(
                              color: Theme.of(context).splashColor,
                            ),
                          ),
                          onPressed: () =>
                              Navigator.of(context).pop(ImageSource.gallery),
                        ),
                        CupertinoActionSheetAction(
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style: const TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ));*/
    } else {
      return showModalBottomSheet(
          backgroundColor: Colors.white.withOpacity(0),
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<EditPhotoBloc, EditPhotoState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              ButtonChoosePhoto(
                                onPress: () async {
                                  Navigator.of(context).pop();
                                  editPhotoBloc
                                      .add(FinalPickImage(ImageSource.camera));
                                },
                                title: LocaleKeys.camera.tr(),
                                color: Theme.of(context).splashColor,
                                index: 0,
                              ),
                              ButtonChoosePhoto(
                                onPress: () async {
                                  Navigator.of(context).pop();
                                  editPhotoBloc
                                      .add(FinalPickImage(ImageSource.gallery));
                                },
                                title: LocaleKeys.gallery.tr(),
                                color: Theme.of(context).splashColor,
                                index: 1,
                              ),
                              ButtonChoosePhoto(
                                onPress: () async {
                                  Navigator.of(context).pop();
                                  editPhotoBloc.add(DeletePhotoEvent());
                                },
                                title: LocaleKeys.delete_photo.tr(),
                                color: Colors.red,
                                index: 2,
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ButtonChoosePhoto(
                        onPress: () async => Navigator.of(context).pop(),
                        title: LocaleKeys.cancel.tr(),
                        color: Theme.of(context).splashColor,
                        index: 3,
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                    ],
                  ),
                  /*BlocBuilder<AudioBloc, AudioState>(
                    builder: (context, state) {
                      return SizedBox(height: 1.h + Space.bottomBarHeight * 2);
                    },
                  ),*/
                ],
              ));
    }
  }
}

class ButtonChoosePhoto extends StatelessWidget {
  const ButtonChoosePhoto({
    super.key,
    required this.onPress,
    required this.title,
    required this.color,
    required this.index,
  });

  final VoidCallback onPress;
  final String title;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              // border: Border.all(width: 0, color: Colors.white.withOpacity(0)),
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: index == 0
                    ? const Radius.circular(15)
                    : index == 3
                        ? const Radius.circular(15)
                        : Radius.zero,
                bottom: index == 2
                    ? const Radius.circular(15)
                    : index == 3
                        ? const Radius.circular(15)
                        : Radius.zero,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          if (index == 0 || index == 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: double.maxFinite,
                height: 0.1.h,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
