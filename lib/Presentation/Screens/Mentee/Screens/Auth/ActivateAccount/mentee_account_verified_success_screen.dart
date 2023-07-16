import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Auth/SignIn/mentee_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class MenteeAccountVerifiedSuccessScreen extends StatefulWidget {
  const MenteeAccountVerifiedSuccessScreen({super.key});

  @override
  State<MenteeAccountVerifiedSuccessScreen> createState() =>
      _MenteeAccountVerifiedSuccessState();
}

class _MenteeAccountVerifiedSuccessState
    extends State<MenteeAccountVerifiedSuccessScreen> {
  @override
  void initState() {
    print('Account Veerified Success Screen INIT');
    super.initState();
  }

  @override
  void dispose() {
    print('Account Veerified Success Screen DISPOSE ');
    super.dispose();
  }

  onSignButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MenteeSignInScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: Image.asset(
              AppImages.icCorrect,
              height: 60.h,
              width: 70.w,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          congraulationTextWidget(),
          SizedBox(
            height: 6.h,
          ),
          accountVerifiedSuccessTextWidget(),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: TextButtonWidget(
              btnTxt: AppString.signIn,
              onButtonTap: () {
                onSignButtonTap();
              },
            ),
          ),
        ],
      ),
    );
  }

  accountVerifiedSuccessTextWidget() {
    return Text(
      AppString.accountVerifiedSuccess,
      style: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 12.sp,
        color: AppColors.kFontColor,
      ),
    );
  }

  congraulationTextWidget() {
    return Text(
      AppString.congratulation,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 22.sp,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }
}
