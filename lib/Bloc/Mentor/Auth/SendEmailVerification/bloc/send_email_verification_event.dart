part of 'send_email_verification_bloc.dart';

@immutable
abstract class SendEmailVerificationEvent {}

class MentorSendEmailVerificationEvent extends SendEmailVerificationEvent {
  final String email;

  MentorSendEmailVerificationEvent(
    this.email,
  );
}
