import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class ChosedItemWidget extends StatefulWidget {
  final String selectedItemName;
  final int totalItemCount;
  const ChosedItemWidget({
    super.key,
    required this.selectedItemName,
    required this.totalItemCount,
  });

  @override
  State<ChosedItemWidget> createState() => _ChosedItemWidgetState();
}

class _ChosedItemWidgetState extends State<ChosedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 28.h,
          decoration: BoxDecoration(
            color: AppColors.kSelectedDomainBackColor,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 4.h),
            child: Text(
              widget.selectedItemName,
              textAlign: TextAlign.center,
              style: MavenTextStyles.nunitoBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kSelectedTabColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Container(
          height: 28.h,
          decoration: BoxDecoration(
            color: AppColors.kSelectedDomainBackColor,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 4.h),
            child: Text(
              '+ ${widget.totalItemCount}',
              textAlign: TextAlign.center,
              style: MavenTextStyles.nunitoBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kSelectedTabColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
