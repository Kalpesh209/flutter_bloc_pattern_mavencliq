import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Bloc/Common/CommonForgotPasswordResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonResetPasswordResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonSendEmailResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonSignInResponse.dart';
import 'package:mavencliq/Bloc/Common/CommonVerifyEmailResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Common/common_repository.dart';
import 'package:meta/meta.dart';

part 'common_auth_event.dart';
part 'common_auth_state.dart';

class CommonAuthBloc extends Bloc<CommonAuthEvent, CommonAuthState> {
  CommonRepository commonRepository = CommonRepository();
  CommonAuthBloc() : super(CommonAuthInitial()) {
    on<CommonSignInRequestEvent>((event, emit) async {
      emit(CommonSignInLoadingState());

      var email = event.email;
      var pass = event.password;

      Map<String, dynamic> loginData = {
        'email': email,
        'password': pass,
      };
      MavenAPIResponse response =
          await commonRepository.commonSignInRequest(loginData);

      if (response is CommonSignInResponseSuccess) {
        print('COMMON SignIn');
        emit(CommonSignInCompletedState(response));
      } else if (response is CommonSignInResponseFailed) {
        if (kDebugMode) {
          print('COMMON SignIn Failed Message: ${response.message}');
          print('COMMON SignIn Failed Status Code: ${response.statusCode}');
          print('COMMON SignIn Failed Error: ${response.error}');
        }
        emit(CommonSignInFailedState(response));
      }
    });

    on<CommonSignInDataNotValidEvent>((event, emit) async {
      emit(CommonSignInDataNotValidState(event.errorMessage));
    });

    on<CommonInitEvent>((event, emit) async {
      emit(CommonAuthInitial());
    });

    on<CommonForgotPasswordEvent>((event, emit) async {
      emit(CommonForgotPasswordLoadingState());
      var email = event.email;
      Map<String, dynamic> formData = {
        'email': email,
      };

      MavenAPIResponse response =
          await commonRepository.commonForgotPasswordRequest(formData);

      if (response is CommonForgotPasswordResponseSuccess) {
        emit(CommonForgotPasswordCompletedState(response));
      } else if (response is CommonForgotPasswordResponseFailed) {
        if (kDebugMode) {}
        emit(CommonForgotPasswordFailedState(response));
      }
    });

    on<CommonResetPasswordEvent>((event, emit) async {
      emit(CommonResetPasswordLoadingState());

      var newPass = event.newPassword;
      var confirmPass = event.confirmNewPassword;
      var resetPassToken = event.token;

      Map<String, dynamic> formData = {
        'password': newPass,
        'confirmPassword': confirmPass,
      };
      MavenAPIResponse response = await commonRepository
          .commonResetPasswordRequest(formData, resetPassToken);

      print('COMMON BLOC : $response');
      if (response is CommonResetPasswordResponseSuccess) {
        emit(CommonResetPasswordCompletedState(response));
      } else if (response is CommonResetPasswordResponseFailed) {
        if (kDebugMode) {
          print('Common BLOC  RESET  Message: ${response.message}');
          print('Common BLOC RESET Failed Status Code: ${response.statusCode}');
          print('Common BLOC RESET Failed Error: ${response.error}');
        }
        emit(CommonResetPasswordFailedState(response));
      }
    });

    on<CommonVerifyEmailEvent>((event, emit) async {
      emit(CommonVerifyEmailLoadingState());

      var verifyToken = event.token;

      MavenAPIResponse response =
          await commonRepository.commonVerifyEmail(verifyToken);

      print('COMMON AUTH BLOC: $response');
      if (response is CommonVerifyEmailResponseSuccess) {
        emit(CommonVerifyEmailCompletedState(response));
      } else if (response is CommonVerifyEmailResponseFailed) {
        if (kDebugMode) {}
        emit(CommonVerifyEmailFailedState(response));
      }
    });
  }
}
