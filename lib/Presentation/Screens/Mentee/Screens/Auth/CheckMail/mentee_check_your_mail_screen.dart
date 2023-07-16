import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Auth/ResetPass/mentee_reset_password_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ResetPass/reset_password_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class MenteeCheckYourMailScreen extends StatefulWidget {
  const MenteeCheckYourMailScreen({Key? key}) : super(key: key);

  @override
  State<MenteeCheckYourMailScreen> createState() => _CheckYourMailScreenState();
}

class _CheckYourMailScreenState extends State<MenteeCheckYourMailScreen> {
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://mail.google.com/mail/u/0/#inbox');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  onTryAnotherTap() {
    Navigator.of(context).pop();
  }

  onSkipTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MenteeResetPasswordScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kWhiteColor,
    ));
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            Center(
              child: Image.asset(
                AppImages.icCheckMail,
                height: 70.h,
                width: 70.w,
              ),
            ),
            SizedBox(
              height: 55.h,
            ),
            checkMailTextWidget(),
            SizedBox(
              height: 6.h,
            ),
            sentPassTextWidget(),
            SizedBox(
              height: 40.h,
            ),
            openEmailAppButtonWidget(),
            SizedBox(
              height: 12.h,
            ),
            skipWidget(),
            Expanded(child: Container()),
            didntReceiveWidget(),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget didntReceiveWidget() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppString.didnt,
        style: MavenTextStyles.nunitoRegular.copyWith(
          fontSize: 14.sp,
          color: AppColors.ksignInColor,
        ),
        children: [
          TextSpan(
            text: AppString.or,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTryAnotherTap();
              },
            style: MavenTextStyles.nunitoBold.copyWith(
              fontSize: 14.sp,
              color: AppColors.kSelectedTabColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget skipWidget() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppString.confirmLater,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 14.sp,
            color: AppColors.ksignInColor,
          ),
          children: [
            TextSpan(
              text: AppString.skip,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onSkipTap();
                },
              style: MavenTextStyles.nunitoBold.copyWith(
                fontSize: 14.sp,
                color: AppColors.kSelectedTabColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget openEmailAppButtonWidget() {
    return TextButtonWidget(
      btnTxt: AppString.openEmailApp,
      onButtonTap: () {
        _launchUrl();
      },
    );
  }

  Widget sentPassTextWidget() {
    return Text(
      AppString.sendPassRecovery,
      textAlign: TextAlign.center,
      style: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 14.sp,
        color: AppColors.ksignInColor,
      ),
    );
  }

  Widget checkMailTextWidget() {
    return Text(
      AppString.checkMail,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 20.sp,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }
}
