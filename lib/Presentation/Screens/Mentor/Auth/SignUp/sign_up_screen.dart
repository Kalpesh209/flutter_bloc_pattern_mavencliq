import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/bloc/mentee_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Auth/ActivateAccount/activate_mentee_account.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Auth/SignIn/mentee_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ActivateAccount/activate_your_account_screen.dart';

import 'package:mavencliq/Presentation/Screens/Mentor/Auth/Splash/splash_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController menteeFullNameController = TextEditingController();
  TextEditingController menteeEmailController = TextEditingController();
  TextEditingController menteePassController = TextEditingController();
  TextEditingController menteeConfirmController = TextEditingController();
  GlobalKey<FormState> menteeformKey = GlobalKey<FormState>();
  late TabController _tabController;
  bool isChecked = true;
  bool isMenteeChecked = true;
  late MentorAuthBloc mentorAuthBloc;
  late MenteeAuthBloc menteeAuthBloc;
  String errorMsg = '';
  String menteeErrorMsg = '';

  onBackButtonTap() {
    /*Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SplashScreen();
      },
    ));*/
    Navigator.pop(context);
  }

  navigateToSignInScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CommonSignInScreen();
      },
    ));
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    mentorAuthBloc = BlocProvider.of<MentorAuthBloc>(context);
    menteeAuthBloc = BlocProvider.of<MenteeAuthBloc>(context);
    super.initState();
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onMenteeSignUpTap() {
    if (isMenteeChecked == false) {
      return AppUtilities(context)
          .showTextSnackBar('Select Agree with T & C to Continue');
    } else {
      _removeFocus();
      errorMsg = '';
      String menteeFullName = menteeFullNameController.text.trim();
      String menteeEmail = menteeEmailController.text.trim();
      String menteePassword = menteePassController.text.trim();
      String menteeConfirmPass = menteeConfirmController.text.trim();
      final bool? isMenteeValid = menteeformKey.currentState?.validate();

      if (isMenteeValid == true) {
        menteeAuthBloc.add(
          MenteeSignUpRequestEvent(
            menteeFullName,
            menteeEmail,
            menteePassword,
            menteeConfirmPass,
          ),
        );
      } else {
        print('LINE 61 : $isMenteeValid');
      }
    }
  }

  onMentorSignUpTap() {
    _removeFocus();
    errorMsg = '';
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passController.text.trim();
    String confirmPass = confirmController.text.trim();
    final bool? isValid = formKey.currentState?.validate();

    if (isValid == true) {
      mentorAuthBloc.add(MentorSignUpRequestEvent(
        fullName,
        email,
        password,
        confirmPass,
      ));
    } else {
      print('LINE 61 : $isValid');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kUploadPhotoColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.kUploadPhotoColor,
      body: formData(),
    );
  }

  Widget formData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
            onTap: () {
              onBackButtonTap();
            },
            child: Image.asset(
              AppImages.icBack,
              height: 16,
              width: 21,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            AppString.signUp,
            style: MavenTextStyles.bitterSemiBold.copyWith(
              fontSize: 26,
              color: AppColors.kWelcomeBackColor,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        /*Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Text(
            menteeErrorMsg,
            style: MavenTextStyles.nunitoRegular.copyWith(
              fontSize: 12.sp,
              color: AppColors.kServerErrorColor,
            ),
          ),
        ),*/
        /*SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Text(
            errorMsg,
            style: MavenTextStyles.nunitoRegular.copyWith(
              fontSize: 12.sp,
              color: AppColors.kServerErrorColor,
            ),
          ),
        ),*/
        // SizedBox(
        //   height: 10.h,
        // ),
        TabBar(
          controller: _tabController,
          indicatorColor: AppColors.kSelectedTabColor,
          labelStyle: MavenTextStyles.nunitoBold.copyWith(
            fontSize: 16,
            color: AppColors.kSelectedTabColor,
          ),
          unselectedLabelStyle: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 16,
            color: AppColors.kFontColor,
          ),
          labelColor: AppColors.kSelectedTabColor,
          unselectedLabelColor: AppColors.kFontColor,
          tabs: [
            Tab(
              text: AppString.mentor,
            ),
            Tab(
              text: AppString.mentee,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocConsumer<MentorAuthBloc, MentorAuthState>(
                listener: (context, state) {
                  if (state is MentorSignUpCompletedState) {
                    AppUtilities(context)
                        .showTextSnackBar(state.response.message);
                    errorMsg = '';

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ActivateYourAccountScreen(
                          emailTxt: emailController.text.trim(),
                        );
                      },
                    ));
                  } else if (state is MentorSignUpFailedState) {
                    fullNameController.clear();
                    emailController.clear();
                    passController.clear();
                    confirmController.clear();
                    errorMsg = state.response.message;
                  }
                },
                builder: (context, state) {
                  if (state is MentorSignUpLoadingState) {
                    return SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    );
                  } else {
                    return LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          height: constraints.maxHeight,
                          color: AppColors.kWhiteColor,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Text(
                                      AppString.fullName,
                                      style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                        fontSize: 12,
                                        color: AppColors.kBlackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextFormFieldWidget(
                                      controller: fullNameController,
                                      isPasswordField: false,
                                      inputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {},
                                      validator: (val) {
                                        /*if (val == null || val == '') {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                                '* Full Name Required');
                                      } else if (val.length < 3) {
                                        return AppUtilities(context).showTextSnackBar(
                                            'Full Name must be longer than 3 characters');
                                      } else if (val.length > 20) {
                                        return AppUtilities(context).showTextSnackBar(
                                            'Full Name must be shorter than 20 characters');
                                      }*/
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppString.emailAdd,
                                      style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
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
                                      inputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {},
                                      validator: (val) {
                                        /* if (val == null || val == '') {
                                        return AppUtilities(context)
                                            .showTextSnackBar('* Email Required');
                                      }
                                      if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(val)) {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                                '* Invalid Email Address');
                                      }*/
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppString.password,
                                      style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                        fontSize: 12,
                                        color: AppColors.kBlackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextFormFieldWidget(
                                      controller: passController,
                                      isPasswordField: true,
                                      inputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {},
                                      validator: (val) {
                                        /*if (val == null || val == '') {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                                '* Password Required');
                                      } else if (val.length < 8) {
                                        return AppUtilities(context).showTextSnackBar(
                                            'Password must be longer than 8 characters');
                                      } else if (val.length > 20) {
                                        return AppUtilities(context).showTextSnackBar(
                                            'Password must be shorter than 20 characters');
                                      } else if (!RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(val)) {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                          '* Passwords must contain one upper case, one lower case, one number and one special character',
                                        );
                                      }*/

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppString.confirmPass,
                                      style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                        fontSize: 12,
                                        color: AppColors.kBlackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextFormFieldWidget(
                                      controller: confirmController,
                                      isPasswordField: true,
                                      inputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) {},
                                      validator: (val) {
                                        /*if (val == null || val == '') {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                                '* Confirm Password Required');
                                      } else if (val.length < 8) {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                          'Confirm Password must be longer than 8 characters',
                                        );
                                      } else if (val.length > 20) {
                                        return AppUtilities(context)
                                            .showTextSnackBar(
                                          'Confirm Password must be shorter than 20 characters',
                                        );
                                      }*/
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    /*SizedBox(
                                    width: 10,
                                  ),*/
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Checkbox(
                                            // materialTapTargetSize:
                                            //     MaterialTapTargetSize.shrinkWrap,
                                            checkColor: AppColors.kWhiteColor,
                                            activeColor:
                                            AppColors.kSelectedTabColor,
                                            value: isChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                isChecked = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: AppString.agreeWithOur,
                                            style: MavenTextStyles.nunitoRegular
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.kBlackColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: AppString.termCondition,
                                                style: MavenTextStyles.nunitoBold
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                  AppColors.kWelcomeBackColor,
                                                  decoration:
                                                  TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextButtonWidget(
                                      btnTxt: AppString.signUp,
                                      onButtonTap: () {
                                        if (isChecked == false) {
                                          return AppUtilities(context).showTextSnackBar(
                                              'Select Agree with T & C to Continue');
                                        }
                                        onMentorSignUpTap();
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          text: AppString.alreadyAccount,
                                          style: MavenTextStyles.nunitoRegular
                                              .copyWith(
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
                                              style: MavenTextStyles.nunitoBold
                                                  .copyWith(
                                                fontSize: 14,
                                                color: AppColors.kSelectedTabColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    );

                  }
                },
              ),

              // Mentee Data
              BlocConsumer<MenteeAuthBloc, MenteeAuthState>(
                listener: (context, state) {
                  if (state is MenteeSignUpCompletedState) {
                    AppUtilities(context)
                        .showTextSnackBar(state.response.message);
                    menteeErrorMsg = '';

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ActivateMenteeAccountScreen(
                          emailTxt: menteeEmailController.text.trim(),
                        );
                      },
                    ));
                  } else if (state is MenteeSignUpFailedState) {
                    menteeFullNameController.clear();
                    menteeEmailController.clear();
                    menteePassController.clear();
                    menteeConfirmController.clear();
                    menteeErrorMsg = state.response.message;
                  }
                },
                builder: (context, state) {
                  if (state is MenteeSignUpLoadingState) {
                    return SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        color: AppColors.kWhiteColor,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Form(
                            key: menteeformKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 38.h,
                                ),
                                Text(
                                  AppString.fullName,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                TextFormFieldWidget(
                                  controller: menteeFullNameController,
                                  isPasswordField: false,
                                  inputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {},
                                  validator: (val) {
                                    if (val == null || val == "" || val == '') {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                              '* Mentee Full Name Required');
                                    } else if (val.length < 3) {
                                      return AppUtilities(context).showTextSnackBar(
                                          'Mentee Full Name must be longer than 3 characters');
                                    } else if (val.length > 20) {
                                      return AppUtilities(context).showTextSnackBar(
                                          'Mentee Full Name must be shorter than 20 characters');
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  AppString.emailAdd,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                TextFormFieldWidget(
                                  controller: menteeEmailController,
                                  isPasswordField: false,
                                  inputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {},
                                  validator: (val) {
                                    if (val == null || val == "" || val == '') {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                              '* Mentee Email Required');
                                    }
                                    if (!RegExp(r'\S+@\S+\.\S+')
                                        .hasMatch(val)) {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                              '* Mentee Invalid Email Address');
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  AppString.password,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                TextFormFieldWidget(
                                  controller: menteePassController,
                                  isPasswordField: true,
                                  inputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {},
                                  validator: (val) {
                                    if (val == null || val == "" || val == '') {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                              '* Mentee Password Required');
                                    } else if (val.length < 8) {
                                      return AppUtilities(context).showTextSnackBar(
                                          'Mentee Password must be longer than 8 characters');
                                    } else if (val.length > 20) {
                                      return AppUtilities(context).showTextSnackBar(
                                          'Password must be shorter than 20 characters');
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(val)) {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                        '* Passwords must contain one upper case, one lower case, one number and one special character',
                                      );
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  AppString.confirmPass,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                TextFormFieldWidget(
                                  controller: menteeConfirmController,
                                  isPasswordField: true,
                                  inputAction: TextInputAction.done,
                                  onFieldSubmitted: (value) {},
                                  validator: (val) {
                                    if (val == null || val == "" || val == '') {
                                      return AppUtilities(context).showTextSnackBar(
                                          '* Mentee Confirm Password Required');
                                    } else if (val.length < 8) {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                        'Mentee Confirm Password must be longer than 8 characters',
                                      );
                                    } else if (val.length > 20) {
                                      return AppUtilities(context)
                                          .showTextSnackBar(
                                        'Mentee Confirm Password must be shorter than 20 characters',
                                      );
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 16.0,
                                      width: 16.0,
                                      child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        checkColor: AppColors.kWhiteColor,
                                        activeColor:
                                            AppColors.kSelectedTabColor,
                                        value: isMenteeChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isMenteeChecked = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: AppString.agreeWithOur,
                                        style: MavenTextStyles.nunitoRegular
                                            .copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.ksignInColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AppString.termCondition,
                                            style: MavenTextStyles.nunitoBold
                                                .copyWith(
                                              fontSize: 12.sp,
                                              color:
                                                  AppColors.kWelcomeBackColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextButtonWidget(
                                  btnTxt: AppString.signUp,
                                  onButtonTap: () {
                                    onMenteeSignUpTap();
                                  },
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppString.alreadyAccount,
                                      style: MavenTextStyles.nunitoRegular
                                          .copyWith(
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
                                          style: MavenTextStyles.nunitoBold
                                              .copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.kSelectedTabColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
