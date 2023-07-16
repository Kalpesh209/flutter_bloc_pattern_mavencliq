import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorBankDetailsResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorEducationalInfoResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorExperienceResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorGeneralInfoResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorOtherDetailsResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteEducationResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteMentorExperienceResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteMentorResumeResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetCadreListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetEducationListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetExperienceListResponseSuccess.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetMentorDomainListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetMentorResumeResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/MentorProfileStatusResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/MentorResumeUploadResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/UpdateMentorEducationResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/UpdateMentorExperienceResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorProfileRepository extends BaseRepository {
  Future<MavenAPIResponse> mentorAddGeneralInfoRequest(var formData) async {
    final token = await getUserToken();

    var response = await apiService.patchRequestWithData(
        ApiPaths.mentorGeneralInfo.getUrl()(), formData, token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Add General Info : ${response.data}');
      }
      if (response.statusCode == 200) {
        return AddMentorGeneralInfoResponseSuccess.fromJson(response.data, 200);
      } else {
        return AddMentorGeneralInfoResponseFailed.fromJson(response.data);
      }
    } else {
      return AddMentorGeneralInfoResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  // Add Educational Info

  Future<MavenAPIResponse> mentorAddEducationaInfoRequest(
      Map<String, dynamic> formData) async {
    final token = await getUserToken();

    var response = await apiService.securepostRequestWithData(
        ApiPaths.mentorEducationalInfo.getUrl()(), formData, token);

    if (response != null) {
      if (response.statusCode == 201) {
        return AddMentorEducatioalInfoResponseSuccess.fromJson(
            response.data, 201);
      } else {
        return AddMentorEducatioalInfoResponseFailed.fromJson(response.data);
      }
    } else {
      return AddMentorEducatioalInfoResponseFailed(
        message: response!.statusCode.toString(),
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  // Get a List of Mentor Education

  Future<MavenAPIResponse> getMentorEducationList() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorEducationalInfo.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Educational LIST : ${response.data}');
      }
      if (response.statusCode == 200) {
        return GetEducationListResponseSuccess.fromJson(response.data, 200);
      } else {
        return GetEducationListResponseFailed.fromJson(response.data);
      }
    } else {
      return GetEducationListResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  // Delete a Data

  Future<MavenAPIResponse> deleteMentorEducation(int index) async {
    final token = await getUserToken();

    var response = await apiService.secureDeleteRequestUsingQueryParams(
        '${ApiPaths.mentorEducationalInfo.getUrl()()}/$index', token);

    if (response != null) {
      if (response.statusCode == 200) {
        return DeleteEducationResponseSuccess.fromJson(response.data, 200);
      } else {
        return DeleteEducationResponseFailed.fromJson(response.data);
      }
    } else {
      return DeleteEducationResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> updateMentorEducation(
      int index, Map<String, dynamic> formData) async {
    final token = await getUserToken();

    var response = await apiService.securePutRequest(
        '${ApiPaths.mentorEducationalInfo.getUrl()()}/$index', formData, token);

    if (response != null) {
      print('Mentor Educational Detete : ${response.data}');

      if (response.statusCode == 200) {
        return UpdateMentorEducationResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return UpdateMentorEducationResponseFailed.fromJson(response.data);
      }
    } else {
      return UpdateMentorEducationResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> mentorResumeUploadRequest(var formData) async {
    final token = await getUserToken();

    var response = await apiService.securePostRequestWithFormData(
        ApiPaths.mentorResume.getUrl()(), formData, token);

    if (response != null) {
      print('Mentor Resume Upload : ${response.data}');

      if (response.statusCode == 200) {
        return MentorResumeUploadResponseSuccess.fromJson(response.data, 200);
      } else {
        return MentorResumeUploadResponseFailed.fromJson(response.data);
      }
    } else {
      return MentorResumeUploadResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> mentorAddExperienceInfoRequest(
      Map<String, dynamic> formData) async {
    final token = await getUserToken();

    var response = await apiService.securepostRequestWithData(
        ApiPaths.mentorExperience.getUrl()(), formData, token);

    if (response != null) {
      print('Mentor Add EXperience Info : ${response.data}');

      if (response.statusCode == 201) {
        return AddMentorExperienceResponseSuccess.fromJson(response.data, 201);
      } else {
        return AddMentorExperienceResponseFailed.fromJson(response.data);
      }
    } else {
      return AddMentorExperienceResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> getMentorResume() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorResume.getUrl()(), token);

    if (response != null) {
      print('Mentor RESUME LIST : ${response.data}');

      if (response.statusCode == 200) {
        return GetMentorResumeResponseSuccess.fromJson(response.data, 200);
      } else {
        return GetMentorResumeResponseFailed.fromJson(response.data);
      }
    } else {
      return GetMentorResumeResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> getMentorExperenceList() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorExperience.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor EXPERiENCE LIST : ${response.data}');
      }
      if (response.statusCode == 200) {
        return GetExperienceListResponseSuccess.fromJson(response.data, 200);
      } else {
        return GetExperienceListResponseFailed.fromJson(response.data);
      }
    } else {
      return GetExperienceListResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> deleteMentorResume() async {
    final token = await getUserToken();

    var response = await apiService.secureDeleteRequestUsingQueryParams(
        ApiPaths.mentorResume.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('DELETE MENTOR RESUME: ${response.data}');
      }
      if (response.statusCode == 200) {
        return DeleteMentorResumeResponseSuccess.fromJson(response.data, 200);
      } else {
        return DeleteMentorResumeResponseFailed.fromJson(response.data);
      }
    } else {
      return DeleteMentorResumeResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> deleteMentorExperience(int index) async {
    final token = await getUserToken();

    var response = await apiService.secureDeleteRequestUsingQueryParams(
        '${ApiPaths.mentorExperience.getUrl()()}/$index', token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Experience  Detete : ${response.data}');
      }
      if (response.statusCode == 200) {
        return DeleteMentorExperienceResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return DeleteMentorExperienceResponseFailed.fromJson(response.data);
      }
    } else {
      return DeleteMentorExperienceResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  // Update Mentor Experience
  Future<MavenAPIResponse> updateMentorExperience(
      int index, Map<String, dynamic> formData) async {
    final token = await getUserToken();

    var response = await apiService.securePutRequest(
        '${ApiPaths.mentorExperience.getUrl()()}/$index', formData, token);

    if (response != null) {
      if (kDebugMode) {
        print('Update Mentor Experience : ${response.data}');
      }
      if (response.statusCode == 200) {
        return UpdateMentorExperienceResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return UpdateMentorExperienceResponseFailed.fromJson(response.data);
      }
    } else {
      return UpdateMentorExperienceResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> mentorAddBankDetailsRequest(formData) async {
    final token = await getUserToken();

    var response = await apiService.patchRequestWithData12(
        ApiPaths.mentorBankDetails.getUrl()(), formData, token);

    print('LINE 329 : $response');

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Add Bank Details Info : ${response.data}');
      }
      if (response.statusCode == 200) {
        return AddMentorBankDeatilsResponseSuccess.fromJson(response.data, 200);
      } else {
        return AddMentorBankDeatilsResponseFailed.fromJson(response.data);
      }
    } else {
      return AddMentorBankDeatilsResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  // To get a Cadre List

  Future<MavenAPIResponse> getMentorCadreList() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorPricesCadre.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Educational LIST : ${response.data}');
      }
      if (response.statusCode == 200) {
        return GetCadreListResponseSuccess.fromJson(response.data, 200);
      } else {
        return GetMentorCadreListResponseFailed.fromJson(response.data);
      }
    } else {
      return GetMentorCadreListResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  // To get a Domain List

  Future<MavenAPIResponse> getMentorDomainList() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorDomains.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Educational LIST : ${response.data}');
      }
      if (response.statusCode == 200) {
        return GetMentorDomainListResponseSuccess.fromJson(response.data, 200);
      } else {
        return GetMentorDomainListResponseFailed.fromJson(response.data);
      }
    } else {
      return GetMentorDomainListResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<MavenAPIResponse> mentorAddOthersDetailsRequest(formData) async {
    final token = await getUserToken();

    var response = await apiService.patchRequestWithData12(
        ApiPaths.mentorOtherDetails.getUrl()(), formData, token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Add Bank Details Info : ${response.data}');
      }
      if (response.statusCode == 200) {
        return AddMentorOtherDetailsResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return AddMentorOtherDetailsResponseFailed.fromJson(response.data);
      }
    } else {
      return AddMentorOtherDetailsResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }

  Future<MavenAPIResponse> getMentorProfileStatus() async {
    final token = await getUserToken();

    var response = await apiService.getRequestData(
        ApiPaths.mentorProfileStatus.getUrl()(), token);

    if (response != null) {
      if (kDebugMode) {
        print('Mentor Profile Status : ${response.data}');
      }
      if (response.statusCode == 200) {
        return GetMentorProfileStatusResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return GetMentorProfileStatusResponseFailed.fromJson(response.data);
      }
    } else {
      return GetMentorProfileStatusResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
        status: 401,
      );
    }
  }

  Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginUserToken = prefs.getString('MentorLoginToken');
    return loginUserToken!;
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
