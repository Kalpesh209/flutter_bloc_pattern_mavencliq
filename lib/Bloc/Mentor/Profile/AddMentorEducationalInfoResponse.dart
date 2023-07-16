import 'package:mavencliq/Models/Auth/generic_response.dart';

class AddMentorEducatioalInfoResponseSuccess extends MavenAPIResponse {
  String? data;

  AddMentorEducatioalInfoResponseSuccess({
    required this.data,
    required String? message,
    required int? statusCode,
  }) : super(statusCode: statusCode!, message: message!);
  AddMentorEducatioalInfoResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = json['data'],
        super(statusCode: statusCode, message: json['message']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}

class AddMentorEducatioalInfoResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  AddMentorEducatioalInfoResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  AddMentorEducatioalInfoResponseFailed.fromJson(Map<String, dynamic> json)
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
