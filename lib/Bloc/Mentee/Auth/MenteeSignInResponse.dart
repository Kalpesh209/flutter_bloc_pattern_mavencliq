import 'package:mavencliq/Models/Auth/generic_response.dart';

class MenteeSignInResponseSuccess extends MavenAPIResponse {
  LoginData? data;
  MenteeSignInResponseSuccess({
    required this.data,
    required String message,
    required int statusCode,
  }) : super(statusCode: statusCode, message: message);
  MenteeSignInResponseSuccess.fromJson(
      Map<String, dynamic> json, int statusCode)
      : data = LoginData.fromJson(json['data']),
        super(statusCode: statusCode, message: json['message']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}

class LoginData {
  String? token;
  LoginDetails? loginDetails;

  LoginData({
    this.token,
    this.loginDetails,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    loginDetails = json['loginDetails'] != null
        ? new LoginDetails.fromJson(json['loginDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.loginDetails != null) {
      data['loginDetails'] = this.loginDetails!.toJson();
    }
    return data;
  }
}

class LoginDetails {
  int? id;
  String? fullName;
  String? email;
  String? role;
  int? isEmailVerified;
  String? verificationStatus;
  String? status;

  LoginDetails(
      {this.id,
      this.fullName,
      this.email,
      this.role,
      this.isEmailVerified,
      this.verificationStatus,
      this.status});

  LoginDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
    verificationStatus = json['verificationStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['isEmailVerified'] = this.isEmailVerified;
    data['verificationStatus'] = this.verificationStatus;
    data['status'] = this.status;
    return data;
  }
}

class MenteeSignInResponseFailed extends MavenAPIResponse {
  String? error;
  int? status;
  MenteeSignInResponseFailed({
    this.status,
    this.error,
    required String message,
  }) : super(statusCode: 401, message: message);

  MenteeSignInResponseFailed.fromJson(Map<String, dynamic> json)
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
