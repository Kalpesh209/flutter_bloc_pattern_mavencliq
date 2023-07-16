import 'dart:core';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddEducation/add_educational_details.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class AddGeneralInfoScreen extends StatefulWidget {
  final String email;
  const AddGeneralInfoScreen({
    super.key,
    required this.email,
  });

  @override
  State<AddGeneralInfoScreen> createState() => _AddGeneralInfoScreenState();
}

class _AddGeneralInfoScreenState extends State<AddGeneralInfoScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String dropDownValue = AppString.male;
  String salutationdropDownValue = AppString.mr;
  DateTime selectedDate = DateTime.now();
  late MentorProfileBloc mentorProfileBloc;
  GlobalKey<FormState> mentorFormKey = GlobalKey<FormState>();
  var _image;

  String apiErrorMsg = '';
  var croppedImagePath = '';

  String? fileName;

  var items = [
    AppString.male,
    AppString.female,
    AppString.other,
    AppString.preferNot
  ];
  var salutationItems = [
    AppString.mr,
    AppString.ms,
    AppString.mrs,
    AppString.dr,
    AppString.prof,
  ];
  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  navigateToAddEducationDetails() {
    pushNewScreen(
      context,
      screen: AddEducationalDetailsScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          'From Camera',
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          'From Gallery',
          style: TextStyle(color: Colors.blue),
        ));

    setState(() {
      _image = image;
    });
    imageCropper(_image.path);
  }

  imageCropper(String uploadedImagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: uploadedImagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop a Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    setState(() {
      croppedImagePath = croppedFile!.path;
      fileName = croppedImagePath.split('/').last;
    });
  }

  void _removeFocus() {
    AppUtilities(context).dismissKeyboard();
  }

  onSaveButtonTap() {
    _removeFocus();

    final bool? isMentorValid = mentorFormKey.currentState?.validate();
    String fullName = fullNameController.text;
    String phone = phoneController.text;
    String dob = dobController.text;
    String city = cityController.text;
    String gender = dropDownValue;
    String salutationDrop = salutationdropDownValue;

    String? file;

    if (_image == null) {
      AppUtilities(context).showTextSnackBar(AppString.uploadImage);
    } else {
      file = fileName!;
    }

    if (isMentorValid == true) {
      mentorProfileBloc.add(AddMentorAddGeneralInfoEvent(
        salutationDrop,
        fullName,
        phone,
        city,
        dob,
        gender,
        file!,
        croppedImagePath,
      ));
    } else {
      print('LINE 129 : $isMentorValid');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(selectedDate);
      dobController.text = formatted;
    }
  }

  @override
  void initState() {
    emailController.text = widget.email;
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: appBarWidget(),
      body: BlocConsumer<MentorProfileBloc, MentorProfileState>(
        listener: (context, state) {
          if (state is MentorAddGeneralInfoCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
            navigateToAddEducationDetails();
          } else if (state is MentorAddGeneralInfoFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          if (state is MentorAddGeneralInfoLoadingState) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Form(
                key: mentorFormKey,
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
                    addPhotoWidget(),
                    SizedBox(
                      height: 30.h,
                    ),
                    remainingDataWidget(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget remainingDataWidget() {
    return Form(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.salutation,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 40.h,
              width: 335.w,
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
                                  style: MavenTextStyles.nunitoRegular.copyWith(
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
            Text(
              AppString.fullName,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            TextFormFieldWidget(
              controller: fullNameController,
              isPasswordField: false,
              inputAction: TextInputAction.next,
              onFieldSubmitted: (value) {},
              validator: (val) {
                if (val == null || val == '') {
                  return AppUtilities(context)
                      .showTextSnackBar('* Full Name Required');
                } else if (val.length < 3) {
                  return AppUtilities(context).showTextSnackBar(
                      'Full Name must be longer than 3 characters');
                } else if (val.length > 20) {
                  return AppUtilities(context).showTextSnackBar(
                      'Full Name must be shorter than 20 characters');
                }

                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppString.emailAdd,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.kDisableEmail.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AbsorbPointer(
                absorbing: true,
                child: TextFormFieldWidget(
                  isRead: true,
                  controller: emailController,
                  isPasswordField: false,
                  inputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {},
                  validator: (val) {
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppString.phone,
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
                    controller: phoneController,
                    isPasswordField: false,
                    inputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {},
                    validator: (val) {
                      if (val == null || val == '') {
                        return AppUtilities(context)
                            .showTextSnackBar('* Phone Number Required');
                      }
                      if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          .hasMatch(val)) {
                        return AppUtilities(context)
                            .showTextSnackBar('* Invalid Phone Number ');
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
              AppString.city,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            TextFormFieldWidget(
              controller: cityController,
              isPasswordField: false,
              inputAction: TextInputAction.next,
              onFieldSubmitted: (value) {},
              validator: (val) {
                if (val == null || val == '') {
                  return AppUtilities(context)
                      .showTextSnackBar('* City Name Required');
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppString.gender,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 40.h,
              width: 335.w,
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
                          value: dropDownValue,
                          icon: SvgPicture.asset(
                            AppImages.icDropDownSvg,
                            fit: BoxFit.cover,
                          ),
                          items: items.map(
                            (String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: MavenTextStyles.nunitoRegular.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.ksignInColor,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
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
            Text(
              AppString.dob,
              style: MavenTextStyles.nunitoSemiBold.copyWith(
                fontSize: 12.sp,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: TextFormFieldWidget(
                  controller: dobController,
                  isPasswordField: false,
                  suffixIcon: SvgPicture.asset(
                    AppImages.icCalenderSvg,
                    fit: BoxFit.scaleDown,
                  ),
                  inputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {},
                  validator: (val) {
                    if (val == null || val == '') {
                      return AppUtilities(context)
                          .showTextSnackBar('* DOB Required');
                    }

                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            TextButtonWidget(
              btnTxt: AppString.save,
              onButtonTap: () {
                onSaveButtonTap();
              },
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget addPhotoWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: _image != null
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _image = null;
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.kTransparent,
                    backgroundImage: FileImage(
                      File(
                        croppedImagePath,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.5.h,
                  ),
                  Text(
                    AppString.removeProfilePhoto,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.kSelectedTabColor,
                    ),
                  )
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                getImage(ImgSource.Both);
              },
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.kUploadPhotoColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        AppImages.icCamera,
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.5.h,
                  ),
                  Text(
                    AppString.addProfilePhoto,
                    style: MavenTextStyles.nunitoSemiBold.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.kSelectedTabColor,
                    ),
                  )
                ],
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
            height: 16,
            width: 22,
          ),
        ),
      ),
      title: Text(
        AppString.generalInfo,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 16.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
    );
  }
}
