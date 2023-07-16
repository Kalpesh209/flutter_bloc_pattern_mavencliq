part of 'mentee_auth_bloc.dart';

@immutable
abstract class MenteeAuthState {}

class MenteeAuthInitial extends MenteeAuthState {}

class MenteeSignUpLoadingState extends MenteeAuthState {}

class MenteeSignUpCompletedState extends MenteeAuthState {
  final MenteeSignUpResponseSuccess response;
  MenteeSignUpCompletedState(this.response);
}

class MenteeSignUpFailedState extends MenteeAuthState {
  final MenteeSignUpResponseFailed response;
  MenteeSignUpFailedState(this.response);
}

class MenteeSignInLoadingState extends MenteeAuthState {}

class MenteeSignInCompletedState extends MenteeAuthState {
  final MenteeSignInResponseSuccess response;
  MenteeSignInCompletedState(this.response);
}

class MenteeSignInFailedState extends MenteeAuthState {
  final MenteeSignInResponseFailed response;
  MenteeSignInFailedState(this.response);
}

class MenteeForgotPasswordLoadingState extends MenteeAuthState {}

class MenteeForgotPasswordCompletedState extends MenteeAuthState {
  final MenteeForgotPasswordResponseSuccess response;

  MenteeForgotPasswordCompletedState(this.response);
}

class MenteeForgotPasswordFailedState extends MenteeAuthState {
  final MenteeForgotPasswordResponseFailed response;

  MenteeForgotPasswordFailedState(this.response);
}

class MenteeResetPasswordLoadingState extends MenteeAuthState {}

class MenteeResetPasswordCompletedState extends MenteeAuthState {
  final MenteeResetPasswordResponseSuccess response;

  MenteeResetPasswordCompletedState(this.response);
}

class MenteeResetPasswordFailedState extends MenteeAuthState {
  final MenteeResetPasswordResponseFailed response;

  MenteeResetPasswordFailedState(this.response);
}

class MenteeVerifyEmailLoadingState extends MenteeAuthState {}

class MenteeVerifyEmailCompletedState extends MenteeAuthState {
  final MenteeVerifyEmailResponseSuccess response;

  MenteeVerifyEmailCompletedState(this.response);
}

class MenteeVerifyEmailFailedState extends MenteeAuthState {
  final MenteeVerifyEmailResponseFailed response;

  MenteeVerifyEmailFailedState(this.response);
}
