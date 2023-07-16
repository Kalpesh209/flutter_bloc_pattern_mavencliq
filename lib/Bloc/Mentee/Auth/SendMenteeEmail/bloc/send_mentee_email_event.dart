part of 'send_mentee_email_bloc.dart';

@immutable
abstract class SendMenteeEmailEvent {}

class MenteeSendEmailVerificationEvent extends SendMenteeEmailEvent {
  final String email;

  MenteeSendEmailVerificationEvent(
    this.email,
  );
}
