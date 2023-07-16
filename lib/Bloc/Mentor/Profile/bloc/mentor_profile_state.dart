part of 'mentor_profile_bloc.dart';

@immutable
abstract class MentorProfileState {}

class MentorProfileInitial extends MentorProfileState {}

class MentorAddGeneralInfoLoadingState extends MentorProfileState {}

class MentorAddGeneralInfoCompletedState extends MentorProfileState {
  final AddMentorGeneralInfoResponseSuccess response;

  MentorAddGeneralInfoCompletedState(this.response);
}

class MentorAddGeneralInfoFailedState extends MentorProfileState {
  final AddMentorGeneralInfoResponseFailed response;
  MentorAddGeneralInfoFailedState(this.response);
}

class MentorAddEducationalInfoLoadingState extends MentorProfileState {}

class MentorAddEducationalInfoCompletedState extends MentorProfileState {
  final AddMentorEducatioalInfoResponseSuccess response;

  MentorAddEducationalInfoCompletedState(this.response);
}

class MentorAddEducationalInfoFailedState extends MentorProfileState {
  final AddMentorEducatioalInfoResponseFailed response;
  MentorAddEducationalInfoFailedState(this.response);
}

class GetMentorEducationListLoadingState extends MentorProfileState {}

class GetMenttorEducationListLoadingCompletedState extends MentorProfileState {
  final GetEducationListResponseSuccess response;

  GetMenttorEducationListLoadingCompletedState(this.response);
}

class GetMenttorEducationListLoadingFailedState extends MentorProfileState {
  final GetEducationListResponseFailed response;
  GetMenttorEducationListLoadingFailedState(this.response);
}

class DeleteMentorEducationLoadingState extends MentorProfileState {}

class DeleteMentorEducationCompletedState extends MentorProfileState {
  final DeleteEducationResponseSuccess response;

  DeleteMentorEducationCompletedState(this.response);
}

class DeleteMentorEducationFailedState extends MentorProfileState {
  final DeleteEducationResponseFailed response;

  DeleteMentorEducationFailedState(this.response);
}

class UpdateMentorEducationLoadingState extends MentorProfileState {}

class UpdateMentorEducationCompletedState extends MentorProfileState {
  final UpdateMentorEducationResponseSuccess response;
  UpdateMentorEducationCompletedState(this.response);
}

class UpdateMentorEducationFailedState extends MentorProfileState {
  final UpdateMentorEducationResponseFailed response;
  UpdateMentorEducationFailedState(this.response);
}

class UploadMentorResumeLoadingState extends MentorProfileState {}

class UploadMentorResumeCompletedState extends MentorProfileState {
  final MentorResumeUploadResponseSuccess response;
  UploadMentorResumeCompletedState(this.response);
}

class UploadMentorResumeFailedState extends MentorProfileState {
  final MentorResumeUploadResponseFailed response;
  UploadMentorResumeFailedState(this.response);
}

class MentorAddExperienceLoadingState extends MentorProfileState {}

class MentorAddExperienceCompletedState extends MentorProfileState {
  final AddMentorExperienceResponseSuccess response;

  MentorAddExperienceCompletedState(this.response);
}

class MentorAddExperienceFailedState extends MentorProfileState {
  final AddMentorExperienceResponseFailed response;
  MentorAddExperienceFailedState(this.response);
}

class GetMentorResumeLoadingState extends MentorProfileState {}

class GetMentorResumeLoadingCompletedState extends MentorProfileState {
  final GetMentorResumeResponseSuccess response;

  GetMentorResumeLoadingCompletedState(this.response);
}

class GetMentorResumeLoadingFailedState extends MentorProfileState {
  final GetMentorResumeResponseFailed response;
  GetMentorResumeLoadingFailedState(this.response);
}

class GetMentorExperienceListLoadingState extends MentorProfileState {}

class GetMentorExperienceListLoadingCompletedState extends MentorProfileState {
  final GetExperienceListResponseSuccess response;

  GetMentorExperienceListLoadingCompletedState(this.response);
}

class GetMentorExperienceListLoadingFailedState extends MentorProfileState {
  final GetExperienceListResponseFailed response;
  GetMentorExperienceListLoadingFailedState(this.response);
}

class DeleteMentorResumeLoadingState extends MentorProfileState {}

class DeleteMentorResumeCompletedState extends MentorProfileState {
  final DeleteMentorResumeResponseSuccess response;
  DeleteMentorResumeCompletedState(this.response);
}

class DeleteMentorResumeFailedState extends MentorProfileState {
  final DeleteMentorResumeResponseFailed response;
  DeleteMentorResumeFailedState(this.response);
}

class DeleteMentorExperienceLoadingState extends MentorProfileState {}

class DeleteMentorExperienceCompletedState extends MentorProfileState {
  final DeleteMentorExperienceResponseSuccess response;

  DeleteMentorExperienceCompletedState(this.response);
}

class DeleteMentorExperienceFailedState extends MentorProfileState {
  final DeleteMentorExperienceResponseFailed response;

  DeleteMentorExperienceFailedState(this.response);
}

class UpdateMentorExperienceLoadingState extends MentorProfileState {}

class UpdateMentorExperienceCompletedState extends MentorProfileState {
  final UpdateMentorExperienceResponseSuccess response;
  UpdateMentorExperienceCompletedState(this.response);
}

class UpdateMentorExperienceFailedState extends MentorProfileState {
  final UpdateMentorExperienceResponseFailed response;
  UpdateMentorExperienceFailedState(this.response);
}

class MentorAddBankDetailsLoadingState extends MentorProfileState {}

class MentorAddBankDetailsCompletedState extends MentorProfileState {
  final AddMentorBankDeatilsResponseSuccess response;
  MentorAddBankDetailsCompletedState(this.response);
}

class MentorAddBankDetailsFailedState extends MentorProfileState {
  final AddMentorBankDeatilsResponseFailed response;
  MentorAddBankDetailsFailedState(this.response);
}

class GetMentorCadreListLoadingState extends MentorProfileState {}

class GetMentorCadreListLoadingCompletedState extends MentorProfileState {
  final GetCadreListResponseSuccess response;

  GetMentorCadreListLoadingCompletedState(this.response);
}

class GetMentorCadreListLoadingFailedState extends MentorProfileState {
  final GetMentorCadreListResponseFailed response;
  GetMentorCadreListLoadingFailedState(this.response);
}

class GetMentorDomainListLoadingState extends MentorProfileState {}

class GetMentorDomainListLoadingCompletedState extends MentorProfileState {
  final GetMentorDomainListResponseSuccess response;

  GetMentorDomainListLoadingCompletedState(this.response);
}

class GetMentorDomainListLoadingFailedState extends MentorProfileState {
  final GetMentorDomainListResponseFailed response;
  GetMentorDomainListLoadingFailedState(this.response);
}

class MentorAddOtherDetailsLoadingState extends MentorProfileState {}

class MentorAddOtherDetailsCompletedState extends MentorProfileState {
  final AddMentorOtherDetailsResponseSuccess response;

  MentorAddOtherDetailsCompletedState(this.response);
}

class MentorAddOtherDetailsFailedState extends MentorProfileState {
  final AddMentorOtherDetailsResponseFailed response;
  MentorAddOtherDetailsFailedState(this.response);
}

class GetMentorProfileStatusLoadingState extends MentorProfileState {}

class GetMentorProfileStatusCompletedState extends MentorProfileState {
  final GetMentorProfileStatusResponseSuccess response;
  GetMentorProfileStatusCompletedState(this.response);
}

class GetMentorProfileStatusFailedState extends MentorProfileState {
  final GetMentorProfileStatusResponseFailed response;
  GetMentorProfileStatusFailedState(this.response);
}
