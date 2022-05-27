import 'dart:async';

import 'package:dio/dio.dart';

import '../../models/api_mappings.dart';
import '../../models/api_response_model.dart';
import 'interceptors.dart';

class ServicesBaseApi {
  Dio dio = Dio();

  ServicesBaseApi() {
    dio.interceptors.add(AppInterceptors());

    // http options
    dio.options.baseUrl = ApiMappings.placesBaseUrl;
    dio.options.connectTimeout = 100000; //10s
    dio.options.receiveTimeout = 100000;
  }

  Future<ApiResponseModel> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response =
          await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(response.data);
      }

      return ApiResponseModel(error: response.statusMessage);
    } on DioError catch (dioError) {
      return ApiResponseModel(error: dioError.response?.statusMessage);
    } catch (e) {
      return ApiResponseModel(error: e.toString());
    }
  }
}
