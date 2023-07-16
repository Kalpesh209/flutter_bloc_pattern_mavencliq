import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SendEmailVerification/bloc/SendEmailVerificationResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Network/end_points.dart';
import 'package:mavencliq/Repository/base_respository.dart';

class SendEmailVerificationRepository extends BaseRepository {
  Future<MavenAPIResponse> sendEmailVerification(
      Map<String, dynamic> formData) async {
    print(formData);
    var response = await apiService.postRequestWithData(
        ApiPaths.sendMentorEmailVerification.getUrl()(), formData);

    print("LINE 14 : $response");
    if (response != null) {
      if (kDebugMode) {
        print("Send Email Response: ${response.data}");
      }
      if (response.statusCode == 200) {
        return SendEmailVerificationResponseSuccess.fromJson(
            response.data, 200);
      } else {
        return SendEmailVerificationResponseFailed.fromJson(response.data);
      }
    } else {
      return SendEmailVerificationResponseFailed.fromJson(response!.data);
    }
  }
}
