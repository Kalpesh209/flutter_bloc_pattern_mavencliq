import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Common/CommonSignInResponse.dart';
import 'package:mavencliq/Bloc/Common/bloc/common_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_forgot_password_screen.dart';
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
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSignInScreen extends StatefulWidget {
  const CommonSignInScreen({super.key});

  @override
  State<CommonSignInScreen> createState() => _CommonSignInScreenState();
}

class _CommonSignInScreenState extends State<CommonSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int page = 1;

  late CommonAuthBloc commonAuthBloc;
  String errorMsg = '';
  late SharedPreferenceHelper sharedPreferenceHelper;
  String? userToken;
  String? loginName;
  String? loginEmail;

  onBackButtonTap() {
     Navigator.pop(context);
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onSignInButtonTap() {
    _removeFocus();
    String emailTxt = emailController.text;
    String passTxt = passController.text;

    if(emailTxt.trim() == '') {
      commonAuthBloc.add(CommonSignInDataNotValidEvent(AppString.PLEASE_ENTER_EMAIL_ADDRESS));
    } else if(!EmailValidator.validate(emailTxt)) {
      commonAuthBloc.add(CommonSignInDataNotValidEvent(AppString.PLEASE_ENTER_VALID_EMAIL));
    } else if(passTxt.trim() == '') {
      commonAuthBloc.add(CommonSignInDataNotValidEvent(AppString.PLEASE_ENTER_PASSWORD));
    } else {
      commonAuthBloc.add(CommonSignInRequestEvent(
        emailTxt,
        passTxt,
      ));
    }
  }

  // navigateToBottomNavigationWidget() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return BottomNavigationBarWidget();
  //       },
  //     ),
  //     (route) => false,
  //   );
  // }

  navigateToSignUpScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SignUpScreen();
      },
    ));
  }

  @override
  void initState() {
    commonAuthBloc = BlocProvider.of<CommonAuthBloc>(context);
    //verifyMentorEmail();
    super.initState();
  }

  @override
  void dispose() {
    commonAuthBloc.add(CommonInitEvent());
    // Clean up resources here
    super.dispose();
  }


  // verifyMentorEmail() {
  //   var userToken =
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImthbHBlc2hAdGVjaHV6LmNvbSIsImlhdCI6MTY4NDEzMjkxOCwiZXhwIjoxNjg0MjE5MzE4fQ.kMiotdqoqq8DJ_HxFdtOZ6gGEAxF6v9Yj5Pme7jwueE';
  //   commonAuthBloc.add(MentorVerifyEmailEvent(userToken));
  // }

  setMentorLoginToken(
      String userToken, String role, String email, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MentorLoginToken', userToken);
    prefs.setString('LoginEmail', email);
    prefs.setString('LoginName', name);
  }

  setMenteeLoginToken(String userToken, String role, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MenteeLoginToken', userToken);
    prefs.setString('MenteeLoginEmail', email);
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
      body: BlocConsumer<CommonAuthBloc, CommonAuthState>(
        listener: (context, state) {
          /*if(state is CommonSignInDataNotValidState) {
            var errorMessage = state.errorMessage;
            AppUtilities(context)
                .showTextSnackBar(errorMessage);
          } else*/ if (state is CommonSignInCompletedState) {
            userToken = state.response.data!.token;
            errorMsg = '';
            AppUtilities(context).showTextSnackBar(state.response.message);
            loginEmail = state.response.data!.loginDetails!.email;
            loginName = state.response.data!.loginDetails!.fullName;
            state.response.data!.loginDetails!.role == 'Mentor'
                ? setMentorLoginToken(
                    userToken!,
                    state.response.data!.loginDetails!.role!,
                    loginEmail!,
                    loginName!,
                  )
                : setMenteeLoginToken(userToken!,
                    state.response.data!.loginDetails!.role!, loginEmail!);
            if (state.response.data!.loginDetails!.role == 'Mentor') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return BottomNavigationBarWidget();
                },
              ));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return BottomNavigationBarWidget();
                },
              ));
            }
          } /*else if (state is CommonSignInFailedState) {
            errorMsg = state.response.message;
            //return fromData();
            AppUtilities(context)
                .showTextSnackBar('Erro : $errorMsg');
          }*/
        },
        builder: (context, state) {
          if(state is CommonSignInDataNotValidState) {
            return formData(state);
          } else if (state is CommonSignInLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else if(state is CommonSignInResponseSuccess) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          }
          else if(state is CommonSignInFailedState) {
            return formData(state);
          } else if(state is CommonAuthInitial) {
            return formData(state);
          } else {
            return formData(state);
          }
        },
      ),
    );
  }

  Widget formData(CommonAuthState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: formKey,
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
              Text(
                AppString.signIn,
                style: MavenTextStyles.bitterSemiBold.copyWith(
                  fontSize: 22,
                  color: AppColors.kWelcomeBackColor,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                AppString.weAreHappy,
                style: MavenTextStyles.nunitoRegular.copyWith(
                  fontSize: 12,
                  color: AppColors.kFontColor,
                ),
              ),
              getErrorView(state),
              Text(
                AppString.emailAdd,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              TextFormFieldWidget(
                controller: emailController,
                isPasswordField: false,
                // hint: AppString.emailAdd,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                    print('TextFormField : $value');
                },
                maxline: 1,
                validator: (val) {
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppString.password,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.5,
              ),
              TextFormFieldWidget(
                controller: passController,
                isPasswordField: true,
                inputAction: TextInputAction.done,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  return null;
                },
              ),
              SizedBox(
                height: 5.5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CommonForgotPasswordScreen();
                    },
                  ));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppString.forgotPass,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.5,
              ),
              TextButtonWidget(
                onButtonTap: () {
                  onSignInButtonTap();
                },
                btnTxt: AppString.signIn,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppString.dontAccount,
                    style: MavenTextStyles.nunitoRegular.copyWith(
                      fontSize: 14,
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
                          fontSize: 14,
                          color: AppColors.kSelectedTabColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getErrorView(CommonAuthState state) {
    if(state is CommonSignInDataNotValidState || state is CommonSignInFailedState) {
      return Column(
        children: [
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.icAlertSvg,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                getErrorMessage(state),
                style: MavenTextStyles.nunitoRegular.copyWith(
                  fontSize: 12,
                  color: AppColors.kServerErrorColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 14,
          )
        ],
      );
    } else {
      return SizedBox(
        height: 30,
      );
    }
  }

  String getErrorMessage(CommonAuthState state) {
    if(state is CommonSignInDataNotValidState) {
      return state.errorMessage;
    } else {
      return AppString.YOU_HAVE_ENTERED_AN_INCORRECT_EMAIL_PASSWORD;
    }
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
