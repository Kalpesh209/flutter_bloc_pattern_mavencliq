import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeResetPaswordResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeSignInResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeSignUpResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeVerifyEmailResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class MenteeAuthRepository extends BaseRepository {
  Future<MavenAPIResponse> menteeSignupRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
        ApiPaths.menteeSignUp.getUrl()(), formData);

    print(response);
    if (response != null) {
      if (kDebugMode) {
        print("Mentee Signup Response: ${response.data}");
      }
      if (response.statusCode == 200) {
        return MenteeSignUpResponseSuccess.fromJson(response.data, 200);
      } else {
        return MenteeSignUpResponseFailed.fromJson(response.data);
      }
    } else {
      return MenteeSignUpResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> menteeSignInRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.menteeLogin.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.data['status'] == 200) {
        MenteeSignInResponseSuccess menteeSignInResponseSuccessful =
            MenteeSignInResponseSuccess.fromJson(response.data, 200);

        return menteeSignInResponseSuccessful;
      } else {
        return MenteeSignInResponseFailed.fromJson(response.data);
      }
    } else {
      return MenteeSignInResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> menteeForgotPasswordRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.menteeForgotPassword.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.statusCode == 200) {
        return MenteeForgotPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return MenteeForgotPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return MenteeForgotPasswordResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> menteeResetPasswordRequest(
      Map<String, dynamic> formData, String token) async {
    var response = await apiService.putRequest(
      '${ApiPaths.menteeResetPassword.getUrl()()}$token',
      formData,
    );

    print('AUTH REPO LINE 87 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Mentee  Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return MenteeResetPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return MenteeResetPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return MenteeResetPasswordResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> menteeEmailVerification(String token) async {
    print(ApiPaths.menteeVerifyEmail.getUrl()());
    var response = await apiService.postRequest(
      '${ApiPaths.menteeVerifyEmail.getUrl()()}$token',
    );

    print('LINE 116 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Verify Email Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return MenteeVerifyEmailResponseSuccess.fromJson(response.data, 200);
      } else {
        return MenteeVerifyEmailResponseFailed.fromJson(response.data);
      }
    } else {
      return MenteeVerifyEmailResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }
}
