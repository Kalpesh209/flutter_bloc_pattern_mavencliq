part of 'mentor_auth_bloc.dart';

@immutable
abstract class MentorAuthEvent {}

class MentorSignUpRequestEvent extends MentorAuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPass;

  MentorSignUpRequestEvent(
    this.fullName,
    this.email,
    this.password,
    this.confirmPass,
  );
}

class MentorSignInRequestEvent extends MentorAuthEvent {
  final String email;
  final String password;

  MentorSignInRequestEvent(
    this.email,
    this.password,
  );
}

class MentorForgotPasswordEvent extends MentorAuthEvent {
  final String email;
  MentorForgotPasswordEvent(this.email);
}

class MentorResetPasswordEvent extends MentorAuthEvent {
  final String newPassword;
  final String confirmNewPassword;
  final String token;
  MentorResetPasswordEvent(
    this.newPassword,
    this.confirmNewPassword,
    this.token,
  );
}

class MentorVerifyEmailEvent extends MentorAuthEvent {
  final String token;
  MentorVerifyEmailEvent(
    this.token,
  );
}
