import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Appointments/mentee_appointments_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/FindMentor/find_mentor_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/MyProfile/mentee_profile_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/MySessions/mentee_session_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentee/Screens/Request/mentee_request_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Appointment/appointment_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/MyProfile/my_profie_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/MySessions/my_sessions_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Payments/payment_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Request/request_screens.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  late PersistentTabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = PersistentTabController(initialIndex: 4);
  }

  // List<Widget> _menteeBuildScreens() {
  //   return [
  //     FindMentorScreen(),
  //     MenteeRequestScreen(),
  //     MenteeAppointmentScreen(),
  //     MenteeSessionScreen(),
  //     MenteeProfileScreen()
  //   ];
  // }

  List<Widget> _buildScreens() {
    return [
      RequestScreen(),
      AppointmentScreen(),
      MySessionsScreen(),
      PaymentScreen(),
      MyProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _menteeNavBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icRequestSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icRequestSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.requests,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icAppointmentSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icAppointmentSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.appointments,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icMysessionsSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icMysessionsSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.mySessions,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icPaymentsSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icPaymentsSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.payments,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icMyProfileSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icMyProfileSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kWelcomeBackColor,
        ),
        title: AppString.myProfile,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icRequestSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icRequestSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.requests,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icAppointmentSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icAppointmentSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.appointments,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icMysessionsSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icMysessionsSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.mySessions,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icPaymentsSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icPaymentsSvg,
          height: 24.h,
          width: 24.w,
        ),
        title: AppString.payments,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImages.icMyProfileSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kSelectedTabColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImages.icMyProfileSvg,
          height: 24.h,
          width: 24.w,
          color: AppColors.kWelcomeBackColor,
        ),
        title: AppString.myProfile,
        activeColorPrimary: AppColors.kSelectedTabColor,
        inactiveColorPrimary: AppColors.kWelcomeBackColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView.custom(
        context,
        controller: tabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        itemCount: _navBarsItems().length,
        handleAndroidBackButtonPress: true,
        stateManagement: true,
        hideNavigationBar: false,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarHeight: 56.sp,
        customWidget: (navBarEssentials) => CustomNavBarWidget(
          items: _navBarsItems(),
          onItemSelected: (index) {
            tabController.index = index;
          },
          selectedIndex: tabController.index,
        ),
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 0.0,
            left: 15.sp,
            right: 15.sp,
          ),
          child: Container(
            height: 3.0.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5.r),
              color: isSelected
                  ? (item.activeColorSecondary ?? item.activeColorPrimary)
                  : Colors.transparent,
            ),
          ),
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(
            color: AppColors.kHorizontalDividerColor,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Flexible(
                child: IconTheme(
                  data: IconThemeData(
                      size: 40.0.sp,
                      color: isSelected
                          ? (item.activeColorSecondary ??
                              item.activeColorPrimary)
                          : item.inactiveColorPrimary ??
                              item.activeColorPrimary),
                  child:
                      isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0.sp, bottom: 5.0.sp),
                child: Material(
                  type: MaterialType.transparency,
                  child: FittedBox(
                      child: Text(
                    item.title ?? "",
                    style: MavenTextStyles.nunitoBold.copyWith(
                        fontSize: 9.sp,
                        color: isSelected
                            ? (item.activeColorSecondary ??
                                item.activeColorPrimary)
                            : item.inactiveColorPrimary),
                  )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Expanded(
              child: InkWell(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
