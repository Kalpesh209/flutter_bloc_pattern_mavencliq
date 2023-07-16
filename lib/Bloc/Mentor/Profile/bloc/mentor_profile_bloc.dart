import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorBankDetailsResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorEducationalInfoResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorExperienceResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorGeneralInfoResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/AddMentorOtherDetailsResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteEducationResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteMentorExperienceResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/DeleteMentorResumeResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetCadreListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetEducationListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetExperienceListResponseSuccess.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetMentorDomainListResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/GetMentorResumeResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/MentorProfileStatusResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/MentorResumeUploadResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/UpdateMentorEducationResponse.dart';
import 'package:mavencliq/Bloc/Mentor/Profile/UpdateMentorExperienceResponse.dart';
import 'package:mavencliq/Models/Auth/generic_response.dart';
import 'package:mavencliq/Repository/Mentor/Profile/mentor_profile_repository.dart';

part 'mentor_profile_event.dart';
part 'mentor_profile_state.dart';

class MentorProfileBloc extends Bloc<MentorProfileEvent, MentorProfileState> {
  final MentorProfileRepository mentorProfileRepository =
      MentorProfileRepository();

  late String? loginUserToken;
  MentorProfileBloc() : super(MentorProfileInitial()) {
    on<AddMentorAddGeneralInfoEvent>((event, emit) async {
      emit(MentorAddGeneralInfoLoadingState());

      var fileName = event.profileName;
      var filePath = event.profilePath;
      var fullName = event.fullName;
      var contactNo = event.contactNo;
      var dob = event.dob;
      var city = event.city;
      var gender = event.gender;
      var salutation = event.salutation;

      // Need FormData for image only

      FormData data = FormData.fromMap({
        'fullName': fullName,
        'contactNumber': contactNo,
        'dob': dob,
        'city': city,
        'avatar': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType('image', fileName.split('.').last),
        ),
        'gender': gender,
        'salutation': salutation,
      });

      print(data);

      MavenAPIResponse response =
          await mentorProfileRepository.mentorAddGeneralInfoRequest(data);

      if (response is AddMentorGeneralInfoResponseSuccess) {
        emit(MentorAddGeneralInfoCompletedState(response));
      } else if (response is AddMentorGeneralInfoResponseFailed) {
        if (kDebugMode) {
          print('MENTOR ADD GENERAL INFO  Failed Message: ${response.message}');
          print('MENTOR ADD GENERAL INFO Status Code: ${response.statusCode}');
          print('MENTOR ADD GENERAL INFO Error: ${response.error}');
        }
        emit(MentorAddGeneralInfoFailedState(response));
      }
    });

    // Add Educational Info

    on<AddMentorEducationInfoEvent>((event, emit) async {
      emit(MentorAddEducationalInfoLoadingState());
      var degree = event.degree;
      var passingYear = event.passingYear;
      var institute = event.instituteName;

      Map<String, dynamic> data = {
        'degree': degree,
        'passingYear': passingYear,
        'instituteName': institute,
      };

      MavenAPIResponse response =
          await mentorProfileRepository.mentorAddEducationaInfoRequest(data);

      print('MENTOR PROFILE BLOC :: $response');
      if (response is AddMentorEducatioalInfoResponseSuccess) {
        emit(MentorAddEducationalInfoCompletedState(response));
      } else if (response is AddMentorEducatioalInfoResponseFailed) {
        if (kDebugMode) {
          print(
              'MENTOR ADD Educatioal INFO  Failed Message: ${response.message}');
          print(
              'MENTOR ADD Educatioal INFO Status Code: ${response.statusCode}');
          print('MENTOR ADD Educatioal INFO Error: ${response.error}');
        }
        emit(MentorAddEducationalInfoFailedState(response));
      }
    });

    // Get a list of Education

    on<GetMentorEducationListLoadingEvent>((event, emit) async {
      emit(GetMentorEducationListLoadingState());
      var response = await mentorProfileRepository.getMentorEducationList();

      if (response is GetEducationListResponseSuccess) {
        emit(GetMenttorEducationListLoadingCompletedState(response));
      } else if (response is GetEducationListResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(GetMenttorEducationListLoadingFailedState(response));
      }
    });

    // To Delete a Education
    on<DeleteMentorEducationEvent>((event, emit) async {
      emit(DeleteMentorEducationLoadingState());

      var deleteIndex = event.deleteIndex;

      print(deleteIndex);
      var response =
          await mentorProfileRepository.deleteMentorEducation(deleteIndex);

      if (response is DeleteEducationResponseSuccess) {
        emit(DeleteMentorEducationCompletedState(response));
      } else if (response is DeleteEducationResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(DeleteMentorEducationFailedState(response));
      }
    });

    // To Update Data

    on<UpdateMentorEducationEvent>((event, emit) async {
      emit(UpdateMentorEducationLoadingState());

      var updateIndex = event.updateIndex;
      var degree = event.degree;
      var passYear = event.passingYear;
      var institute = event.instituteName;
      Map<String, dynamic> formData = {
        'degree': degree,
        'passingYear': passYear,
        'instituteName': institute,
      };

      var response = await mentorProfileRepository.updateMentorEducation(
          updateIndex, formData);

      if (response is UpdateMentorEducationResponseSuccess) {
        emit(UpdateMentorEducationCompletedState(response));
      } else if (response is UpdateMentorEducationResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(UpdateMentorEducationFailedState(response));
      }
    });

    on<MentorResumeUploadEvent>((event, emit) async {
      emit(UploadMentorResumeLoadingState());

      var fileName = event.fileName;
      var filePath = event.filePath;

      // Need FormData for image only

      FormData data = FormData.fromMap({
        'resume': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });

      MavenAPIResponse response =
          await mentorProfileRepository.mentorResumeUploadRequest(data);

      if (response is MentorResumeUploadResponseSuccess) {
        emit(UploadMentorResumeCompletedState(response));
      } else if (response is MentorResumeUploadResponseFailed) {
        if (kDebugMode) {
          print('MENTOR ReSUME UPLOAD : ${response.message}');
          print('MENTOR ADD GENERAL INFO Status Code: ${response.statusCode}');
          print('MENTOR ADD GENERAL INFO Error: ${response.error}');
        }
        emit(UploadMentorResumeFailedState(response));
      }
    });

    // Add Mentor Experience

    on<MentorAddExperienceEvent>((event, emit) async {
      emit(MentorAddExperienceLoadingState());

      var jobTitle = event.jobTitle;
      var companyName = event.companyName;
      var companyYears = event.companyYears;
      var companyMonths = event.companyMonths;
      var positionInManage = event.positionInManage;

      Map<String, dynamic> data = {
        'jobTitle': jobTitle,
        'companyName': companyName,
        'tenureYears': companyYears,
        'tenureMonths': companyMonths,
        'positioning': positionInManage,
      };

      MavenAPIResponse response =
          await mentorProfileRepository.mentorAddExperienceInfoRequest(data);

      if (response is AddMentorExperienceResponseSuccess) {
        emit(MentorAddExperienceCompletedState(response));
      } else if (response is AddMentorExperienceResponseFailed) {
        if (kDebugMode) {
          print('MENTOR ADD EXPERIENCE DETAIL : ${response.message}');
          print('MENTOR ADD EXPERIENCE DETAIL: ${response.statusCode}');
          print('MENTOR ADD EXPERIENCE DETAIL: ${response.error}');
        }
        emit(MentorAddExperienceFailedState(response));
      }
    });

    // Get Uploaded Resume

    on<GetMentorResumeLoadingEvent>((event, emit) async {
      emit(GetMentorResumeLoadingState());
      var response = await mentorProfileRepository.getMentorResume();

      print('MENTOR PROFILE LINE 106 : $response');
      if (response is GetMentorResumeResponseSuccess) {
        emit(GetMentorResumeLoadingCompletedState(response));
        print('LINE 106 : $response');
      } else if (response is GetMentorResumeResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(GetMentorResumeLoadingFailedState(response));
      }
    });

    on<GetMentorExperienceListLoadingEvent>((event, emit) async {
      emit(GetMentorExperienceListLoadingState());
      var response = await mentorProfileRepository.getMentorExperenceList();

      print(response);

      if (response is GetExperienceListResponseSuccess) {
        emit(GetMentorExperienceListLoadingCompletedState(response));
        print('LINE 106 : $response');
      } else if (response is GetExperienceListResponseFailed) {
        emit(GetMentorExperienceListLoadingFailedState(response));
      }
    });

    on<DeleteMentorResumeEvent>((event, emit) async {
      emit(DeleteMentorResumeLoadingState());
      var response = await mentorProfileRepository.deleteMentorResume();

      if (response is DeleteMentorResumeResponseSuccess) {
        emit(DeleteMentorResumeCompletedState(response));
      } else if (response is DeleteMentorResumeResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(DeleteMentorResumeFailedState(response));
      }
    });

    on<DeleteMentorExperienceEvent>((event, emit) async {
      emit(DeleteMentorExperienceLoadingState());

      var deleteIndex = event.deleteIndex;

      var response =
          await mentorProfileRepository.deleteMentorExperience(deleteIndex!);

      if (response is DeleteMentorExperienceResponseSuccess) {
        emit(DeleteMentorExperienceCompletedState(response));
      } else if (response is DeleteMentorExperienceResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(DeleteMentorExperienceFailedState(response));
      }
    });

    // To Update Mentor Experience

    on<UpdateMentorExperienceEvent>((event, emit) async {
      emit(UpdateMentorExperienceLoadingState());

      var updateIndex = event.updateIndex;
      var jobTitle = event.jobTitle;
      var companyName = event.companyName;
      var tenureInYear = event.tenureInYear;
      var tenureInMonths = event.tenureInMonths;
      var yearInManage = event.yearInManage;
      Map<String, dynamic> formData = {
        'jobTitle': jobTitle,
        'companyName': companyName,
        'tenureYears': tenureInYear,
        'tenureMonths': tenureInMonths,
        'positioning': yearInManage,
      };

      var response = await mentorProfileRepository.updateMentorExperience(
          updateIndex, formData);

      if (response is UpdateMentorExperienceResponseSuccess) {
        emit(UpdateMentorExperienceCompletedState(response));
      } else if (response is UpdateMentorExperienceResponseFailed) {
        if (kDebugMode) {
          print('Update Mentor BLOC LINE 110 : ${response.message}');
          print('Update Mentor BLOC Status Code: ${response.statusCode}');
          print('Update Mentor BLOC Error: ${response.error}');
        }
        emit(UpdateMentorExperienceFailedState(response));
      }
    });
    // To Add Bank Details
    on<AddMentorBankDetailsEvent>((event, emit) async {
      emit(MentorAddBankDetailsLoadingState());
      var accountNo = event.accountNo;
      var accountName = event.accountName;
      var ifscCode = event.ifscCode;

      var pancardNo = event.pancardNo;

      var data = {
        'accountNumber': accountNo,
        'accountName': accountName,
        'ifscCode': ifscCode,
        'pancard': pancardNo,
      };

      MavenAPIResponse response =
          await mentorProfileRepository.mentorAddBankDetailsRequest(data);

      if (response is AddMentorBankDeatilsResponseSuccess) {
        emit(MentorAddBankDetailsCompletedState(response));
      } else if (response is AddMentorBankDeatilsResponseFailed) {
        if (kDebugMode) {
          print('MENTOR BANK  Message: ${response.message}');
          print('MENTOR BANK Status Code: ${response.statusCode}');
          print('MENTOR BANK GENERAL INFO Error: ${response.error}');
        }
        emit(MentorAddBankDetailsFailedState(response));
      }
    });

    on<GetMentorCadreListLoadingEvent>((event, emit) async {
      emit(GetMentorCadreListLoadingState());
      var response = await mentorProfileRepository.getMentorCadreList();

      if (response is GetCadreListResponseSuccess) {
        emit(GetMentorCadreListLoadingCompletedState(response));
      } else if (response is GetMentorCadreListResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(GetMentorCadreListLoadingFailedState(response));
      }
    });

    on<GetMentorDomainListLoadingEvent>((event, emit) async {
      emit(GetMentorDomainListLoadingState());
      var response = await mentorProfileRepository.getMentorDomainList();

      if (response is GetMentorDomainListResponseSuccess) {
        emit(GetMentorDomainListLoadingCompletedState(response));
      } else if (response is GetMentorDomainListResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE BLOC LINE 110 : ${response.message}');
          print('MENTOR PROFILE BLOC Status Code: ${response.statusCode}');
          print('MENTOR PROFILE BLOC Error: ${response.error}');
        }
        emit(GetMentorDomainListLoadingFailedState(response));
      }
    });

    // Add Other Details

    // No Session per Month param added as of now
    on<AddMentorOtherDetailsEvent>((event, emit) async {
      emit(MentorAddOtherDetailsLoadingState());
      var mentorPurpose = event.mentorPurpose;
      var previousMentored = event.previousMentored;
      var sessionMonth = event.sessionPerMonth;
      var cadreList = event.cadreList;
      var domainList = event.domainList;

      var data = {
        'seekMentoring': mentorPurpose,
        'previouslyMentored': previousMentored,
        'sessionsPerMonth': sessionMonth,
        'cadres': cadreList,
        'domains': domainList,
      };

      MavenAPIResponse response =
          await mentorProfileRepository.mentorAddOthersDetailsRequest(data);

      if (response is AddMentorOtherDetailsResponseSuccess) {
        emit(MentorAddOtherDetailsCompletedState(response));
      } else if (response is AddMentorOtherDetailsResponseFailed) {
        if (kDebugMode) {
          print(
              'MENTOR ADD Educatioal INFO  Failed Message: ${response.message}');
          print(
              'MENTOR ADD Educatioal INFO Status Code: ${response.statusCode}');
          print('MENTOR ADD Educatioal INFO Error: ${response.error}');
        }
        emit(MentorAddOtherDetailsFailedState(response));
      }
    });

    // Get a Mentor Profile Status

    on<GetMentorProfileStatusEvent>((event, emit) async {
      emit(GetMentorProfileStatusLoadingState());
      var response = await mentorProfileRepository.getMentorProfileStatus();

      if (response is GetMentorProfileStatusResponseSuccess) {
        emit(GetMentorProfileStatusCompletedState(response));
      } else if (response is GetMentorProfileStatusResponseFailed) {
        if (kDebugMode) {
          print('MENTOR PROFILE STATUS 110 : ${response.message}');
          print('MENTOR PROFILE STATUS Code: ${response.statusCode}');
          print('MENTOR PROFILE STATUS Error: ${response.error}');
        }
        emit(GetMentorProfileStatusFailedState(response));
      }
    });
  }
}
