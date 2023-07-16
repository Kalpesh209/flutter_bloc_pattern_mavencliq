import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddBankAccount/add_bank_details_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/add_educational_details.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddExperience/add_experience_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddGeneralInfo/add_general_info_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/OtherDetails/add_other_details_screen.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String? loginUserEmail;
  String? loginsUserName;
  late MentorProfileBloc mentorProfileBloc;
  bool isGeneralInfoCompleted = false;
  bool isEducationInfoCompleted = false;
  bool isExperienceInfoCompleted = false;
  bool isOtherInfoCompleted = false;
  bool isBankInfoCompleted = false;
  int? profileStatusCode;
  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    getLoginData();
    getProfileStatus();
    super.initState();
  }

  getProfileStatus() async {
    mentorProfileBloc.add(GetMentorProfileStatusEvent());
  }

  getLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginUserEmail = prefs.getString('LoginEmail');
      loginsUserName = prefs.getString('LoginName');
    });
  }

  onGeneralInfoEditTap() {
    pushNewScreen(
      context,
      screen: AddGeneralInfoScreen(
        email: loginUserEmail!,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onEduInfoEditTap() {
    pushNewScreen(
      context,
      screen: AddEducationalDetailsScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onExperienceEditTap() {
    pushNewScreen(
      context,
      screen: AddExperienceScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onOtherDetailEditTap() {
    pushNewScreen(
      context,
      screen: AddOtherDetailsScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onBankDetailEditTap() {
    pushNewScreen(
      context,
      screen: AddBankDetailsScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onLogoutTap() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    navigateToSignInScreen();
  }

  navigateToSignInScreen() {
    pushNewScreen(
      context,
      screen: CommonSignInScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  onChangePasswordTap() {}

  onAppBarActionItemTap() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: CupertinoActionSheet(
          cancelButton: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.white,
              boxShadow: [
                // BoxShadow(color: Colors.green, spreadRadius: 3),
              ],
            ),
            child: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text(
                AppString.cancel,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.ksignInColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: <Widget>[
            Container(
                color: Colors.white,
                child: CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: Text(
                    AppString.changePassword,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.ksignInColor,
                    ),
                  ),
                  onPressed: () async {
                    onChangePasswordTap();
                  },
                )),
            Container(
              color: Colors.white,
              child: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: Text(
                  AppString.logout,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 15.sp,
                    color: AppColors.kProfileBackColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onLogoutTap();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kUploadPhotoColor,
      appBar: appBarWidget(),
      body: SafeArea(
        child: BlocConsumer<MentorProfileBloc, MentorProfileState>(
          listener: (context, state) {
            if (state is GetMentorProfileStatusCompletedState) {
              print(state.response);
              // AppUtilities(context).showTextSnackBar(state.response.message);
              isGeneralInfoCompleted = state.response.data!.generalInfo!;
              isEducationInfoCompleted = state.response.data!.education!;
              isExperienceInfoCompleted = state.response.data!.experience!;
              isOtherInfoCompleted = state.response.data!.otherInfo!;
              isBankInfoCompleted = state.response.data!.bankDetails!;
              profileStatusCode = state.response.statusCode;
            } else if (state is GetMentorProfileStatusFailedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        Container(
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: AppColors.kHorizontalDividerColor,
                          ),
                        ),
                        SizedBox(
                          height: 9.7.h,
                        ),
                        profileStatusWidget(),
                        SizedBox(
                          height: 20.h,
                        ),
                        profileImgWidget(),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  allInformationWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget allInformationWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * .54,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 23.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.generalInfo,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kWelcomeBackColor,
                  ),
                ),
                Row(
                  children: [
                    isGeneralInfoCompleted
                        ? Image.asset(
                            AppImages.icProfileComplete,
                            height: 22.h,
                            width: 22.w,
                          )
                        : Container(
                            height: 20.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.kProfileStatusColor,
                            ),
                            child: Center(
                              child: Text(
                                AppString.pending,
                                style: MavenTextStyles.nunitoSemiBold.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProfileBackColor,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        onGeneralInfoEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: AppColors.kHorizontalDividerColor,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.eduDetails,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kWelcomeBackColor,
                  ),
                ),
                Row(
                  children: [
                    isEducationInfoCompleted
                        ? Image.asset(
                            AppImages.icProfileComplete,
                            height: 22.h,
                            width: 22.w,
                          )
                        : Container(
                            height: 20.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.kProfileStatusColor,
                            ),
                            child: Center(
                              child: Text(
                                AppString.pending,
                                style: MavenTextStyles.nunitoSemiBold.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProfileBackColor,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        onEduInfoEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: AppColors.kHorizontalDividerColor,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.experieceDetails,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kWelcomeBackColor,
                  ),
                ),
                Row(
                  children: [
                    isExperienceInfoCompleted
                        ? Image.asset(
                            AppImages.icProfileComplete,
                            height: 22.h,
                            width: 22.w,
                          )
                        : Container(
                            height: 20.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.kProfileStatusColor,
                            ),
                            child: Center(
                              child: Text(
                                AppString.pending,
                                style: MavenTextStyles.nunitoSemiBold.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProfileBackColor,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        onExperienceEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: AppColors.kHorizontalDividerColor,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.otherDetails,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kWelcomeBackColor,
                  ),
                ),
                Row(
                  children: [
                    isOtherInfoCompleted
                        ? Image.asset(
                            AppImages.icProfileComplete,
                            height: 22.h,
                            width: 22.w,
                          )
                        : Container(
                            height: 20.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.kProfileStatusColor,
                            ),
                            child: Center(
                              child: Text(
                                AppString.pending,
                                style: MavenTextStyles.nunitoSemiBold.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProfileBackColor,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        onOtherDetailEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: AppColors.kHorizontalDividerColor,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.bankAccountDeatils,
                  style: MavenTextStyles.nunitoSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kWelcomeBackColor,
                  ),
                ),
                Row(
                  children: [
                    isBankInfoCompleted
                        ? Image.asset(
                            AppImages.icProfileComplete,
                            height: 22.h,
                            width: 22.w,
                          )
                        : Container(
                            height: 20.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.kProfileStatusColor,
                            ),
                            child: Center(
                              child: Text(
                                AppString.pending,
                                style: MavenTextStyles.nunitoSemiBold.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProfileBackColor,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        onBankDetailEditTap();
                      },
                      child: Image.asset(
                        AppImages.icEdit,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget profileImgWidget() {
    return Column(
      children: [
        Image.asset(
          AppImages.icProfilePic,
          height: 90.h,
          width: 90.w,
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          // 'Mr. Ruupesh Chugh',
          loginsUserName!,
          style: MavenTextStyles.bitterSemiBold.copyWith(
            fontSize: 14.sp,
            color: AppColors.kWelcomeBackColor,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          loginUserEmail!,
          style: MavenTextStyles.nunitoRegular.copyWith(
            fontSize: 12.sp,
            color: AppColors.kUserEmail,
          ),
        ),
      ],
    );
  }

  Widget profileStatusWidget() {
    return profileStatusCode == 200
        ? Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.kProfileCompletedStatusBackColor,
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.icProfileCompleted,
                      height: 14.h,
                      width: 14.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text(
                        AppString.profileCompleted,
                        style: MavenTextStyles.nunitoSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.kProfileTextColor,
                        ),
                      ),
                    )
                  ],
                )),
          )
        : Container(
            height: 44.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.kProfileStatusColor,
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.icProfileStatus,
                      height: 14.h,
                      width: 14.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      AppString.completeProfile,
                      style: MavenTextStyles.nunitoRegular.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kProfileBackColor,
                      ),
                    )
                  ],
                )),
          );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColors.kUploadPhotoColor,
      elevation: 0,
      title: Text(
        AppString.myProfile,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 26.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            onAppBarActionItemTap();
          },
          icon: Image.asset(
            AppImages.icMore,
            height: 25,
          ),
        )
      ],
    );
  }
}
