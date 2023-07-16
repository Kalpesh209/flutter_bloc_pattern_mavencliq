import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetExperienceListResponseSuccess.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddExperience/add_experience_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddExperience/widgets/experience_list_item_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/OtherDetails/add_other_details_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class ExperienceListScreen extends StatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  late MentorProfileBloc mentorProfileBloc;
  String resumeName = '';
  List<Experience>? experienceList = [];

  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    getResume();
    getExperienceList();
    super.initState();
  }

  getExperienceList() async {
    mentorProfileBloc.add(GetMentorExperienceListLoadingEvent());
  }

  getResume() async {
    mentorProfileBloc.add(GetMentorResumeLoadingEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  onAddMoreTap() {
    Navigator.of(context).pop();
  }

  onDeleteResumeTap() {
    mentorProfileBloc.add(DeleteMentorResumeEvent());
  }

  onExperieceEditTap(int? deleteIndex) {}

  onExperienceDeleteTap(int? deleteIndex) {
    mentorProfileBloc.add(DeleteMentorExperienceEvent(deleteIndex));
    getExperienceList();
  }

  void sendDataBack(
    BuildContext context,
    int index,
    String jobTitle,
    String companyName,
    String companyTenureInYear,
    String companyTenureInMonth,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddExperienceScreen(
          index: index,
          jobTitle: jobTitle,
          companyName: companyName,
          companyTenureYear: companyTenureInYear,
          companyTenureMonth: companyTenureInMonth,
          isFromEdit: true,
        ),
      ),
    );
  }

  onNextButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddOtherDetailsScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: appBarWidget(),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              color: AppColors.kHorizontalDividerColor,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: uploadedResumeWidget(),
          ),
          SizedBox(
            height: 20.h,
          ),
          dividerWidget(),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: positionWidget(),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: listPositionWidget(),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: addMoreWidget(),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: TextButtonWidget(
              btnTxt: AppString.next,
              onButtonTap: () {
                onNextButtonTap();
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }

  Widget addMoreWidget() {
    return GestureDetector(
      onTap: () {
        onAddMoreTap();
      },
      child: Text(
        AppString.addMore,
        style: MavenTextStyles.nunitoBold.copyWith(
          fontSize: 14.sp,
          color: AppColors.kSelectedTabColor,
        ),
      ),
    );
  }

  Widget listPositionWidget() {
    return BlocConsumer<MentorProfileBloc, MentorProfileState>(
      listener: (context, state) {
        if (state is GetMentorExperienceListLoadingCompletedState) {
          experienceList = state.response.data!.experience!;

          print('LINE 192 : $experienceList');

          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is GetMentorExperienceListLoadingFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is DeleteMentorExperienceCompletedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is DeleteMentorExperienceFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: experienceList!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return experienceList!.isEmpty == true
                      ? Text(
                          AppString.noDataFound,
                          style: MavenTextStyles.nunitoBold.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kSelectedTabColor,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: ExperienceListItemWidget(
                            positionName: experienceList![index].jobTitle!,
                            organisationName:
                                experienceList![index].companyName!,
                            positionTenure: experienceList![index].tenureYears!,
                            onDeleteTap: () {
                              onExperienceDeleteTap(experienceList![index].id);
                            },
                            onEditTap: () {
                              sendDataBack(
                                context,
                                experienceList![index].id!,
                                experienceList![index].jobTitle!,
                                experienceList![index].companyName!,
                                experienceList![index].tenureYears!,
                                experienceList![index].tenureMonths!,
                              );
                              onExperieceEditTap(experienceList![index].id);
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget positionWidget() {
    return Text(
      AppString.position,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 16.sp,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget dividerWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: Container(
        height: 1.h,
        decoration: BoxDecoration(
          color: AppColors.kHorizontalDividerColor,
        ),
      ),
    );
  }

  Widget uploadedResumeWidget() {
    return BlocConsumer<MentorProfileBloc, MentorProfileState>(
      listener: (context, state) {
        if (state is GetMentorResumeLoadingCompletedState) {
          resumeName = state.response.data!.resumeName!;
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is GetMentorResumeLoadingFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is DeleteMentorResumeCompletedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is DeleteMentorResumeFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        }
      },
      builder: (context, state) {
        if (state is GetMentorResumeLoadingState) {
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            ),
          );
        } else if (state is DeleteMentorResumeCompletedState) {
          return SizedBox();
        } else {
          return Container(
            height: 60.h,
            width: 335.w,
            decoration: BoxDecoration(
              color: AppColors.kUploadPhotoColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.icResume,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    resumeName,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.kWelcomeBackColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      onDeleteResumeTap();
                    },
                    child: Image.asset(
                      AppImages.icDelete,
                      height: 15,
                      width: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColors.kWhiteColor,
      leading: GestureDetector(
        onTap: () {
          onBackButtonTap();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Image.asset(
            AppImages.icBack,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      title: Text(
        AppString.experieceDetails,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 16.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
    );
  }
}
