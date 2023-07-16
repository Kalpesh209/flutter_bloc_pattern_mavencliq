import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/SendMenteeEmail/SendMenteeEmailVerificationResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Mentee/SendEmailVerificationRepo/send_mentee_email_verification_repo.dart';
import 'package:meta/meta.dart';

part 'send_mentee_email_event.dart';
part 'send_mentee_email_state.dart';

class SendMenteeEmailBloc
    extends Bloc<SendMenteeEmailEvent, SendMenteeEmailState> {
  final SendMenteeEmailVerificationRepository
      sendMenteeEmailVerificationRepository =
      SendMenteeEmailVerificationRepository();
  SendMenteeEmailBloc() : super(SendMenteeEmailInitial()) {
    on<MenteeSendEmailVerificationEvent>((event, emit) async {
      emit(SendMenteeEmailVerificationLoadingState());

      var data = {
        'email': event.email,
      };
      MavenAPIResponse response = await sendMenteeEmailVerificationRepository
          .sendEmailVerification(data);

      print(response);
      if (response is SendMenteeEmailVerificationResponseSuccess) {
        emit(SendMenteeEmailVerificationCompletedState(response));
      } else if (response is SendMenteeEmailVerificationResponseFailed) {
        if (kDebugMode) {}
        emit(SendMenteeEmailVerificationFailedState(response));
      }
    });
  }
}
