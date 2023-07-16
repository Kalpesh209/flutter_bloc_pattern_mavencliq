import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorResetPaswordResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorVerifyEmailResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/MentorSignInResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorSignUpResponse.dart';

import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class MentorAuthRepository extends BaseRepository {
  Future<MavenAPIResponse> mentorSignupRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
        ApiPaths.mentorSignUp.getUrl()(), formData);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Signup Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return MentorSignUpResponseSuccess.fromJson(response.data, 200);
      } else {
        return MentorSignUpResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorSignUpResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> mentorSignInRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.mentorLogin.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.data['status'] == 200) {
        MentorSignInResponseSuccess mentorSignInResponseSuccessful =
            MentorSignInResponseSuccess.fromJson(response.data, 200);

        return mentorSignInResponseSuccessful;
      } else {
        return MentorSignInResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorSignInResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> mentorForgotPasswordRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.mentorForgotPassword.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.statusCode == 200) {
        return MentorForgotPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return MentorForgotPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorForgotPasswordResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> mentorResetPasswordRequest(
      Map<String, dynamic> formData, String token) async {
    var response = await apiService.putRequest(
      '${ApiPaths.mentorResetPassword.getUrl()()}$token',
      formData,
    );

    print('AUTH REPO LINE 87 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Mentor  Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return MentorResetPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return MentorResetPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorResetPasswordResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> mentorEmailVerification(String token) async {
    var response = await apiService.postRequest(
      '${ApiPaths.mentorVerifyEmail.getUrl()()}$token',
    );

    print("LINE 116 : $response");

    if (response != null) {
      if (kDebugMode) {
        print('Verify Email Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return MentorVerifyEmailResponseSuccess.fromJson(response.data, 200);
      } else {
        return MentorVerifyEmailResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorVerifyEmailResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }

  // Future<RazullAPIResponse> sendForgotPasswordOTPVerificationRequest(
  //     ForgotPasswordRequestModel request) async {
  //   var response = await apiService.putRequest(
  //       ApiPaths.forgotPassword.getUrl()(), request.toJson());

  //   if (response != null) {
  //     if (kDebugMode) {
  //       print("Signup Response: ${response.data}");
  //     }
  //     if (response.statusCode == 200) {
  //       return ResetPasswordResponseSuccessful.fromJson(response.data, 200);
  //     } else {
  //       return ResetPasswordResponseFailed.fromJson(response.data);
  //     }
  //   } else {
  //     return ResetPasswordResponseFailed(
  //         statusCode: 400,
  //         message: "Something Went Wrong, Please Try Again",
  //         error: "Response is Null");
  //   }
  // }

  // Future<RazullAPIResponse> sendResetPasswordRequest(
  //     ForgotPasswordRequestModel request) async {
  //   var response = await apiService.putRequest(
  //       ApiPaths.forgotPassword.getUrl()(), request.toJson());

  //   if (response != null) {
  //     if (kDebugMode) {
  //       print("Signup Response: ${response.data}");
  //     }
  //     if (response.statusCode == 200) {
  //       return ResetPasswordResponseSuccessful.fromJson(response.data, 200);
  //     } else {
  //       return ResetPasswordResponseFailed.fromJson(response.data);
  //     }
  //   } else {
  //     return ResetPasswordResponseFailed(
  //         statusCode: 400,
  //         message: "Something Went Wrong, Please Try Again",
  //         error: "Response is Null");
  //   }
  // }

  // Future<bool> isUserLoggedIn() async {
  //   return await database.isLoggedIn();
  // }

  // Future<bool> logOut() async {
  //   var result = await database.deleteAllUserDetails();
  //   await database.deleteAllIdentityKeys();
  //   await database.deleteAllPreKeys();
  //   await database.deleteAllSignedPreKeys();
  //   await database.deleteAllTrustedKeys();
  //   await database.deleteAllSessions();
  //   if (result == -1) {
  //     if (kDebugMode) {
  //       print("There is some error in logging out");
  //     }
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // Future<String?> getUserToken() async {
  //   var userData = await database.getUserDetails();
  //   return userData?.token;
  // }
}
