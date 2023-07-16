import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class EducationalDetailsListItemWidget extends StatefulWidget {
  final String degreeName;
  final String yearName;
  final String instituteName;
  final Function onEditTap;
  final Function onDeleteTap;
  const EducationalDetailsListItemWidget({
    super.key,
    required this.degreeName,
    required this.yearName,
    required this.instituteName,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  State<EducationalDetailsListItemWidget> createState() =>
      _EducationalDetailsListItemWidgetState();
}

class _EducationalDetailsListItemWidgetState
    extends State<EducationalDetailsListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 335.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.kUserEmail.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.degreeName,
                      style: MavenTextStyles.nunitoSemiBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.kWelcomeBackColor,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      '|',
                      style: MavenTextStyles.nunitoSemiBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.kWelcomeBackColor,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.yearName,
                      style: MavenTextStyles.nunitoSemiBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.kWelcomeBackColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onDeleteTap();
                      },
                      child: Image.asset(
                        AppImages.icDelete,
                        height: 15,
                        width: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              widget.instituteName,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 13.sp,
                color: AppColors.kFontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
