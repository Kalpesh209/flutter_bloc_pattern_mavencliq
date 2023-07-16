import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:mavencliq/Bloc/Mentor/Auth/SendEmailVerification/bloc/SendEmailVerificationResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Mentor/SendEmailVericationRepo/send_email_verification_repo.dart';
import 'package:meta/meta.dart';

part 'send_email_verification_event.dart';
part 'send_email_verification_state.dart';

class SendEmailVerificationBloc
    extends Bloc<SendEmailVerificationEvent, SendEmailVerificationState> {
  final SendEmailVerificationRepository sendEmailVerificationRepository =
      SendEmailVerificationRepository();
  SendEmailVerificationBloc() : super(SendEmailVerificationInitial()) {
    on<MentorSendEmailVerificationEvent>((event, emit) async {
      emit(SendEmailVerificationLoadingState());

      var data = {
        'email': event.email,
      };
      MavenAPIResponse response =
          await sendEmailVerificationRepository.sendEmailVerification(data);

      print(response);
      if (response is SendEmailVerificationResponseSuccess) {
        emit(SendEmailVerificationCompletedState(response));
      } else if (response is SendEmailVerificationResponseFailed) {
        if (kDebugMode) {}
        emit(SendEmailVerificationFailedState(response));
      }
    });
  }
}
