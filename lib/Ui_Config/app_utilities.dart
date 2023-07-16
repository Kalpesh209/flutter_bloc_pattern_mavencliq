import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class AppUtilities {
  AppUtilities(this.context);

  BuildContext context;

  void dismissKeyboard() => FocusScope.of(context).unfocus();

  String? showTextSnackBar(String text) {
    var textWidget = Text(text,
        style: MavenTextStyles.nunitoBold.copyWith(
          fontSize: 14.sp,
          color: AppColors.kWhiteColor,
        ));
    var snackBar = SnackBar(
      content: textWidget,
      backgroundColor: AppColors.kSelectedTabColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
