import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetMentorProfileStatusResponseSuccess extends MavenAPIResponse {
  ProfileStatusData? data;

  GetMentorProfileStatusResponseSuccess({
    this.data,
    required String message,
    required int statusCode,
  }) : super(statusCode: statusCode, message: message);

  GetMentorProfileStatusResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = json['data'] != null
            ? ProfileStatusData.fromJson(json['data'])
            : null,
        super(
          statusCode: statusCode,
          message: 'List',
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}

class GetMentorProfileStatusResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetMentorProfileStatusResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetMentorProfileStatusResponseFailed.fromJson(Map<String, dynamic> json)
      : super(statusCode: 401, message: json['message']) {
    error = json['error'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

//

class ProfileStatusData {
  bool? generalInfo;
  bool? education;
  bool? experience;
  bool? otherInfo;
  bool? bankDetails;

  ProfileStatusData(
      {this.generalInfo,
      this.education,
      this.experience,
      this.otherInfo,
      this.bankDetails});

  ProfileStatusData.fromJson(Map<String, dynamic> json) {
    generalInfo = json['generalInfo'];
    education = json['education'];
    experience = json['experience'];
    otherInfo = json['otherInfo'];
    bankDetails = json['bankDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['generalInfo'] = this.generalInfo;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['otherInfo'] = this.otherInfo;
    data['bankDetails'] = this.bankDetails;
    return data;
  }
}
