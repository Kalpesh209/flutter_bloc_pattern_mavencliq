import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/bottom_navigation_bar_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class AddBankDetailsScreen extends StatefulWidget {
  const AddBankDetailsScreen({super.key});

  @override
  State<AddBankDetailsScreen> createState() => _AddBankDetailsScreenState();
}

class _AddBankDetailsScreenState extends State<AddBankDetailsScreen> {
  late MentorProfileBloc mentorProfileBloc;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController panController = TextEditingController();
  GlobalKey<FormState> mentorFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  navigateToProfileScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return BottomNavigationBarWidget();
        },
      ),
      (route) => false,
    );
  }

  onSaveBtnTap() {
    _removeFocus();
    final bool? isMentorValid = mentorFormKey.currentState?.validate();
    String accountNo = accountNumberController.text;
    String accountName = accountNameController.text;
    String ifscCode = ifscController.text;
    String panNo = panController.text;
    if (isMentorValid == true) {
      mentorProfileBloc.add(
        AddMentorBankDetailsEvent(accountNo, accountName, ifscCode, panNo),
      );
    } else {
      print('LINE 129 : $isMentorValid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(),
      body: BlocConsumer<MentorProfileBloc, MentorProfileState>(
        listener: (context, state) {
          if (state is MentorAddBankDetailsCompletedState) {
            accountNumberController.clear();
            accountNameController.clear();
            ifscController.clear();
            panController.clear();
            AppUtilities(context).showTextSnackBar(state.response.message);
            navigateToProfileScreen();
          } else if (state is MentorAddBankDetailsFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is MentorAddBankDetailsLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  color: AppColors.kHorizontalDividerColor,
                ),
              ),
              bankDetailsWidget(),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: TextButtonWidget(
                  btnTxt: AppString.save,
                  onButtonTap: () {
                    onSaveBtnTap();
                  },
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bankDetailsWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: SingleChildScrollView(
        child: Form(
          key: mentorFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                AppString.bankAccountNumber,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormFieldWidget(
                controller: accountNumberController,
                isPasswordField: false,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == '') {
                    return AppUtilities(context)
                        .showTextSnackBar('* Account No Required');
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppString.bankaccountHolderName,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormFieldWidget(
                controller: accountNameController,
                isPasswordField: false,
                textInputType: TextInputType.text,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == '') {
                    return AppUtilities(context)
                        .showTextSnackBar('* Name Required');
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppString.ifscCode,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormFieldWidget(
                controller: ifscController,
                isPasswordField: false,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == '') {
                    return AppUtilities(context)
                        .showTextSnackBar('* IFSC Required');
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                AppString.panDetails,
                style: MavenTextStyles.nunitoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.kBlackColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormFieldWidget(
                controller: panController,
                isPasswordField: false,
                inputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                validator: (val) {
                  if (val == null || val == '') {
                    return AppUtilities(context)
                        .showTextSnackBar('* Pan Required');
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
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
        AppString.bankAccountDeatils,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 16.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
    );
  }
}
