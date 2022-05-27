import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Constants/apis.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    options.headers['authorization'] = Apis.FOURSQUARE_API_KEY;
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }

  // // @override
  // // Future<dynamic> onRequest(RequestOptions options) async {
  // //   if (options.headers.containsKey('authorization')) {
  // //     options.headers.remove('authorization');
  // //   }

  // //   options.headers['authorization'] = 'Bearer ${Apis.FOURSQUARE_API_KEY}';

  // //   return options;
  // // }

  // @override
  // Future<dynamic> onError(DioError dioError) async {
  //   // if (dioError.response.statusCode == 401 ||
  //   //     dioError.response.statusCode == 403) {
  //   //   try {
  //   //     final TokensModel tokens = userPrefs.tokens;

  //   //     final TokensModel newTokens =
  //   //         await AuthRepository.refreshToken(tokens.refresh);
  //   //     if (newTokens == null) {
  //   //       globalNavigator.navigateAndRemoveUntilTo(CustomRoutes.signIn);
  //   //     } else {
  //   //       newTokens.refresh = tokens.refresh;
  //   //       userPrefs.tokens = newTokens;
  //   //     }
  //   //     return _retry(dioError.request);
  //   //   } catch (e) {
  //   //     await AuthRepository.logOut();
  //   //     globalNavigator.navigateAndRemoveUntilTo(CustomRoutes.signIn);
  //   //   }
  //   // }

  //   return super.onError(dioError);
  // }

  // // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  // //   if (requestOptions.headers.containsKey('authorization')) {
  // //     requestOptions.headers.remove('authorization');
  // //   }

  // //   if (userPrefs.tokens != null) {
  // //     final TokensModel tokens = userPrefs.tokens;
  // //     requestOptions.headers['authorization'] = 'Bearer ${tokens.access_token}';
  // //   }

  // //   final options = new Options(
  // //     method: requestOptions.method,
  // //     headers: requestOptions.headers,
  // //   );
  // //   return new Dio().request<dynamic>(
  // //     requestOptions.path,
  // //     data: requestOptions.data,
  // //     queryParameters: requestOptions.queryParameters,
  // //     options: options,
  // //   );
  // // }

  // // @override
  // Future onResponse(Response response) {
  //   return super.onResponse(response);
  // }
}
