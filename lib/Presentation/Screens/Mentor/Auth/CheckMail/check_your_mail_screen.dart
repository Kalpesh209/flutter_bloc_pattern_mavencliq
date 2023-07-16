import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_reset_password_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ResetPass/reset_password_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckYourMailScreen extends StatefulWidget {
  const CheckYourMailScreen({Key? key}) : super(key: key);

  @override
  State<CheckYourMailScreen> createState() => _CheckYourMailScreenState();
}

class _CheckYourMailScreenState extends State<CheckYourMailScreen> {
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
          return CommonResetPasswordScreen();
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
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Image.asset(
                AppImages.icCheckMail,
                height: 70,
                width: 70,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            checkMailTextWidget(),
            SizedBox(
              height: 6,
            ),
            sentPassTextWidget(),
            SizedBox(
              height: 30,
            ),
            openEmailAppButtonWidget(),
            SizedBox(
              height: 10,
            ),
            skipWidget(),
            Expanded(child: Container()),
            didntReceiveWidget(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget didntReceiveWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppString.didnt,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 14,
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
                fontSize: 14,
                color: AppColors.kSelectedTabColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget skipWidget() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppString.confirmLater,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 14,
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
                fontSize: 14,
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
        fontSize: 12,
        color: AppColors.kFontColor,
      ),
    );
  }

  Widget checkMailTextWidget() {
    return Text(
      AppString.checkMail,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 22,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }
}
