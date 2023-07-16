import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class TextButtonWidget extends StatefulWidget {
  final Function onButtonTap;
  final String btnTxt;

  TextButtonWidget({
    super.key,
    required this.onButtonTap,
    required this.btnTxt,
  });

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(27.r),
      ),
      child: TextButton(
        onPressed: () {
          widget.onButtonTap();
        },
        child: Text(
          widget.btnTxt,
          style: MavenTextStyles.nunitoBold.copyWith(
            fontSize: 14,
            color: AppColors.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
