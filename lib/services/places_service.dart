import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places_app/services/auth/service_base_api.dart';

import '../models/api_mappings.dart';
import '../models/api_response_model.dart';
import '../models/place_model.dart';
import 'auth/interceptors.dart';

class PlacesService {
  static final PlacesService _instance = PlacesService._internal();

  PlacesService._internal();

  factory PlacesService() => _instance;

  static Future<List<Place>> search({int limit = 50}) async {
    try {
      ApiResponseModel response = await ServicesBaseApi()
          .get("search", queryParameters: {'limit': limit});
      List<Place> places = placesFromJson(response.results);
      return places;
    } catch (ex) {
      debugPrint(ex.toString());
      throw ex;
    }
  }
}
