import 'package:mavencliq/Models/Auth/generic_response.dart';

class GetExperienceListResponseSuccess extends MavenAPIResponse {
  MentorExperienceData? data;

  GetExperienceListResponseSuccess({
    this.data,
    required String message,
    required int statusCode,
  }) : super(statusCode: statusCode, message: message);

  GetExperienceListResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = json['data'] != null
            ? MentorExperienceData.fromJson(json['data'])
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

class GetExperienceListResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  GetExperienceListResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  GetExperienceListResponseFailed.fromJson(Map<String, dynamic> json)
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

class MentorExperienceData {
  List<Experience>? experience;
  bool? isCompleted;

  MentorExperienceData({this.experience, this.isCompleted});

  MentorExperienceData.fromJson(Map<String, dynamic> json) {
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(new Experience.fromJson(v));
      });
    }
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.experience != null) {
      data['experience'] = this.experience!.map((v) => v.toJson()).toList();
    }
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}

class Experience {
  int? id;
  String? jobTitle;
  String? companyName;
  String? tenureYears;
  String? tenureMonths;
  int? positioning;
  Cadre? cadre;

  Experience(
      {this.id,
      this.jobTitle,
      this.companyName,
      this.tenureYears,
      this.tenureMonths,
      this.positioning,
      this.cadre});

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['jobTitle'];
    companyName = json['companyName'];
    tenureYears = json['tenureYears'];
    tenureMonths = json['tenureMonths'];
    positioning = json['positioning'];
    cadre = json['cadre'] != null ? new Cadre.fromJson(json['cadre']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobTitle'] = this.jobTitle;
    data['companyName'] = this.companyName;
    data['tenureYears'] = this.tenureYears;
    data['tenureMonths'] = this.tenureMonths;
    data['positioning'] = this.positioning;
    if (this.cadre != null) {
      data['cadre'] = this.cadre!.toJson();
    }
    return data;
  }
}

class Cadre {
  int? id;
  String? cadreTitle;

  Cadre({this.id, this.cadreTitle});

  Cadre.fromJson(Map<String, dynamic> json) {
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
