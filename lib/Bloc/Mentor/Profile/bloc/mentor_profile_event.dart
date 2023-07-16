part of 'mentor_profile_bloc.dart';

@immutable
abstract class MentorProfileEvent {}

class AddMentorAddGeneralInfoEvent extends MentorProfileEvent {
  final String salutation;
  final String fullName;
  final String contactNo;
  final String city;
  final String gender;
  final String dob;
  final String profileName;
  final String profilePath;

  AddMentorAddGeneralInfoEvent(
    this.salutation,
    this.fullName,
    this.contactNo,
    this.city,
    this.dob,
    this.gender,
    this.profileName,
    this.profilePath,
  );
}

class AddMentorEducationInfoEvent extends MentorProfileEvent {
  final String degree;
  final String passingYear;
  final String instituteName;

  AddMentorEducationInfoEvent(
    this.degree,
    this.passingYear,
    this.instituteName,
  );
}

class GetMentorEducationListLoadingEvent extends MentorProfileEvent {}

class GetMentorEducationListLoadingSuccessEvent extends MentorProfileEvent {}

class GetMentorEducationListLoadingFailedEvent extends MentorProfileEvent {}

class DeleteMentorEducationEvent extends MentorProfileEvent {
  final int deleteIndex;

  DeleteMentorEducationEvent(
    this.deleteIndex,
  );
}

class UpdateMentorEducationEvent extends MentorProfileEvent {
  final int updateIndex;
  final String degree;
  final String passingYear;
  final String instituteName;

  UpdateMentorEducationEvent(
    this.updateIndex,
    this.degree,
    this.instituteName,
    this.passingYear,
  );
}

class MentorResumeUploadEvent extends MentorProfileEvent {
  final String fileName;
  final String filePath;

  MentorResumeUploadEvent(
    this.fileName,
    this.filePath,
  );
}

class MentorAddExperienceEvent extends MentorProfileEvent {
  final String jobTitle;
  final String companyName;
  final int companyYears;
  final int companyMonths;
  final int positionInManage;

  MentorAddExperienceEvent(
    this.jobTitle,
    this.companyName,
    this.companyYears,
    this.companyMonths,
    this.positionInManage,
  );
}

class GetMentorResumeLoadingEvent extends MentorProfileEvent {}

class GetMentorResumeSuccessEvent extends MentorProfileEvent {}

class GetMentorResumeFailedEvent extends MentorProfileEvent {}

// Get Experience List

class GetMentorExperienceListLoadingEvent extends MentorProfileEvent {}

class GetMentorExperienceLoadingSuccessEvent extends MentorProfileEvent {}

class GetMentorExperienceFailedEvent extends MentorProfileEvent {}

class DeleteMentorResumeEvent extends MentorProfileEvent {
  DeleteMentorResumeEvent();
}

class DeleteMentorExperienceEvent extends MentorProfileEvent {
  final int? deleteIndex;

  DeleteMentorExperienceEvent(
    this.deleteIndex,
  );
}

class UpdateMentorExperienceEvent extends MentorProfileEvent {
  final int updateIndex;
  final String jobTitle;
  final String companyName;
  final int tenureInYear;
  final int tenureInMonths;
  final int yearInManage;

  UpdateMentorExperienceEvent(
    this.updateIndex,
    this.jobTitle,
    this.companyName,
    this.tenureInYear,
    this.tenureInMonths,
    this.yearInManage,
  );
}

class AddMentorBankDetailsEvent extends MentorProfileEvent {
  final String accountNo;
  final String accountName;
  final String ifscCode;
  final String pancardNo;

  AddMentorBankDetailsEvent(
    this.accountNo,
    this.accountName,
    this.ifscCode,
    this.pancardNo,
  );
}

class GetMentorCadreListLoadingEvent extends MentorProfileEvent {}

class GetMentorCadreListLoadingSuccessEvent extends MentorProfileEvent {}

class GetMentorCadreListLoadingFailedEvent extends MentorProfileEvent {}

class GetMentorDomainListLoadingEvent extends MentorProfileEvent {}

class GetMentorDomainLoadingSuccessEvent extends MentorProfileEvent {}

class GetMentorDomainLoadingFailedEvent extends MentorProfileEvent {}

class AddMentorOtherDetailsEvent extends MentorProfileEvent {
  final String mentorPurpose;
  final String previousMentored;
  final int sessionPerMonth;
  final List<Map<String, dynamic>> cadreList;
  final List<Map<String, dynamic>> domainList;

  AddMentorOtherDetailsEvent(
    this.mentorPurpose,
    this.previousMentored,
    this.sessionPerMonth,
    this.cadreList,
    this.domainList,
  );
}

class GetMentorProfileStatusEvent extends MentorProfileEvent {
  GetMentorProfileStatusEvent();
}
