import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorResetPaswordResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorVerifyEmailResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/SignUp/MentorSignInResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Auth/MentorSignUpResponse.dart';

import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Mentor/Auth/auth_repository.dart';

part 'mentor_auth_event.dart';
part 'mentor_auth_state.dart';

class MentorAuthBloc extends Bloc<MentorAuthEvent, MentorAuthState> {
  final MentorAuthRepository mentorAuthRepository = MentorAuthRepository();
  MentorAuthBloc() : super(MentorAuthInitial()) {
    on<MentorSignUpRequestEvent>((event, emit) async {
      emit(MentorSignUpLoadingState());

      Map<String, dynamic> data = {
        'fullName': event.fullName,
        'email': event.email,
        'password': event.password,
        'confirmPassword': event.confirmPass,
      };
      MavenAPIResponse response =
          await mentorAuthRepository.mentorSignupRequest(data);
      if (response is MentorSignUpResponseSuccess) {
        emit(MentorSignUpCompletedState(response));
      } else if (response is MentorSignUpResponseFailed) {
        if (kDebugMode) {
          print('MENTOR SignUp Failed Message: ${response.message}');
          print('MENTOR Failed Status Code: ${response.statusCode}');
          print('MENTOR Failed Error: ${response.error}');
        }
        emit(MentorSignUpFailedState(response));
      }
    });

    on<MentorSignInRequestEvent>((event, emit) async {
      emit(MentorSignInLoadingState());

      var email = event.email;
      var pass = event.password;

      Map<String, dynamic> loginData = {
        'email': email,
        'password': pass,
      };
      MavenAPIResponse response =
          await mentorAuthRepository.mentorSignInRequest(loginData);

      if (response is MentorSignInResponseSuccess) {
        emit(MentorSignInCompletedState(response));
      } else if (response is MentorSignInResponseFailed) {
        if (kDebugMode) {
          print("SignIn Failed Message: ${response.message}");
          print("SignIn Failed Status Code: ${response.statusCode}");
          print("SignIn Failed Error: ${response.error}");
        }
        emit(MentorSignInFailedState(response));
      }
    });

    on<MentorForgotPasswordEvent>((event, emit) async {
      emit(MentorForgotPasswordLoadingState());
      var email = event.email;
      Map<String, dynamic> formData = {
        'email': email,
      };

      MavenAPIResponse response =
          await mentorAuthRepository.mentorForgotPasswordRequest(formData);

      print(response);
      if (response is MentorForgotPasswordResponseSuccess) {
        emit(MentorForgotPasswordCompletedState(response));
      } else if (response is MentorForgotPasswordResponseFailed) {
        if (kDebugMode) {}
        emit(MentorForgotPasswordFailedState(response));
      }
    });

    on<MentorResetPasswordEvent>((event, emit) async {
      emit(MentorResetPasswordLoadingState());

      var newPass = event.newPassword;
      var confirmPass = event.confirmNewPassword;
      var resetPassToken = event.token;

      Map<String, dynamic> formData = {
        'password': newPass,
        'confirmPassword': confirmPass,
      };
      MavenAPIResponse response = await mentorAuthRepository
          .mentorResetPasswordRequest(formData, resetPassToken);

      print('LINE 99 : $response');
      if (response is MentorResetPasswordResponseSuccess) {
        emit(MentorResetPasswordCompletedState(response));
      } else if (response is MentorResetPasswordResponseFailed) {
        if (kDebugMode) {
          print('MENTOR RESET  Message: ${response.message}');
          print('MENTOR RESET Failed Status Code: ${response.statusCode}');
          print('MENTOR RESET Failed Error: ${response.error}');
        }
        emit(MentorResetPasswordFailedState(response));
      }
    });

    on<MentorVerifyEmailEvent>((event, emit) async {
      emit(MentorVerifyEmailLoadingState());

      var mentorToken = event.token;

      MavenAPIResponse response =
          await mentorAuthRepository.mentorEmailVerification(mentorToken);

      print('LINE 122 : $response');
      if (response is MentorVerifyEmailResponseSuccess) {
        emit(MentorVerifyEmailCompletedState(response));
      } else if (response is MentorVerifyEmailResponseFailed) {
        if (kDebugMode) {}
        emit(MentorVerifyEmailFailedState(response));
      }
    });
  }
}
