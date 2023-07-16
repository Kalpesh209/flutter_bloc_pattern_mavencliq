import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  String dropDownValue = AppString.salutation;
  String counrtyCodeValue = AppString.countryCode;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  var salutationArray = [
    AppString.salutation,
    AppString.mr,
    AppString.ms,
    AppString.mrs,
  ];

  var phoneArray = [
    AppString.countryCode,
    AppString.countryCode1,
    AppString.countryCode2,
  ];

  onBackButtonTap() {}

  UploadPhoto() {
    print("Pick a Image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 270.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: ExactAssetImage(AppImages.icOnboardBack),
                    ),
                  ),
                ),
                Positioned(
                  top: 62.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onBackButtonTap();
                          },
                          child: Image.asset(
                            AppImages.icBack,
                            color: AppColors.kWhiteColor,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          height: 17.sp,
                        ),
                        Text(
                          AppString.letsCompleteProfile,
                          style: MavenTextStyles.bitterSemiBold.copyWith(
                            fontSize: 26.sp,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.h,
                              width: 78.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kSelectedTabColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              height: 4.h,
                              width: 78.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kUnselectedStepsColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              height: 4.h,
                              width: 78.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kUnselectedStepsColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              height: 4.h,
                              width: 78.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kUnselectedStepsColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          AppString.step1,
                          style: MavenTextStyles.nunitoRegular.copyWith(
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      UploadPhoto();
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.kUploadPhotoColor,
                          child: Center(
                            child: Image.asset(
                              AppImages.icPhoto,
                              height: 22.h,
                              width: 25.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14.5.w,
                        ),
                        Text(
                          AppString.addProfilePhoto,
                          style: MavenTextStyles.nunitoBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kSelectedTabColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  DropdownButtonHideUnderline(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.kGreyColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 14.w),
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Image.asset(
                            AppImages.icDropDown,
                            height: 10.h,
                          ),
                          value: dropDownValue,
                          items: salutationArray.map(
                            (String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: MavenTextStyles.nunitoRegular.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kFontColor,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldWidget(
                    controller: firstNameController,
                    isPasswordField: false,
                    hint: AppString.firstName,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == "" || val == '') {
                        return '*Required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldWidget(
                    controller: middleNameController,
                    isPasswordField: false,
                    hint: AppString.middleName,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == "" || val == '') {
                        return '*Required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldWidget(
                    controller: lastNameController,
                    isPasswordField: false,
                    hint: AppString.lastName,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == "" || val == '') {
                        return '*Required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormFieldWidget(
                    controller: emailController,
                    isPasswordField: false,
                    hint: AppString.emailAdd,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == "" || val == '') {
                        return '*Required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 48.h,
                        width: 81.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.kGreyColor.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: EdgeInsets.only(left: 14.w, right: 14.w),
                            child: DropdownButton(
                              value: counrtyCodeValue,
                              items: phoneArray.map(
                                (String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: MavenTextStyles.nunitoRegular
                                          .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.kFontColor,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  counrtyCodeValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: phoneController,
                          isPasswordField: false,
                          hint: AppString.phone,
                          inputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {},
                          validator: (val) {
                            if (val == null || val == "" || val == '') {
                              return '*Required';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
