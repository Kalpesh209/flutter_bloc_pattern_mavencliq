import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetMentorDomainListResponseSuccess extends MavenAPIResponse {
  List<DomainData>? data;

  GetMentorDomainListResponseSuccess({
    this.data,
  }) : super(
          statusCode: 200,
          message: 'Domain List Fetched Success',
        );

  GetMentorDomainListResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : super(
          statusCode: 200,
          message: 'Domain List Fetched Success',
        ) {
    if (json['data'] != null) {
      data = <DomainData>[];
      json['data'].forEach((v) {
        data!.add(DomainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DomainData {
  int? id;
  String? name;

  DomainData({this.id, this.name});

  DomainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class GetMentorDomainListResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetMentorDomainListResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetMentorDomainListResponseFailed.fromJson(Map<String, dynamic> json)
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
