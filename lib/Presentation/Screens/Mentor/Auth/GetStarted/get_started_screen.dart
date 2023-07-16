import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignUp/sign_up_screen.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  TextEditingController firstNameController = TextEditingController();

  navigateToSignInScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CommonSignInScreen();
      },
    ));
  }

  navigateToSignUpScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SignUpScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppImages.icGetInfo,
                  ),
                ),
              ),
            ),
            Container(
              color: AppColors.kPrimaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Text(
                      AppString.learn,
                      style: MavenTextStyles.bitterSemiBold.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Text(
                      AppString.connect,
                      style: MavenTextStyles.nunitoSemiBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.kNewConnectColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Container(
                        height: 44.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            navigateToSignUpScreen();
                          },
                          child: Text(
                            AppString.getStartednow,
                            style: MavenTextStyles.nunitoExtraBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppString.alreadyAccount,
                        style: MavenTextStyles.nunitoSemiBold.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.kNewConnectColor,
                        ),
                        children: [
                          TextSpan(
                            text: AppString.signIn,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigateToSignInScreen();
                              },
                            style: MavenTextStyles.nunitoBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kSelectedTabColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
