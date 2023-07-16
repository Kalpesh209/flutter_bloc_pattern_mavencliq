import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ForgotPass/forgot_password_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignUp/sign_up_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/bottom_navigation_bar_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';

import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:mavencliq/Utils/shared_preferece_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int page = 1;

  late MentorAuthBloc mentorAuthBloc;
  String errorMsg = '';
  late SharedPreferenceHelper sharedPreferenceHelper;
  String? userToken;
  String? loginName;
  String? loginEmail;

  onBackButtonTap() {
    // Navigator.pop(context);
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onSignInButtonTap() {
    _removeFocus();
    String emailTxt = emailController.text;
    String passTxt = passController.text;
    final bool? isValid = formKey.currentState?.validate();

    if (isValid == true) {
      mentorAuthBloc.add(MentorSignInRequestEvent(
        emailTxt,
        passTxt,
      ));
    } else {
      print('LINE 61 : $isValid');
    }
  }

  navigateToBottomNavigationWidget() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return BottomNavigationBarWidget();
        },
      ),
      (route) => false,
    );
  }

  navigateToSignUpScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SignUpScreen();
      },
    ));
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    mentorAuthBloc = BlocProvider.of<MentorAuthBloc>(context);
    //verifyMentorEmail();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  setLoginToken(String userToken, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print('LINE 111 : $userToken');
    prefs.setString('MentorLoginToken', userToken);
    // prefs.setString('LoginName', name);
    prefs.setString('LoginEmail', email);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    //  final String verificationToken = args!.verification_token;
    // final String verificationToken = args!.['verification_token'];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kWhiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<MentorAuthBloc, MentorAuthState>(
        listener: (context, state) {
          if (state is MentorSignInCompletedState) {
            userToken = state.response.data!.token;
            print(state.response.data!.loginDetails);
            // loginEmail = state.response.data!.loginDetails!.email;

            /// setLoginToken(userToken!, loginEmail!);

            errorMsg = '';
            AppUtilities(context).showTextSnackBar(state.response.message);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarWidget();
              },
            ));
          } else if (state is MentorSignInFailedState) {
            errorMsg = state.response.message;
          } else if (state is MentorVerifyEmailCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is MentorVerifyEmailFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is MentorSignInLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return formData();
          }
        },
      ),
    );
  }

  Widget formData() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
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
                height: 30.h,
              ),
              Text(
                AppString.signIn,
                style: MavenTextStyles.bitterSemiBold.copyWith(
                  fontSize: 22.sp,
                  color: AppColors.kWelcomeBackColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                AppString.weAreHappy,
                style: MavenTextStyles.nunitoRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.ksignInColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                errorMsg,
                style: MavenTextStyles.nunitoRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kServerErrorColor,
                ),
              ),

              // Error
              SizedBox(
                height: 30.h,
              ),
              Text(
                AppString.emailAdd,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.5.h,
              ),
              TextFormFieldWidget(
                controller: emailController,
                isPasswordField: false,
                // hint: AppString.emailAdd,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == "" || val.trim().isEmpty) {
                    return AppUtilities(context)
                        .showTextSnackBar('* Email Required');
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                    return AppUtilities(context)
                        .showTextSnackBar('* Invalid Email Address');
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppString.password,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.5.h,
              ),
              TextFormFieldWidget(
                controller: passController,
                isPasswordField: true,
                inputAction: TextInputAction.done,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == '') {
                    return AppUtilities(context)
                        .showTextSnackBar('* Password Required');
                  } else if (val.length < 8) {
                    return AppUtilities(context).showTextSnackBar(
                        'Password must be longer than 8 characters');
                  } else if (val.length > 20) {
                    return AppUtilities(context).showTextSnackBar(
                        'Password must be shorter than 20 characters');
                  }

                  // else if (!RegExp(
                  //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  //     .hasMatch(val)) {
                  //   return AppUtilities(context).showTextSnackBar(
                  //     '* Passwords must contain one upper case, one lower case, one number and one special character',
                  //   );
                  // }

                  return null;
                },
              ),
              SizedBox(
                height: 6.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ForgotPasswordScreen();
                    },
                  ));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppString.forgotPass,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 31.h,
              ),
              TextButtonWidget(
                onButtonTap: () {
                  onSignInButtonTap();
                },
                btnTxt: AppString.signIn,
              ),
              SizedBox(
                height: 12.h,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppString.dontAccount,
                    style: MavenTextStyles.nunitoRegular.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.ksignInColor,
                    ),
                    children: [
                      TextSpan(
                        text: AppString.signUp,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigateToSignUpScreen();
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
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColors.kWhiteColor,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: GestureDetector(
          onTap: () {
            onBackButtonTap();
          },
          child: Image.asset(
            AppImages.icBack,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
