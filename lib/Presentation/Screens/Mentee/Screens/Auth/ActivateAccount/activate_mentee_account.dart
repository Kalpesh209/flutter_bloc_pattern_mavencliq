import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/SendMenteeEmail/bloc/send_mentee_email_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SendEmailVerification/bloc/send_email_verification_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ActivateAccount/account_vertified_success_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:flutter/gestures.dart';

class ActivateMenteeAccountScreen extends StatefulWidget {
  final String emailTxt;
  const ActivateMenteeAccountScreen({
    Key? key,
    required this.emailTxt,
  }) : super(key: key);

  @override
  State<ActivateMenteeAccountScreen> createState() =>
      _ActivateMenteeAccountScreenState();
}

class _ActivateMenteeAccountScreenState
    extends State<ActivateMenteeAccountScreen> {
  TextEditingController emailController = TextEditingController();
  late SendMenteeEmailBloc sendMenteeEmailBloc;
  @override
  void initState() {
    sendMenteeEmailBloc = BlocProvider.of<SendMenteeEmailBloc>(context);
    sentEmailVerification();
    super.initState();
  }

  sentEmailVerification() async {
    String email = widget.emailTxt;
    sendMenteeEmailBloc.add(MenteeSendEmailVerificationEvent(email));
  }

  onResendEmailTap() {
    String email = widget.emailTxt;
    sendMenteeEmailBloc.add(MenteeSendEmailVerificationEvent(email));
  }

  onTryAnotherTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kWhiteColor,
    ));
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: BlocConsumer<SendEmailVerificationBloc, SendEmailVerificationState>(
        listener: (context, state) {
          if (state is SendEmailVerificationCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is SendEmailVerificationFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is SendEmailVerificationLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return Padding(
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
                  SizedBox(
                    height: 6.h,
                  ),
                  activateTextWidget(),
                  SizedBox(
                    height: 6.h,
                  ),
                  weSendTextWidget(),
                  SizedBox(
                    height: 30.h,
                  ),
                  resendWidget(),
                ],
              ),
            );
          }
        },
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

  Widget resendWidget() {
    return GestureDetector(
      onTap: () {
        onResendEmailTap();
      },
      child: RichText(
        text: TextSpan(
          text: AppString.didnot,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 12.sp,
            color: AppColors.ksignInColor,
          ),
          children: [
            TextSpan(
              text: AppString.resendLink,
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

  // Widget openEmailAppButtonWidget() {
  //   return TextButtonWidget(
  //     btnTxt: AppString.sendEmailVerification,
  //     onButtonTap: () {
  //       onSendEmailTap();
  //     },
  //   );
  // }

  Widget activateTextWidget() {
    return Text(
      AppString.activateYourAccount,
      style: MavenTextStyles.bitterSemiBold.copyWith(
        fontSize: 22.sp,
        color: AppColors.kWelcomeBackColor,
      ),
    );
  }

  Widget weSendTextWidget() {
    return Text(
      AppString.weSentEmail,
      style: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 12.sp,
        color: AppColors.kFontColor,
      ),
    );
  }
}
