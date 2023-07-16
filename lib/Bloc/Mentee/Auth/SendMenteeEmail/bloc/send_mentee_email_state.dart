part of 'send_mentee_email_bloc.dart';

@immutable
abstract class SendMenteeEmailState {}

class SendMenteeEmailInitial extends SendMenteeEmailState {}

class SendMenteeEmailVerificationLoadingState extends SendMenteeEmailState {}

class SendMenteeEmailVerificationCompletedState extends SendMenteeEmailState {
  final SendMenteeEmailVerificationResponseSuccess response;
  SendMenteeEmailVerificationCompletedState(this.response);
}

class SendMenteeEmailVerificationFailedState extends SendMenteeEmailState {
  final SendMenteeEmailVerificationResponseFailed response;
  SendMenteeEmailVerificationFailedState(this.response);
}
