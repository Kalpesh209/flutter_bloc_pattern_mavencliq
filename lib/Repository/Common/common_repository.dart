import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Common/CommonForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonResetPasswordResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonSendEmailResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonSignInResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonVerifyEmailResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class CommonRepository extends BaseRepository {
  Future<MavenAPIResponse> commonSignInRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.commonlogin.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.data['status'] == 200) {
        CommonSignInResponseSuccess commonSignInResponseSuccessful =
            CommonSignInResponseSuccess.fromJson(response.data, 200);

        return commonSignInResponseSuccessful;
      } else {
        return CommonSignInResponseFailed.fromJson(response.data);
      }
    } else {
      return CommonSignInResponseFailed(
        message: "",
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> commonForgotPasswordRequest(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
      ApiPaths.commonForgetPassword.getUrl()(),
      formData,
    );

    if (response != null) {
      if (kDebugMode) {}
      if (response.statusCode == 200) {
        return CommonForgotPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return CommonForgotPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return CommonForgotPasswordResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> commonResetPasswordRequest(
      Map<String, dynamic> formData, String token) async {
    var response = await apiService.putRequest(
      '${ApiPaths.commonResetPassword.getUrl()()}$token',
      formData,
    );

    print('AUTH REPO LINE 87 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Mentee  Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return CommonResetPasswordResponseSuccess.fromJson(response.data, 200);
      } else {
        return CommonResetPasswordResponseFailed.fromJson(response.data);
      }
    } else {
      return CommonResetPasswordResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> sendEmailVerification(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
        ApiPaths.commonSendEmailVerification.getUrl()(), formData);

    if (response != null) {
      if (kDebugMode) {
        print('Send Email Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return CommonSendEmailResponseSuccess.fromJson(response.data, 200);
      } else {
        return CommonSendEmailResponseFailed.fromJson(response.data);
      }
    } else {
      return CommonSendEmailResponseFailed.fromJson(response!.data);
    }
  }

  Future<MavenAPIResponse> commonVerifyEmail(String token) async {
    var response = await apiService.postRequest(
      '${ApiPaths.commonVerifyEmail.getUrl()()}$token',
    );

    print('LINE 116 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Verify Email Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return CommonVerifyEmailResponseSuccess.fromJson(response.data, 200);
      } else {
        return CommonVerifyEmailResponseFailed.fromJson(response.data);
      }
    } else {
      return CommonVerifyEmailResponseFailed(
        message: AppString.somethingWentWrong,
        error: AppString.responseNull,
      );
    }
  }
}
