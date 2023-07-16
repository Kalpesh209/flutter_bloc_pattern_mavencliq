import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class ExperienceListItemWidget extends StatefulWidget {
  final String? positionName;
  final String? positionTenure;
  final String? organisationName;
  final Function onEditTap;
  final Function onDeleteTap;
  const ExperienceListItemWidget({
    super.key,
    required this.positionName,
    required this.positionTenure,
    required this.organisationName,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  State<ExperienceListItemWidget> createState() => _ExperienceListItemState();
}

class _ExperienceListItemState extends State<ExperienceListItemWidget> {
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
                      widget.positionName!,
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
                      //'',
                      '${widget.positionTenure} years',
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
              widget.organisationName!,
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
