import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetCadreListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetMentorDomainListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/AddBankAccount/add_bank_details_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/OtherDetails/widgets/chosed_item_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/OtherDetails/widgets/select_domain_item_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_button_widget.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/text_form_field_widget.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_utilities.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class AddOtherDetailsScreen extends StatefulWidget {
  const AddOtherDetailsScreen({super.key});

  @override
  State<AddOtherDetailsScreen> createState() => _AddOtherDetailsScreenState();
}

class _AddOtherDetailsScreenState extends State<AddOtherDetailsScreen> {
  TextEditingController driveMentorController = TextEditingController();
  TextEditingController sessionController = TextEditingController();
  String dropDownValue = AppString.yes;
  late MentorProfileBloc mentorProfileBloc;
  var cadreTitle;
  List<String> newCadreList = [];
  String cadreeDropDownValue = AppString.lowerManage;
  List<CadreData>? cadreList = [];
  List<Map<String, dynamic>> cadreData = [];
  List<Map<String, dynamic>> domainData = [];

  List<String> userCadreChecked = [];
  List<String> userDomainChecked = [];
  List<DomainData>? domainListData = [];

  void onDomainSelected(
      bool selected, int id, String dataName, StateSetter mystate) {
    if (selected == true) {
      mystate(() {
        domainData.add({
          'id': id,
        });
        userDomainChecked.add(dataName);
      });
    } else {
      mystate(() {
        userDomainChecked.remove(dataName);
      });
    }
  }

  void onCadreSelected(
      bool selected, int id, String dataName, StateSetter mystate) {
    if (selected == true) {
      mystate(() {
        cadreData.add({
          'id': id,
        });
        userCadreChecked.add(dataName);
      });
    } else {
      mystate(() {
        print('LINE 68 : $cadreData');
        userCadreChecked.remove(dataName);
      });

      print('LINE 74 : $userCadreChecked');
    }
  }

  onCadreDoneBtnTap() {
    Navigator.of(context).pop();
    print('LINE 70 : $cadreData');
  }

  var items = [
    AppString.yes,
    AppString.no,
  ];

  onCancelTap() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    mentorProfileBloc = BlocProvider.of<MentorProfileBloc>(context);
    super.initState();
    getCadreList();
    getDomainList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCadreList() {
    mentorProfileBloc.add(GetMentorCadreListLoadingEvent());
  }

  getDomainList() {
    mentorProfileBloc.add(GetMentorDomainListLoadingEvent());
  }

  navigateToBankDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddBankDetailsScreen();
        },
      ),
    );
  }

  onSaveButtonTap() {
    // print(cadreeDropDownValue);

    String mentorPurpose = driveMentorController.text;
    String sessionaMonth = sessionController.text;
    int sessionNo = int.parse(sessionaMonth);

    mentorProfileBloc.add(AddMentorOtherDetailsEvent(
      mentorPurpose,
      dropDownValue,
      sessionNo,
      cadreData,
      domainData,
    ));
  }

  onCloseTap() {
    Navigator.pop(context);
  }

  onDomainCloseTap() {
    Navigator.pop(context);
  }

  onDomainDoneBtnTap() {
    Navigator.pop(context, domainData);
    setState(() {});
  }

  onDoneBtnTap() {
    Navigator.of(context).pop();
  }

  onBackButtonTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: appBarWidget(),
      body: BlocConsumer<MentorProfileBloc, MentorProfileState>(
        listener: (context, state) {
          if (state is GetMentorCadreListLoadingCompletedState) {
            cadreList = state.response.data;
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is GetMentorCadreListLoadingFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is GetMentorDomainListLoadingCompletedState) {
            domainListData = state.response.data;
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is GetMentorDomainListLoadingFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          } else if (state is MentorAddOtherDetailsCompletedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
            driveMentorController.clear();
            sessionController.clear();
            navigateToBankDetails();
          } else if (state is MentorAddOtherDetailsFailedState) {
            AppUtilities(context).showTextSnackBar(state.response.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
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
                formDataWidget(cadreList, domainListData),
                SizedBox(
                  height: 108.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: TextButtonWidget(
                    btnTxt: AppString.save,
                    onButtonTap: () {
                      onSaveButtonTap();
                    },
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget formDataWidget(
      List<CadreData>? cadreListData, List<DomainData>? domainListData) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.driveMentor,
            style: MavenTextStyles.nunitoSemiBold.copyWith(
              fontSize: 12.sp,
              color: AppColors.kBlackColor,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: AppColors.kDropDownBackColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  width: 1,
                  color: AppColors.kDropDownBackColor,
                )),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(
                  left: 22.w,
                  top: 10.h,
                  bottom: 20.h,
                  right: 22.w,
                ),
                border: InputBorder.none,
              ),
              controller: driveMentorController,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.bottom,
              cursorColor: AppColors.kFontColor.withOpacity(0.3),
              autocorrect: false,
              maxLines: null,
              style: MavenTextStyles.nunitoRegular.copyWith(
                fontSize: 14.sp,
                color: AppColors.kFontColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppString.previousMentored,
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
            AppString.cadre,
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
              showCadreBottomSheet(cadreListData);
            },
            child: Container(
              height: 40.h,
              width: 335.w,
              decoration: BoxDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      AppImages.icDropDownSvg,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppString.howManySession,
            style: MavenTextStyles.nunitoSemiBold.copyWith(
              fontSize: 12.sp,
              color: AppColors.kBlackColor,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          TextFormFieldWidget(
            controller: sessionController,
            isPasswordField: false,
            inputAction: TextInputAction.next,
            onFieldSubmitted: (value) {},
            validator: (val) {
              if (val == null || val == '') {
                return AppUtilities(context).showTextSnackBar('* Required');
              }

              return null;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppString.domainExpertise,
            style: MavenTextStyles.nunitoSemiBold.copyWith(
              fontSize: 12.sp,
              color: AppColors.kBlackColor,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              showDomainBottomSheet(domainListData);
            },
            child: Container(
              height: 40.h,
              width: 335.w,
              decoration: BoxDecoration(
                // color: AppColors.kSelectedDomainBackColor,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        AppImages.icDropDownSvg,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  showCadreBottomSheet(List<CadreData>? cadreList) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.97,
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 24.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.selectCadreManage,
                        style: MavenTextStyles.bitterSemiBold.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.kWelcomeBackColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onCloseTap();
                        },
                        child: Text(
                          AppString.close,
                          style: MavenTextStyles.nunitoBold.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: AppColors.kHorizontalDividerColor,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cadreList!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                                dense: true,
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                title: Text(
                                  cadreList[index].cadreTitle!,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kWelcomeBackColor,
                                  ),
                                ),
                                trailing: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  checkColor: AppColors.kWhiteColor,
                                  activeColor: AppColors.kSelectedTabColor,
                                  value: userCadreChecked.contains(
                                    cadreList[index].cadreTitle!,
                                  ),
                                  onChanged: (val) {
                                    onCadreSelected(val!, cadreList[index].id!,
                                        cadreList[index].cadreTitle!, mystate);
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Divider(
                                color: AppColors.kTextFieldBorderColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: TextButtonWidget(
                    btnTxt: AppString.done,
                    onButtonTap: () {
                      onCadreDoneBtnTap();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  showDomainBottomSheet(List<DomainData>? domainList) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 24.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.selectExpertise,
                        style: MavenTextStyles.bitterSemiBold.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.kWelcomeBackColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onDomainCloseTap();
                        },
                        child: Text(
                          AppString.close,
                          style: MavenTextStyles.nunitoBold.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: AppColors.kHorizontalDividerColor,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: domainList!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                                dense: true,
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                title: Text(
                                  domainList[index].name!,
                                  style:
                                      MavenTextStyles.nunitoSemiBold.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kWelcomeBackColor,
                                  ),
                                ),
                                trailing: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  checkColor: AppColors.kWhiteColor,
                                  activeColor: AppColors.kSelectedTabColor,
                                  value: userDomainChecked.contains(
                                    domainList[index].name!,
                                  ),
                                  onChanged: (val) {
                                    onDomainSelected(
                                        val!,
                                        domainList[index].id!,
                                        domainList[index].name!,
                                        mystate);
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Divider(
                                color: AppColors.kTextFieldBorderColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: TextButtonWidget(
                    btnTxt: AppString.done,
                    onButtonTap: () {
                      onDomainDoneBtnTap();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          );
        });
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
        AppString.otherDetails,
        style: MavenTextStyles.bitterSemiBold.copyWith(
          fontSize: 16.sp,
          color: AppColors.kWelcomeBackColor,
        ),
      ),
    );
  }
}


// ListView.builder(
//                       itemCount: domainData.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ChosedItemWidget(selectedItemName: domainData[index], totalItemCount: totalItemCount);
//                       },
//                     ),


//  : Row(
//                     children: [
//                       ChosedItemWidget(
//                         selectedItemName: ,
//                         totalItemCount: domainData.length,
//                       ),
//                     ],
//                   ),