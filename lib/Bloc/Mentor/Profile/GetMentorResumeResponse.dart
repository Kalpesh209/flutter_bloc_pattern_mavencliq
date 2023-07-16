import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetMentorResumeResponseSuccess extends MavenAPIResponse {
  MentorResumeData? data;

  GetMentorResumeResponseSuccess({
    this.data,
    required String message,
    required int statusCode,
  }) : super(statusCode: statusCode, message: message);

  GetMentorResumeResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = json['data'] != null
            ? MentorResumeData.fromJson(json['data'])
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

class GetMentorResumeResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetMentorResumeResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetMentorResumeResponseFailed.fromJson(Map<String, dynamic> json)
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

// class GetMentorResumeResponse {
//   MentorResumeData? data;
//   String? message;
//   int? status;

//   GetMentorResumeResponse({this.data, this.message, this.status});

//   GetMentorResumeResponse.fromJson(Map<String, dynamic> json) {
//     data =
//         json['data'] != null ? MentorResumeData.fromJson(json['data']) : null;
//     message = json['message'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     data['status'] = this.status;
//     return data;
//   }
// }

class MentorResumeData {
  String? resume;
  String? resumeName;

  MentorResumeData({this.resume, this.resumeName});

  MentorResumeData.fromJson(Map<String, dynamic> json) {
    resume = json['resume'];
    resumeName = json['resumeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resume'] = this.resume;
    data['resumeName'] = this.resumeName;
    return data;
  }
}
