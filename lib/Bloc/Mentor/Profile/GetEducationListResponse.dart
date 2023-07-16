import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetEducationListResponseSuccess extends MavenAPIResponse {
  MentorEducationalData? data;

  GetEducationListResponseSuccess({
    this.data,
    required String message,
    required int statusCode,
  }) : super(statusCode: statusCode, message: message);

  GetEducationListResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = json['data'] != null
            ? MentorEducationalData.fromJson(json['data'])
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

class GetEducationListResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetEducationListResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetEducationListResponseFailed.fromJson(Map<String, dynamic> json)
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

class MentorEducationalData {
  List<Education>? education;
  bool? isCompleted;

  MentorEducationalData({this.education, this.isCompleted});

  MentorEducationalData.fromJson(Map<String, dynamic> json) {
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }

    print(education);
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}

class Education {
  int? id;
  String? degree;
  String? passingYear;
  String? instituteName;

  Education({this.id, this.degree, this.passingYear, this.instituteName});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    degree = json['degree'];
    passingYear = json['passingYear'];
    instituteName = json['instituteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['degree'] = this.degree;
    data['passingYear'] = this.passingYear;
    data['instituteName'] = this.instituteName;
    return data;
  }
}
