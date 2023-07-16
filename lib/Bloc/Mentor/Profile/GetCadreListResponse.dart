import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetCadreListResponseSuccess extends MavenAPIResponse {
  List<CadreData>? data;

  GetCadreListResponseSuccess({
    this.data,
  }) : super(
          statusCode: 200,
          message: 'Cadre List Fetched Success',
        );

  GetCadreListResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : super(
          statusCode: 200,
          message: 'Cadre List Fetched Success',
        ) {
    if (json['data'] != null) {
      data = <CadreData>[];
      json['data'].forEach((v) {
        data!.add(CadreData.fromJson(v));
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

class CadreData {
  int? id;
  String? cadreTitle;

  CadreData({this.id, this.cadreTitle});

  CadreData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cadreTitle = json['cadreTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cadreTitle'] = this.cadreTitle;
    return data;
  }
}

class GetMentorCadreListResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetMentorCadreListResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetMentorCadreListResponseFailed.fromJson(Map<String, dynamic> json)
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
