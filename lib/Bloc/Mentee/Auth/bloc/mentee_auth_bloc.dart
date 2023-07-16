import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeResetPaswordResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeSignInResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeSignUpResponse.dart';
import 'package:mavencliq/Bloc/Mentee/Auth/MenteeVerifyEmailResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Mentee/Auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'mentee_auth_event.dart';
part 'mentee_auth_state.dart';

class MenteeAuthBloc extends Bloc<MenteeAuthEvent, MenteeAuthState> {
  MenteeAuthRepository menteeAuthRepository = MenteeAuthRepository();

  MenteeAuthBloc() : super(MenteeAuthInitial()) {
    on<MenteeSignUpRequestEvent>((event, emit) async {
      emit(MenteeSignUpLoadingState());

      var data = {
        'fullName': event.fullName,
        'email': event.email,
        'password': event.password,
        'confirmPassword': event.confirmPass,
      };
      MavenAPIResponse response =
          await menteeAuthRepository.menteeSignupRequest(data);

      print('LINE 27 : $response');
      if (response is MenteeSignUpResponseSuccess) {
        emit(MenteeSignUpCompletedState(response));
      } else if (response is MenteeSignUpResponseFailed) {
        if (kDebugMode) {
          print('MENTEE SignUp Failed Message: ${response.message}');
          print('MENTEE Failed Status Code: ${response.statusCode}');
          print('MENTEE Failed Error: ${response.error}');
        }
        emit(MenteeSignUpFailedState(response));
      }
    });

    on<MenteeSignInRequestEvent>((event, emit) async {
      emit(MenteeSignInLoadingState());

      var email = event.email;
      var pass = event.password;

      Map<String, dynamic> loginData = {
        'email': email,
        'password': pass,
      };
      MavenAPIResponse response =
          await menteeAuthRepository.menteeSignInRequest(loginData);

      if (response is MenteeSignInResponseSuccess) {
        emit(MenteeSignInCompletedState(response));
      } else if (response is MenteeSignInResponseFailed) {
        if (kDebugMode) {
          print("SignIn Failed Message: ${response.message}");
          print("SignIn Failed Status Code: ${response.statusCode}");
          print("SignIn Failed Error: ${response.error}");
        }
        emit(MenteeSignInFailedState(response));
      }
    });

    on<MenteeForgotPasswordEvent>((event, emit) async {
      emit(MenteeForgotPasswordLoadingState());
      var email = event.email;
      Map<String, dynamic> formData = {
        'email': email,
      };

      MavenAPIResponse response =
          await menteeAuthRepository.menteeForgotPasswordRequest(formData);

      print(response);
      if (response is MenteeForgotPasswordResponseSuccess) {
        emit(MenteeForgotPasswordCompletedState(response));
      } else if (response is MenteeForgotPasswordResponseFailed) {
        if (kDebugMode) {}
        emit(MenteeForgotPasswordFailedState(response));
      }
    });

    on<MenteeResetPasswordEvent>((event, emit) async {
      emit(MenteeResetPasswordLoadingState());

      var newPass = event.newPassword;
      var confirmPass = event.confirmNewPassword;
      var resetPassToken = event.token;

      Map<String, dynamic> formData = {
        'password': newPass,
        'confirmPassword': confirmPass,
      };
      MavenAPIResponse response = await menteeAuthRepository
          .menteeResetPasswordRequest(formData, resetPassToken);

      print(response);
      if (response is MenteeResetPasswordResponseSuccess) {
        emit(MenteeResetPasswordCompletedState(response));
      } else if (response is MenteeResetPasswordResponseFailed) {
        if (kDebugMode) {
          print('MENTEE RESET  Message: ${response.message}');
          print('MENTEE RESET Failed Status Code: ${response.statusCode}');
          print('MENTEE RESET Failed Error: ${response.error}');
        }
        emit(MenteeResetPasswordFailedState(response));
      }
    });

    on<MenteeVerifyEmailEvent>((event, emit) async {
      emit(MenteeVerifyEmailLoadingState());

      var menteeToken = event.menteeToken;

      MavenAPIResponse response =
          await menteeAuthRepository.menteeEmailVerification(menteeToken);

      print('LINE 122 : $response');
      if (response is MenteeVerifyEmailResponseSuccess) {
        emit(MenteeVerifyEmailCompletedState(response));
      } else if (response is MenteeVerifyEmailResponseFailed) {
        if (kDebugMode) {}
        emit(MenteeVerifyEmailFailedState(response));
      }
    });
  }
}
