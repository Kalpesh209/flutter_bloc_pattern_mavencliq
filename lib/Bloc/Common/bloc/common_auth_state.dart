part of 'common_auth_bloc.dart';

@immutable
abstract class CommonAuthState {}

class CommonAuthInitial extends CommonAuthState {}

class CommonSignInLoadingState extends CommonAuthState {}

class CommonSignInCompletedState extends CommonAuthState {
  final CommonSignInResponseSuccess response;
  CommonSignInCompletedState(this.response);
}

class CommonSignInDataNotValidState extends CommonAuthState {
  final String errorMessage;

  CommonSignInDataNotValidState(this.errorMessage);
}

class CommonSignInFailedState extends CommonAuthState {
  final CommonSignInResponseFailed response;
  CommonSignInFailedState(this.response);
}

class CommonForgotPasswordLoadingState extends CommonAuthState {}

class CommonForgotPasswordCompletedState extends CommonAuthState {
  final CommonForgotPasswordResponseSuccess response;
  CommonForgotPasswordCompletedState(this.response);
}

class CommonForgotPasswordFailedState extends CommonAuthState {
  final CommonForgotPasswordResponseFailed response;
  CommonForgotPasswordFailedState(this.response);
}

class CommonResetPasswordLoadingState extends CommonAuthState {}

class CommonResetPasswordCompletedState extends CommonAuthState {
  final CommonResetPasswordResponseSuccess response;
  CommonResetPasswordCompletedState(this.response);
}

class CommonResetPasswordFailedState extends CommonAuthState {
  final CommonResetPasswordResponseFailed response;
  CommonResetPasswordFailedState(this.response);
}

class SendEmailVerificationLoadingState extends CommonAuthState {}

class SendEmailVerificationCompletedState extends CommonAuthState {
  final CommonSendEmailResponseSuccess response;
  SendEmailVerificationCompletedState(this.response);
}

class SendEmailVerificationFailedState extends CommonAuthState {
  final CommonSendEmailResponseFailed response;
  SendEmailVerificationFailedState(this.response);
}

class CommonVerifyEmailLoadingState extends CommonAuthState {}

class CommonVerifyEmailCompletedState extends CommonAuthState {
  final CommonVerifyEmailResponseSuccess response;

  CommonVerifyEmailCompletedState(this.response);
}

class CommonVerifyEmailFailedState extends CommonAuthState {
  final CommonVerifyEmailResponseFailed response;

  CommonVerifyEmailFailedState(this.response);
}
