import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Common/bloc/common_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class AccountVerifiedSuccessScreen extends StatefulWidget {
  const AccountVerifiedSuccessScreen({super.key});

  @override
  State<AccountVerifiedSuccessScreen> createState() =>
      _AccountVerifiedSuccessScreenState();
}

class _AccountVerifiedSuccessScreenState
    extends State<AccountVerifiedSuccessScreen> {
  late CommonAuthBloc commonAuthBloc;
  @override
  void initState() {
    print('Account Veerified Success Screen INIT');
    verifyMentorEmail();
    super.initState();
  }

  @override
  void dispose() {
    print('Account Veerified Success Screen DISPOSE ');
    super.dispose();
  }

  verifyMentorEmail() {
    var userToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtoYW5kbGFrYWxwZXNoMjBAZ21haWwuY29tIiwiaWF0IjoxNjg0NjY3NzMzLCJleHAiOjE2ODQ3NTQxMzN9.KgH0096usgOcDznFLvUi0kLNAAKryEW9n8vTCj_oaw4';
    commonAuthBloc.add(CommonVerifyEmailEvent(userToken));
  }

  onSignButtonTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CommonSignInScreen();
      },
    ));
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
