part of 'mentor_auth_bloc.dart';

@immutable
abstract class MentorAuthState {}

class MentorAuthInitial extends MentorAuthState {}

class MentorSignUpLoadingState extends MentorAuthState {}

class MentorSignUpCompletedState extends MentorAuthState {
  final MentorSignUpResponseSuccess response;
  MentorSignUpCompletedState(this.response);
}

class MentorSignUpFailedState extends MentorAuthState {
  final MentorSignUpResponseFailed response;
  MentorSignUpFailedState(this.response);
}

class MentorSignInLoadingState extends MentorAuthState {}

class MentorSignInCompletedState extends MentorAuthState {
  final MentorSignInResponseSuccess response;
  MentorSignInCompletedState(this.response);
}

class MentorSignInFailedState extends MentorAuthState {
  final MentorSignInResponseFailed response;
  MentorSignInFailedState(this.response);
}

class MentorForgotPasswordLoadingState extends MentorAuthState {}

class MentorForgotPasswordCompletedState extends MentorAuthState {
  final MentorForgotPasswordResponseSuccess response;

  MentorForgotPasswordCompletedState(this.response);
}

class MentorForgotPasswordFailedState extends MentorAuthState {
  final MentorForgotPasswordResponseFailed response;

  MentorForgotPasswordFailedState(this.response);
}

class MentorResetPasswordLoadingState extends MentorAuthState {}

class MentorResetPasswordCompletedState extends MentorAuthState {
  final MentorResetPasswordResponseSuccess response;

  MentorResetPasswordCompletedState(this.response);
}

class MentorResetPasswordFailedState extends MentorAuthState {
  final MentorResetPasswordResponseFailed response;

  MentorResetPasswordFailedState(this.response);
}

class MentorVerifyEmailLoadingState extends MentorAuthState {}

class MentorVerifyEmailCompletedState extends MentorAuthState {
  final MentorVerifyEmailResponseSuccess response;

  MentorVerifyEmailCompletedState(this.response);
}

class MentorVerifyEmailFailedState extends MentorAuthState {
  final MentorVerifyEmailResponseFailed response;

  MentorVerifyEmailFailedState(this.response);
}
