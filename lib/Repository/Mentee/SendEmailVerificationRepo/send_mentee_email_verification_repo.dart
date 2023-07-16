import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/SendMenteeEmail/SendMenteeEmailVerificationResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SendEmailVerification/bloc/SendEmailVerificationResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';
import 'package:mavencliq/Ui_Config/app_string.dart';

class SendMenteeEmailVerificationRepository extends BaseRepository {
  Future<MavenAPIResponse> sendEmailVerification(
      Map<String, dynamic> formData) async {
    var response = await apiService.postRequestWithData(
        ApiPaths.sendMenteeEmailVerification.getUrl()(), formData);

    print('LINE 14 : $response');
    if (response != null) {
      if (kDebugMode) {
        print('Send Email Response: ${response.data}');
      }
      if (response.statusCode == 200) {
        return SendMenteeEmailVerificationResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return SendMenteeEmailVerificationResponseFailed.fromJson(
            response.data);
      }
    } else {
      return SendMenteeEmailVerificationResponseFailed(
        message: response!.statusMessage!,
        error: AppString.responseNull,
      );
    }
  }
}
