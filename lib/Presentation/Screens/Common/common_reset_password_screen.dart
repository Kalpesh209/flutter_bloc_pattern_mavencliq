import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Common/bloc/common_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';

import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class CommonResetPasswordScreen extends StatefulWidget {
  const CommonResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CommonResetPasswordScreen> createState() =>
      _CommonResetPasswordScreenState();
}

class _CommonResetPasswordScreenState extends State<CommonResetPasswordScreen> {
  late CommonAuthBloc commonAuthBloc;
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();
  GlobalKey<FormState> mentorFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    commonAuthBloc = BlocProvider.of<CommonAuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onBackButtonTap() {
    Navigator.pop(context);
  }

  onSubmitButtonTap() {
    _removeFocus();
    String newPassword = newPassController.text.trim();
    String confirmPass = confirmNewPassController.text.trim();
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImthbHBlc2hAdGVjaHV6LmNvbSIsImlhdCI6MTY4NDY2NDQ4MSwiZXhwIjoxNjg0NzUwODgxfQ.K3aXQrWbyVlSbHu0FcjBLretk2BqiJOM22JdyY6HIio';
    final bool? isMentorValid = mentorFormKey.currentState?.validate();
    if (isMentorValid == true) {
      commonAuthBloc.add(CommonResetPasswordEvent(
        newPassword,
        confirmPass,
        token,
      ));
    } else {
      print('LINE 61 : $isMentorValid');
    }
  }

  navigateToSignInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CommonSignInScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kWhiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kWhiteColor,
      body: BlocConsumer<CommonAuthBloc, CommonAuthState>(
        listener: (context, state) {
          if (state is CommonResetPasswordCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
            navigateToSignInScreen();
          } else if (state is CommonResetPasswordFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is CommonResetPasswordLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          }
          return resetPasswordScreen();
        },
      ),
    );
  }

  Widget resetPasswordScreen() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: mentorFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                onBackButtonTap();
              },
              child: Image.asset(
                AppImages.icBack,
                height: 16,
                width: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            resetPassWidget(),
            SizedBox(
              height: 6,
            ),
            createNewpassWidget(),
            SizedBox(
              height: 30,
            ),
            newPassTextWidget(),
            SizedBox(
              height: 6.5,
            ),
            newPassWidget(),
            SizedBox(
              height: 20,
            ),
            confirmNewPassTextWidget(),
            SizedBox(
              height: 6.5,
            ),
            newConfPassWidget(),
            SizedBox(
              height: 30,
            ),
            TextButtonWidget(
              btnTxt: AppString.submit,
              onButtonTap: () {
                onSubmitButtonTap();
              },
            ),
            SizedBox(
              height: 10,
            ),
            richTextWidget(),
          ],
        ),
      ),
    );
  }

  Widget newPassTextWidget() {
    return Text(
      AppString.newPassword,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget confirmNewPassTextWidget() {
    return Text(
      AppString.confmNewPassword,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget richTextWidget() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppString.rememberPassword,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 14,
            color: AppColors.ksignInColor,
          ),
          children: [
            TextSpan(
              text: AppString.signIn,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  navigateToSignInScreen();
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

  Widget newPassWidget() {
    return TextFormFieldWidget(
      controller: newPassController,
      isPasswordField: true,
      inputAction: TextInputAction.next,
      onFieldSubmitted: (value) {},
      validator: (val) {
        if (val == null || val == '') {
          return AppUtilities(context).showTextSnackBar('* Password Required');
        } else if (val.length < 8) {
          return AppUtilities(context)
              .showTextSnackBar('Password must be longer than 8 characters');
        } else if (val.length > 20) {
          return AppUtilities(context)
              .showTextSnackBar('Password must be shorter than 20 characters');
        }
        return null;
      },
    );
  }

  Widget newConfPassWidget() {
    return TextFormFieldWidget(
      controller: confirmNewPassController,
      isPasswordField: true,
      inputAction: TextInputAction.done,
      onFieldSubmitted: (value) {},
      validator: (val) {
        if (val == null || val == '') {
          return AppUtilities(context)
              .showTextSnackBar('* Confirm Password Required');
        } else if (val.length < 8) {
          return AppUtilities(context).showTextSnackBar(
              'Confirm Password must be longer than 8 characters');
        } else if (val.length > 20) {
          return AppUtilities(context).showTextSnackBar(
              'Confirm Password must be shorter than 20 characters');
        }
        return null;
      },
    );
  }

  Widget createNewpassWidget() {
    return Text(
      AppString.createNewPassword,
      style: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 12,
        color: AppColors.kFontColor,
      ),
    );
  }

  Widget resetPassWidget() {
    return Text(
      AppString.resetPassword,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 22,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }
}
