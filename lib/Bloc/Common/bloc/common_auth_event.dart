part of 'common_auth_bloc.dart';

// Changes after api was integrated

@immutable
abstract class CommonAuthEvent {}

class CommonInitEvent extends CommonAuthEvent {
  CommonInitEvent();
}

class CommonSignInRequestEvent extends CommonAuthEvent {
  final String email;
  final String password;

  CommonSignInRequestEvent(
    this.email,
    this.password,
  );
}

class CommonSignInDataNotValidEvent extends CommonAuthEvent {
  final String errorMessage;

  CommonSignInDataNotValidEvent(this.errorMessage);
}

class CommonForgotPasswordEvent extends CommonAuthEvent {
  final String email;
  CommonForgotPasswordEvent(this.email);
}

class CommonResetPasswordEvent extends CommonAuthEvent {
  final String newPassword;
  final String confirmNewPassword;
  final String token;
  CommonResetPasswordEvent(
    this.newPassword,
    this.confirmNewPassword,
    this.token,
  );
}

class SendEmailVerificationEvent extends CommonAuthEvent {
  final String email;

  SendEmailVerificationEvent(
    this.email,
  );
}

class CommonVerifyEmailEvent extends CommonAuthEvent {
  final String token;
  CommonVerifyEmailEvent(
    this.token,
  );
}
