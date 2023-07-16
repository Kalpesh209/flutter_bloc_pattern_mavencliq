enum ApiPaths {
  // Common End Points
  commonlogin,
  commonForgetPassword,
  commonResetPassword,
  commonSendEmailVerification,
  commonVerifyEmail,

  // Mentor End Points
  mentorSignUp,
  sendMentorEmailVerification,
  mentorLogin,
  mentorForgotPassword,
  mentorVerifyEmail,
  mentorResetPassword,
  mentorGeneralInfo,
  mentorEducationalInfo,
  mentorResume,
  mentorExperience,
  mentorBankDetails,
  mentorPricesCadre,
  mentorOtherDetails,
  mentorDomains,
  mentorProfileStatus,

  // Mentee End Points

  menteeSignUp,
  sendMenteeEmailVerification,
  menteeLogin,
  menteeForgotPassword,
  menteeVerifyEmail,
  menteeResetPassword,
}

extension EndPoints on ApiPaths {
  static const String mentorUrl = '/mentor';
  static const String menteeUrl = '/mentee';
  static const String authUrl = '/auth';
  static const String signUpUrl = '/signup';
  static const String sendEmailVerificationUrl = '/send-email-verification';
  static const String forgotPasswordUrl = '/forget-password';
  static const String resetPasswordUrl = '/reset-password/';
  static const String verifyEmailUrl = '/verify-email/';
  static const String loginUrl = '/login';
  static const String profileUrl = '/profile';
  static const String generalInfoUrl = '/general-info';
  static const String educationalUrl = '/education';
  static const String resumeUrl = '/resume';
  static const String experienceUrl = '/experience';
  static const String cadreUrl = '/pricing-cadres';
  static const String bankDetailsUrl = '/bank-details';
  static const String oherDetailsUrl = '/other-info';
  static const String domainsUrl = '/domains';
  static const String profileStatusUrl = '/my-profile-status';

  dynamic getUrl() {
    switch (this) {
      // Common

      case ApiPaths.commonlogin:
        return commonLoginUrl;

      case ApiPaths.commonForgetPassword:
        return commonForgotPassUrl;

      case ApiPaths.commonResetPassword:
        return commonResetPassUrl;

      // Mentor
      case ApiPaths.mentorSignUp:
        return _getMentorSignUpUrl;

      case ApiPaths.sendMentorEmailVerification:
        return _getSendEmailUrl;
      case ApiPaths.mentorLogin:
        return _getLoginUrl;
      case ApiPaths.mentorForgotPassword:
        return _getForgotPassUrl;
      case ApiPaths.mentorVerifyEmail:
        return _getVerifyEmailUrl;
      case ApiPaths.mentorResetPassword:
        return _getMentorResetPassUrl;

      case ApiPaths.mentorGeneralInfo:
        return _getMentorGeneralInfoPassUrl;

      case ApiPaths.mentorEducationalInfo:
        return _getMentorEduInfoPassUrl;

      case ApiPaths.mentorResume:
        return _getMentorResumeUploadUrl;

      case ApiPaths.mentorExperience:
        return _getMentorAddExpUrl;

      case ApiPaths.mentorBankDetails:
        return _getMentorAddBankDetailsUrl;

      case ApiPaths.mentorOtherDetails:
        return _getMentorOtherDetailsUrl;

      case ApiPaths.mentorPricesCadre:
        return _getMentorCadreUrl;

      case ApiPaths.mentorDomains:
        return _getMentorDomainUrl;

      case ApiPaths.mentorProfileStatus:
        return _getMentorProfileStatusUrl;

      // Mentee
      case ApiPaths.menteeSignUp:
        return _getMenteeSignUpUrl;

      case ApiPaths.menteeLogin:
        return _getMenteeSignInUrl;

      case ApiPaths.sendMenteeEmailVerification:
        return _getMenteeSendEmailUrl;

      case ApiPaths.menteeVerifyEmail:
        return _getMenteeVerifyEmailUrl;
      case ApiPaths.menteeForgotPassword:
        return _getMenteeForgotPassUrl;

      case ApiPaths.menteeResetPassword:
        return _getMenteeResetPassUrl;
    }
  }

  // Common

  String commonLoginUrl() {
    return authUrl + loginUrl;
  }

  String commonForgotPassUrl() {
    return authUrl + forgotPasswordUrl;
  }

  String commonResetPassUrl() {
    return authUrl + resetPasswordUrl;
  }

  String commonSendEmailPassUrl() {
    return authUrl + sendEmailVerificationUrl;
  }

  String commonVerifyEmailUrl() {
    return authUrl + verifyEmailUrl;
  }

  // Mentor

  String _getMentorSignUpUrl() {
    return mentorUrl + authUrl + signUpUrl;
  }

  String _getSendEmailUrl() {
    return mentorUrl + authUrl + sendEmailVerificationUrl;
  }

  String _getLoginUrl() {
    return mentorUrl + authUrl + loginUrl;
  }

  String _getForgotPassUrl() {
    return mentorUrl + authUrl + forgotPasswordUrl;
  }

  String _getVerifyEmailUrl() {
    return mentorUrl + authUrl + verifyEmailUrl;
  }

  String _getMentorResetPassUrl() {
    return mentorUrl + authUrl + resetPasswordUrl;
  }

  String _getMentorGeneralInfoPassUrl() {
    return mentorUrl + profileUrl + generalInfoUrl;
  }

  String _getMentorEduInfoPassUrl() {
    return mentorUrl + profileUrl + educationalUrl;
  }

  String _getMentorResumeUploadUrl() {
    return mentorUrl + profileUrl + resumeUrl;
  }

  String _getMentorAddExpUrl() {
    return mentorUrl + profileUrl + experienceUrl;
  }

  String _getMentorAddBankDetailsUrl() {
    return mentorUrl + profileUrl + bankDetailsUrl;
  }

  String _getMentorOtherDetailsUrl() {
    return mentorUrl + profileUrl + oherDetailsUrl;
  }

  String _getMentorCadreUrl() {
    return mentorUrl + profileUrl + cadreUrl;
  }

  String _getMentorDomainUrl() {
    return mentorUrl + profileUrl + domainsUrl;
  }

  String _getMentorProfileStatusUrl() {
    return mentorUrl + profileUrl + profileStatusUrl;
  }

  // Mentee

  String _getMenteeSignUpUrl() {
    return menteeUrl + authUrl + signUpUrl;
  }

  String _getMenteeSendEmailUrl() {
    return menteeUrl + authUrl + sendEmailVerificationUrl;
  }

  String _getMenteeVerifyEmailUrl() {
    return menteeUrl + authUrl + verifyEmailUrl;
  }

  String _getMenteeSignInUrl() {
    return menteeUrl + authUrl + loginUrl;
  }

  String _getMenteeForgotPassUrl() {
    return menteeUrl + authUrl + forgotPasswordUrl;
  }

  String _getMenteeResetPassUrl() {
    return menteeUrl + authUrl + resetPasswordUrl;
  }
}
