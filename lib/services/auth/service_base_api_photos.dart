import 'dart:async';

import 'package:dio/dio.dart';

import '../../models/api_mappings.dart';
import '../../models/api_photo_response_model.dart';
import 'interceptors.dart';

class ServicesBaseApiPhotos {
  Dio dio = Dio();

  ServicesBaseApiPhotos() {
    dio.interceptors.add(AppInterceptors());

    // http options
    dio.options.baseUrl = ApiMappings.placesBaseUrl;
    dio.options.connectTimeout = 100000; //10s
    dio.options.receiveTimeout = 100000;
  }

  Future<ApiPhotoResponseModel> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response =
          await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return ApiPhotoResponseModel.fromJson(response.data, '');
      }

      return ApiPhotoResponseModel(error: response.statusMessage);
    } on DioError catch (dioError) {
      return ApiPhotoResponseModel(error: dioError.response?.statusMessage);
    } catch (e) {
      return ApiPhotoResponseModel(error: e.toString());
    }
  }
}
