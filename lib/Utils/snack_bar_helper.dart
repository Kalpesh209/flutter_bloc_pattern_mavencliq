import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class SnackBarHelper {
  static showTextMsg({required context, required msg}) {
    var textWidget = Text(msg,
        style: MavenTextStyles.nunitoBold.copyWith(
          fontSize: 14.sp,
          color: AppColors.kWhiteColor,
        ));

    var snackBar = SnackBar(
      content: textWidget,
      backgroundColor: AppColors.kSelectedTabColor,
      //behavior: SnackBarBehavior.floating,

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       "$msg",
    //       style: MavenTextStyles.nunitoBold.copyWith(
    //         fontSize: 14.sp,
    //         color: AppColors.kWhiteColor,
    //       ),
    //     ),
    //   ),
    // );
  }
}
