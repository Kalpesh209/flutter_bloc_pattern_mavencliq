part of 'send_email_verification_bloc.dart';

@immutable
abstract class SendEmailVerificationState {}

class SendEmailVerificationInitial extends SendEmailVerificationState {}

class SendEmailVerificationLoadingState extends SendEmailVerificationState {}

class SendEmailVerificationCompletedState extends SendEmailVerificationState {
  final SendEmailVerificationResponseSuccess response;
  SendEmailVerificationCompletedState(this.response);
}

class SendEmailVerificationFailedState extends SendEmailVerificationState {
  final SendEmailVerificationResponseFailed response;
  SendEmailVerificationFailedState(this.response);
}
