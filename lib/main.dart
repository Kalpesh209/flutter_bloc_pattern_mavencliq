import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mavencliq/Bloc/Common/bloc/common_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/SendMenteeEmail/bloc/send_mentee_email_bloc.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/bloc/mentee_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/bloc/mentor_auth_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SendEmailVerification/bloc/send_email_verification_bloc.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/bloc/mentor_profile_bloc.dart';
import 'package:mavencliq/Presentation/Screens/Common/common_sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/ActivateAccount/account_vertified_success_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/SignIn/sign_in_screen.dart';
import 'package:mavencliq/Presentation/Screens/Mentor/Auth/Splash/splash_screen.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _deeplink;
  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  void initUniLinks() async {
    // Listen for incoming deep links
    try {
      _deeplink = await getInitialLink();
      if (_deeplink != null) {
        // Handle the deep link
        handleDeepLink(_deeplink!);
      }
    } on PlatformException {
      _deeplink = null;
    }

    // Set up a stream to listen for future deep links
    linkStream.listen((String? deeplink) {
      if (deeplink != null) {
        // Handle the deep link
        handleDeepLink(deeplink);
      }
    }, onError: (err) {
      print(err);
    });
  }

  void handleDeepLink(String deeplink) {
    // Handle the deep link here

    // http://172.16.16.49:3000/auth/verify-email/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtvbWFuYTY5OTBAYWljb2d6LmNvbSIsImlhdCI6MTY4NDMzNTc0MywiZXhwIjoxNjg0NDIyMTQzfQ.O9AVkXeKIXh15xwNXJ1sTd6T-U0qE0FpPB5ZF5QJHXQ

    // http://172.16.16.49:3000/auth/reset-password/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtvbWFuYTY5OTBAYWljb2d6LmNvbSIsImlhdCI6MTY4NDMzNTc0MywiZXhwIjoxNjg0NDIyMTQzfQ.O9AVkXeKIXh15xwNXJ1sTd6T-U0qE0FpPB5ZF5QJHXQ
    if (deeplink.startsWith('http://54.79.104.40/auth/congratulations')) {
      // Extract the verification token from the URL
      String token =
          deeplink.substring('http://54.79.104.40/auth/congratulations'.length);
      // Navigate to the login screen and pass the token as an argument

      Navigator.pushNamed(context, '/AccountVerifiedSuccessScreen',
          arguments: {'verification_token': token});
    }

    // For Reset password change URL

    if (deeplink.startsWith('http://54.79.104.40/auth/reset-password/')) {
      // Extract the verification token from the URL
      String token =
          deeplink.substring('http://54.79.104.40/auth/reset-password/'.length);
      // Navigate to the login screen and pass the token as an argument

      Navigator.pushNamed(context, '/commonSignIn',
          arguments: {'verification_token': token});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MentorAuthBloc()),
        BlocProvider(create: (context) => CommonAuthBloc()),
        BlocProvider(create: (context) => SendEmailVerificationBloc()),
        BlocProvider(create: (context) => MenteeAuthBloc()),
        BlocProvider(
          create: (context) => SendMenteeEmailBloc(),
        ),
        BlocProvider(
          create: (context) => MentorProfileBloc(),
        )
      ],
      child: MaterialApp(
        title: 'MavenCliq',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/accountVerified': (context) => AccountVerifiedSuccessScreen(),
          '/commonSignIn': (context) => CommonSignInScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
