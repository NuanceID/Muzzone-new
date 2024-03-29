import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';

class NamePhoneTextFormField extends StatelessWidget {
  const NamePhoneTextFormField({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.textInputType,
    required this.onEditingComplete,
    required this.onChanged,
    required this.borderColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final VoidCallback onEditingComplete;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46.5.w,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        readOnly: borderColor == AppColors.primaryColor ? false : true,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          counterText: '',
          contentPadding:
          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        ),
        cursorColor: Theme.of(context).scaffoldBackgroundColor/*!visible
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).secondaryHeaderColor*/,
        enableInteractiveSelection: false,
        maxLines: 1,
        maxLength: 14,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 15.sp,
        ),
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
      ),
    );
  }
}
