import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/GetStarted/get_started_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/widgets/bottom_navigation_bar_widget.dart';

import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? splashToken = prefs.getString('MentorLoginToken');
    if (splashToken == null) {
      navigateToLogin();
    } else {
      navigateToBottomNavigation();
    }
  }

  navigateToLogin() {
    return Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return GetStartedScreen();
        },
      ), (route) => false);
    });
  }

  navigateToBottomNavigation() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return BottomNavigationBarWidget();
      },
    ), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
        color: AppColors.kPrimaryColor,
        child: Center(
          child: Image.asset(
            AppImages.icMaven,
            height: 52.h,
          ),
        ),
      ),
    );
  }
}
