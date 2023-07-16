import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/educational_list_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddExperience/experience_list_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class AddExperienceScreen extends StatefulWidget {
  final int? index;
  final String jobTitle;
  final String companyName;
  final String companyTenureYear;
  final String companyTenureMonth;
  final bool isFromEdit;
  const AddExperienceScreen({
    super.key,
    this.index,
    this.jobTitle = '',
    this.companyName = '',
    this.companyTenureYear = '',
    this.companyTenureMonth = '',
    this.isFromEdit = false,
  });

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  FilePickerResult? result;
  PlatformFile? file;
  String fileName = '';
  String filePath = '';
  late MentorProfileBloc mentorProfileBloc;
  GlobalKey<FormState> mentorFormKey = GlobalKey<FormState>();
  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  String salutationdropDownValue = AppString.tenYears;

  var salutationItems = [
    AppString.tenYears,
    AppString.nineYears,
    AppString.eightYears,
    AppString.sevenYears,
    AppString.sixYears,
    AppString.fiveYears,
    AppString.fourYears,
    AppString.thereeYears,
    AppString.twoYears,
    AppString.oneYears,
    AppString.moreYears,
  ];

  onUploadCV() async {
    result = await FilePicker.platform.pickFiles(
        // allowedExtensions: ['pdf', 'doc'],
        );

    if (result != null) {
      file = result!.files.first;

      setState(() {
        fileName = file!.name;
        filePath = file!.path!;
      });
      mentorProfileBloc.add(MentorResumeUploadEvent(fileName, filePath));
    } else {
      return;
    }
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onUpdateBtnTap() {
    String jobTitle = jobTitleController.text;
    String companyName = companyNameController.text;
    String tenureInYears = yearsController.text;
    String tenureInMonths = monthController.text;

    int actualTenureInYear = int.parse(tenureInYears);
    int actualTenureInMonth = int.parse(tenureInMonths);
    String salutationDrop = salutationdropDownValue;
    String aStr = salutationDrop.replaceAll(RegExp(r'[^0-9]'), '');
    int tenureInIntManage = int.parse(aStr);

    mentorProfileBloc.add(
      UpdateMentorExperienceEvent(
        widget.index!,
        jobTitle,
        companyName,
        actualTenureInYear,
        actualTenureInMonth,
        tenureInIntManage,
      ),
    );
  }

  onNextButtonTap() {
    _removeFocus();
    final bool? isMentorValid = mentorFormKey.currentState?.validate();
    String jobTitle = jobTitleController.text;
    String companyName = companyNameController.text;
    String companyTenureInYear = yearsController.text;
    String companyTenureInMonth = monthController.text;
    String salutationDrop = salutationdropDownValue;

    int tenureInIntYear = int.parse(companyTenureInYear);
    int tenureInIntMonth = int.parse(companyTenureInMonth);

    String aStr = salutationDrop.replaceAll(RegExp(r'[^0-9]'), '');
    int tenureInIntManage = int.parse(aStr);

    if (isMentorValid == true) {
      mentorProfileBloc.add(
        MentorAddExperienceEvent(
          jobTitle,
          companyName,
          tenureInIntYear,
          tenureInIntMonth,
          tenureInIntManage,
        ),
      );
    } else {
      print('LINE 129 : $isMentorValid');
    }
  }

  navigateToExperienceScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ExperienceListScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    jobTitleController.text = widget.jobTitle;
    companyNameController.text = widget.companyName;
    yearsController.text = widget.companyTenureYear;
    monthController.text = widget.companyTenureMonth;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: appBarWidget(),
      body: SingleChildScrollView(
        child: Column(
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
            resumeUploadWidget(),
            SizedBox(
              height: 20.h,
            ),
            dividerWidget(),
            SizedBox(
              height: 30.h,
            ),
            positionWidget(),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget positionWidget() {
    return BlocConsumer<MentorProfileBloc, MentorProfileState>(
      listener: (context, state) {
        if (state is MentorAddExperienceCompletedState) {
          jobTitleController.clear();
          companyNameController.clear();
          yearsController.clear();
          monthController.clear();
          fileName = '';
          AppUtilities(context).showTextSnackBar(state.response.message);
          navigateToExperienceScreen();
        } else if (state is MentorAddExperienceFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is UpdateMentorExperienceCompletedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);

          navigateToExperienceScreen();
        } else if (state is UpdateMentorExperienceFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        }
      },
      builder: (context, state) {
        if (state is MentorAddExperienceLoadingState) {
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
            child: Form(
              key: mentorFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.position,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppString.jobTitle,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  TextFormFieldWidget(
                    controller: jobTitleController,
                    isPasswordField: false,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == '') {
                        return AppUtilities(context)
                            .showTextSnackBar('* Job Title Required');
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppString.companyName,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  TextFormFieldWidget(
                    controller: companyNameController,
                    isPasswordField: false,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == '') {
                        return AppUtilities(context)
                            .showTextSnackBar('* Company Name Required');
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppString.companyTenure,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: yearsController,
                          hint: AppString.enterYear,
                          isPasswordField: false,
                          inputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {},
                          validator: (val) {
                            if (val == null || val == '') {
                              return AppUtilities(context)
                                  .showTextSnackBar('* Required');
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: monthController,
                          isPasswordField: false,
                          hint: AppString.enterMonths,
                          inputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {},
                          validator: (val) {
                            if (val == null || val == '') {
                              return AppUtilities(context)
                                  .showTextSnackBar('* Required');
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppString.positionInManage,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    height: 40,
                    width: 335,
                    decoration: BoxDecoration(
                      color: AppColors.kDropDownBackColor.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      border: Border.all(
                        color: AppColors.kGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 22.5,
                        right: 22.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: AppColors.kWhiteColor,
                                value: salutationdropDownValue,
                                icon: SvgPicture.asset(
                                  AppImages.icDropDownSvg,
                                  fit: BoxFit.cover,
                                ),
                                items: salutationItems.map(
                                  (String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: MavenTextStyles.nunitoRegular
                                            .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.ksignInColor,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    salutationdropDownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextButtonWidget(
                    btnTxt: AppString.next,
                    onButtonTap: () {
                      widget.isFromEdit ? onUpdateBtnTap() : onNextButtonTap();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
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

  Widget resumeUploadWidget() {
    return BlocConsumer<MentorProfileBloc, MentorProfileState>(
      listener: (context, state) {
        if (state is UploadMentorResumeCompletedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        } else if (state is UploadMentorResumeFailedState) {
          AppUtilities(context).showTextSnackBar(state.response.message);
        }
      },
      builder: (context, state) {
        if (state is UploadMentorResumeLoadingState) {
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              onUploadCV();
            },
            child: fileName == ''
                ? Container(
                    height: 80,
                    width: 335.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.kTextFieldBorderColor,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.icUpload,
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.uplodCV,
                                    style:
                                        MavenTextStyles.nunitoSemiBold.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.kWelcomeBackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    AppString.allType,
                                    style:
                                        MavenTextStyles.nunitoRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColors.kFontColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
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
                            fileName!,
                            style: MavenTextStyles.nunitoSemiBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kWelcomeBackColor,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
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
