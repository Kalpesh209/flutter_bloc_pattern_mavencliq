import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/bloc/mentee_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';

import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class MenteeResetPasswordScreen extends StatefulWidget {
  const MenteeResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<MenteeResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<MenteeResetPasswordScreen> {
  late MenteeAuthBloc menteeAuthBloc;
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();
  GlobalKey<FormState> menteeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    menteeAuthBloc = BlocProvider.of<MenteeAuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBackButtonTap() {
    Navigator.pop(context);
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onSubmitButtonTap() {
    _removeFocus();

    String menteeNewPassword = newPassController.text.trim();
    String menteeConfirmPass = confirmNewPassController.text.trim();
    String menteeToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbmpheUB0ZWNodXouY29tIiwiaWF0IjoxNjg0MTI2MDI5LCJleHAiOjE2ODQyMTI0Mjl9.FS5LhoVv0k8zjvctpTkDitW6fm36VIBrYUUzTM4AXec';
    final bool? isMenteeValid = menteeFormKey.currentState?.validate();
    if (isMenteeValid == true) {
      menteeAuthBloc.add(MenteeResetPasswordEvent(
          menteeNewPassword, menteeConfirmPass, menteeToken));
    } else {
      print('LINE 61 : $isMenteeValid');
    }
  }

  navigateToSignInScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SignInScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kWhiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<MenteeAuthBloc, MenteeAuthState>(
          listener: (context, state) {
            if (state is MenteeResetPasswordCompletedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
              navigateToSignInScreen();
            } else if (state is MenteeResetPasswordFailedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
            }
          },
          builder: (context, state) {
            if (state is MenteeResetPasswordLoadingState) {
              return SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Form(
                    key: menteeFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 62.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            onBackButtonTap();
                          },
                          child: Image.asset(
                            AppImages.icBack,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        resetPassWidget(),
                        SizedBox(
                          height: 6.h,
                        ),
                        createNewpassWidget(),
                        SizedBox(
                          height: 54.h,
                        ),
                        newPassTextWidget(),
                        SizedBox(
                          height: 6.h,
                        ),
                        newPassWidget(),
                        SizedBox(
                          height: 20.h,
                        ),
                        confirmNewPassTextWidget(),
                        SizedBox(
                          height: 6.h,
                        ),
                        newConfPassWidget(),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextButtonWidget(
                          btnTxt: AppString.submit,
                          onButtonTap: () {
                            onSubmitButtonTap();
                          },
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        richTextWidget(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget newPassTextWidget() {
    return Text(
      AppString.newPassword,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12.sp,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget confirmNewPassTextWidget() {
    return Text(
      AppString.confmNewPassword,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12.sp,
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
            fontSize: 14.sp,
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
                fontSize: 14.sp,
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
        if (val == null || val == "" || val == '') {
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
        if (val == null || val == "" || val == '') {
          return AppUtilities(context)
              .showTextSnackBar(' * Confirm Password Required');
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
        fontSize: 12.sp,
        color: AppColors.kFontColor,
      ),
    );
  }

  Widget resetPassWidget() {
    return Text(
      AppString.resetPassword,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 20.sp,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }
}
