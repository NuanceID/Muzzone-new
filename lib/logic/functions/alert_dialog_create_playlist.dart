import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';

import '../../../generated/locale_keys.g.dart';

void alertDialogCreatePlaylist(
        BuildContext context, Function(String)? onChanged, Function()? onTap) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              title: Text(
                LocaleKeys.new_playlist.tr(),
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 16.h,
                child: Column(
                  children: [
                    TextField(
                      cursorColor: AppColors.primaryColor,
                      maxLines: 1,
                      maxLength: 16,
                      textAlign: TextAlign.start,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 3.h,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5.0,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        filled: true,
                      ),
                      onChanged: onChanged,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                              color: Theme.of(context).dialogBackgroundColor,
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.3.h,
                                ),
                                child: Text(
                                  LocaleKeys.cancel.tr(),
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                              border: Border.all(
                                width: 1,
                                color: AppColors.primaryColor,
                              ),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.3.h,
                                ),
                                child: Text(
                                  LocaleKeys.create.tr(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
