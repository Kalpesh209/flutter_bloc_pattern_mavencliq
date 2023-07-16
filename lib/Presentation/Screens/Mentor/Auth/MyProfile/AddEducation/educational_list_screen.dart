import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetEducationListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/add_educational_details.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/widgets/educational_details_list_item_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddExperience/add_experience_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class EducationalListScreen extends StatefulWidget {
  const EducationalListScreen({
    super.key,
  });

  @override
  State<EducationalListScreen> createState() =>
      _EducationalItemListWidgetState();
}

class _EducationalItemListWidgetState extends State<EducationalListScreen> {
  late MentorProfileBloc mentorProfileBloc;
  List<Education>? educationList = [];
  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    getMentorEducationList();
    super.initState();
  }

  getMentorEducationList() async {
    mentorProfileBloc.add(GetMentorEducationListLoadingEvent());
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

  onNextButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddExperienceScreen();
        },
      ),
    );
  }

  onDeleteAcademicDetailTap(int deleteIndex) {
    mentorProfileBloc.add(DeleteMentorEducationEvent(deleteIndex));
    getMentorEducationList();
  }

  void sendDataBack(BuildContext context, int index, String degree,
      String institute, String passYear) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEducationalDetailsScreen(
          index: index,
          degreeName: degree,
          instituteName: institute,
          passingYear: passYear,
          isFromEdit: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: appBarWidget(),
      body: BlocConsumer<MentorProfileBloc, MentorProfileState>(
        listener: (context, state) {
          if (state is GetMenttorEducationListLoadingCompletedState) {
            educationList = state.response.data!.education;
            //AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is GetMenttorEducationListLoadingFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is DeleteMentorEducationCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is DeleteMentorEducationFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is GetMentorEducationListLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                listItemWidget(),
                Expanded(child: Container()),
                onNextButtonWidget(),
                SizedBox(
                  height: 12.h,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget listItemWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: academicDetailsWidget(),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                listEducationWidget(educationList),
              ],
            ),
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
        ],
      ),
    );
  }

  Widget onNextButtonWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: TextButtonWidget(
        btnTxt: AppString.next,
        onButtonTap: () {
          onNextButtonTap();
        },
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

  Widget listEducationWidget(List<Education>? educationList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: educationList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: EducationalDetailsListItemWidget(
            degreeName: educationList[index].degree!,
            instituteName: educationList[index].instituteName!,
            yearName: educationList[index].passingYear!,
            onDeleteTap: () {
              onDeleteAcademicDetailTap(educationList[index].id!);
            },
            onEditTap: () {
              sendDataBack(
                context,
                educationList[index].id!,
                educationList[index].degree!,
                educationList[index].instituteName!,
                educationList[index].passingYear!,
              );
            },
          ),
        );
      },
    );
  }

  Widget academicDetailsWidget() {
    return Text(
      AppString.academicDetails,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 16.sp,
        color: AppColors.kBlackColor,
      ),
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
        AppString.eduDetails,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 16.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
    );
  }
}
