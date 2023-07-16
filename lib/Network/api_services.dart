import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mavencliq/Utils/api_constants.dart';

class ApiService {
  static ApiService? _apiService;
  late Dio dio;
  final Duration timeOut = kReleaseMode
      ? Duration(milliseconds: 10000)
      : Duration(milliseconds: 5000);

  factory ApiService.getInstance() {
    _apiService ??= ApiService._internal();
    return _apiService!;
  }

  // To get a Data With Query Params

  Future<Response?> getRequestDataWithQueryParam(
    String path,
    String token,
    Map<String, dynamic> queryParam,
  ) async {
    Response? response;
    try {
      var options = Options(headers: {
        'Authorization': 'Bearer $token',
      });

      response = await Dio().get(
        '${ApiConstants.baseURL}$path',
        options: options,
        queryParameters: queryParam,
      );
      print(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return response;
  }

  // To get a List as a response

  // Original

  Future<Response?> getRequestData(String path, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );

      print(path);

      response = await Dio().get(
        '${ApiConstants.baseURL}$path',
        options: options,
      );

      print('LINE 60 API : $response');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return response;
  }

  Future<Response?> patchRequestWithData12(
      String path, Map<String, dynamic> data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );

      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.patch(
        path,
        data: data,
        options: options,
      );

      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in Patch RequestWithData: ${dioError.error}');
        print('DioError in Patch Response: ${dioError.response}');
        print('DioError in Patch Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in Patch: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> patchRequestWithData(
      String path, FormData data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );

      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.patch(
        path,
        data: data,
        options: options,
      );

      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in Patch RequestWithData: ${dioError.error}');
        print('DioError in Patch Response: ${dioError.response}');
        print('DioError in Patch Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in Patch: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> postRequestWithData(
      String path, Map<String, dynamic> data) async {
    Response? response;
    try {
      var dataToSend = jsonEncode(data);
      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.post(path, data: dataToSend);
      print('LINE 84 : $response');
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> securePostRequestWithFormData(
      String path, FormData data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );
      //  var dataToSend = jsonEncode(data);

      print(options);

      print(token);
      if (kDebugMode) {
        print('API SERVICES URL: ${ApiConstants.baseURL}$path');
        print('API SERVICES DATA: ${data.toString()}');
      }
      response = await dio.post(path, data: data, options: options);
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }

      print('API SERVICES : $response');
      print('API SERVICES : ${response.statusCode}');

      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> securepostRequestWithData(
      String path, Map<String, dynamic> data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );
      var dataToSend = jsonEncode(data);

      print(options);

      if (kDebugMode) {
        print('API SERVICES URL: ${ApiConstants.baseURL}$path');
        print('API SERVICES DATA: ${data.toString()}');
      }
      response = await dio.post(path, data: dataToSend, options: options);
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }

      print('API SERVICES : $response');
      print('API SERVICES : ${response.statusCode}');

      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> putRequest(String path, Map<String, dynamic> data) async {
    Response? response;
    try {
      var dataToSend = jsonEncode(data);
      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.put(path, data: dataToSend);

      print('LINE 145 : $response');
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  // Original Put Request

  Future<Response?> securePutRequest(
    String path,
    Map<String, dynamic> data,
    String token,
  ) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );
      var dataToSend = jsonEncode(data);
      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.put(path, data: dataToSend, options: options);
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }

      print('REPO RESPONSE : $response');
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  Future<Response?> postRequest(String path) async {
    Response? response;
    try {
      response = await dio.post(path);
      return response;
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithoutData: $error');
      }
    }
    return response;
  }

  ApiService._internal() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      receiveDataWhenStatusError: true,
      sendTimeout: timeOut,
    );
    dio = Dio(baseOptions);
  }

  Future<Response?> postRequestWithStringOfArrayData(
      String path, List<String> data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );

      var dataToSend = jsonEncode(data);
      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.post(path, data: dataToSend, options: options);
      if (kDebugMode) {
        print('RESPONSE: ${response.data}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in PostRequestWithData: ${dioError.error}');
        print('DioError in PostRequestWithData Response: ${dioError.response}');
        print('DioError in PostRequestWithData Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in PostRequestWithData: ${error.toString()}');
      }
    }
    return response;
  }

  // Delete using a Query Params

  Future<Response?> secureDeleteRequestUsingQueryParams(
      String path, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );

      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
      }
      response = await dio.delete(path, options: options);

      if (kDebugMode) {}
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in secureDeleteRequest: ${dioError.error}');
        print('DioError in secureDeleteRequest Response: ${dioError.response}');
        print('DioError in secureDeleteRequest Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in secureDeleteRequest: ${error.toString()}');
      }
    }
    return response;
  }

  //  To Delete a Specific item in a Parameter
  Future<Response?> secureDeleteRequest(
      String path, Map<String, dynamic> data, String token) async {
    Response? response;
    try {
      var options = Options(
        headers: {'Authorization': 'Bearer $token'},
      );
      var dataToSend = jsonEncode(data);

      if (kDebugMode) {
        print('URL: ${ApiConstants.baseURL}$path');
        print('DATA: ${data.toString()}');
      }
      response = await dio.delete(path, data: dataToSend, options: options);

      if (kDebugMode) {
        print('response: ${response.toString()}');
      }
      return response;
    } on DioError catch (dioError, e) {
      if (kDebugMode) {
        print('DioError in secureDeleteRequest: ${dioError.error}');
        print('DioError in secureDeleteRequest Response: ${dioError.response}');
        print('DioError in secureDeleteRequest Stacktrace: ${e.toString()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error in secureDeleteRequest: ${error.toString()}');
      }
    }
    return response;
  }
}
