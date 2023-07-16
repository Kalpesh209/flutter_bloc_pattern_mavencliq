part of 'mentee_auth_bloc.dart';

@immutable
abstract class MenteeAuthEvent {}

class MenteeSignUpRequestEvent extends MenteeAuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPass;

  MenteeSignUpRequestEvent(
    this.fullName,
    this.email,
    this.password,
    this.confirmPass,
  );
}

class MenteeSignInRequestEvent extends MenteeAuthEvent {
  final String email;
  final String password;

  MenteeSignInRequestEvent(
    this.email,
    this.password,
  );
}

class MenteeForgotPasswordEvent extends MenteeAuthEvent {
  final String email;
  MenteeForgotPasswordEvent(this.email);
}

class MenteeResetPasswordEvent extends MenteeAuthEvent {
  final String newPassword;
  final String confirmNewPassword;
  final String token;
  MenteeResetPasswordEvent(
    this.newPassword,
    this.confirmNewPassword,
    this.token,
  );
}

class MenteeVerifyEmailEvent extends MenteeAuthEvent {
  final String menteeToken;
  MenteeVerifyEmailEvent(
    this.menteeToken,
  );
}
