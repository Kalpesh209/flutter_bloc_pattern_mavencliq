import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/educational_list_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class AddEducationalDetailsScreen extends StatefulWidget {
  final int? index;
  final String degreeName;
  final String instituteName;
  final String passingYear;
  final bool isFromEdit;

  const AddEducationalDetailsScreen({
    super.key,
    this.index,
    this.degreeName = '',
    this.instituteName = '',
    this.passingYear = '',
    this.isFromEdit = false,
  });

  @override
  State<AddEducationalDetailsScreen> createState() =>
      _AddEducationalDetailsScreenState();
}

class _AddEducationalDetailsScreenState
    extends State<AddEducationalDetailsScreen> {
  TextEditingController degreeController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  late MentorProfileBloc mentorProfileBloc;
  GlobalKey<FormState> mentorFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    degreeController.text = widget.degreeName;
    instituteController.text = widget.instituteName;
    //  salutationdropDownValue = widget.passingYear;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  var salutationItems = [
    AppString.twentytwoText,
    AppString.twenty1Text,
    AppString.twentytwentyText,
    AppString.twenty19Txt,
    AppString.twenty18Txt,
    AppString.twenty17Txt,
    AppString.twenty16Txt,
    AppString.twenty15Txt,
    AppString.twenty14Txt,
    AppString.twenty13Txt,
    AppString.twenty12Txt,
  ];

  String salutationdropDownValue = AppString.twentytwoText;

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onUpdateBtnTap() {
    String degree = degreeController.text;
    String intitute = instituteController.text;
    String salutationDrop = salutationdropDownValue;

    mentorProfileBloc.add(
      UpdateMentorEducationEvent(
        widget.index!,
        degree,
        salutationDrop,
        intitute,
      ),
    );
  }

  onSaveButtonTap() {
    _removeFocus();
    String degree = degreeController.text;
    String intitute = instituteController.text;
    String salutationDrop = salutationdropDownValue;
    mentorProfileBloc.add(AddMentorEducationInfoEvent(
      degree,
      salutationDrop,
      intitute,
    ));
    // final bool? isMentorValid = mentorFormKey.currentState?.validate();

    // if (isMentorValid == true) {
    //   mentorProfileBloc.add(AddMentorEducationInfoEvent(
    //     degree,
    //     salutationDrop,
    //     intitute,
    //   ));
    // } else {
    //   print('LINE 129 : $isMentorValid');
    // }
  }

  navigateToEducationalListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EducationalListScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhiteColor,
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(),
        body: BlocConsumer<MentorProfileBloc, MentorProfileState>(
          listener: (context, state) {
            print('LINE 138 : $state');
            if (state is MentorAddEducationalInfoCompletedState) {
              degreeController.clear();
              instituteController.clear();
              AppUtilities(context).showTextSnackBar(state.response.message);
              navigateToEducationalListScreen();
            } else if (state is MentorAddEducationalInfoFailedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
            } else if (state is UpdateMentorEducationCompletedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
              navigateToEducationalListScreen();
            } else if (state is UpdateMentorEducationFailedState) {
              AppUtilities(context).showTextSnackBar(state.response.message);
            }
          },
          builder: (context, state) {
            if (state is MentorAddEducationalInfoLoadingState) {
              return SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              );
            } else {
              return Form(
                key: mentorFormKey,
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
                      child: academicDegreeWidget(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                      ),
                      child: TextFormFieldWidget(
                        controller: degreeController,
                        isPasswordField: false,
                        inputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {},
                        validator: (val) {
                          // if (val == null || val == '') {
                          //   return AppUtilities(context)
                          //       .showTextSnackBar('* Degree Required');
                          // }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: passYearWidget(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Container(
                        height: 40,
                        width: 335.w,
                        decoration: BoxDecoration(
                          color: AppColors.kDropDownBackColor.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: instituteWidget(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: TextFormFieldWidget(
                        controller: instituteController,
                        isPasswordField: false,
                        inputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {},
                        validator: (val) {
                          // if (val == null || val == '') {
                          //   return AppUtilities(context)
                          //       .showTextSnackBar('* Institute Required');
                          // }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: TextButtonWidget(
                        btnTxt: AppString.save,
                        onButtonTap: () {
                          widget.isFromEdit
                              ? onUpdateBtnTap()
                              : onSaveButtonTap();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget passYearWidget() {
    return Text(
      AppString.yearofPassing,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12.sp,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget instituteWidget() {
    return Text(
      AppString.instName,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12.sp,
        color: AppColors.kBlackColor,
      ),
    );
  }

  Widget academicDegreeWidget() {
    return Text(
      AppString.degree,
      style: MavenTextStyles.nunitoSemiBold.copyWith(
        fontSize: 12.sp,
        color: AppColors.kBlackColor,
      ),
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
