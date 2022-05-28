import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../models/api_response_model.dart';
import '../models/place_model.dart';
import 'auth/service_base_api.dart';

class PlacesService {
  static final PlacesService _instance = PlacesService._internal();

  PlacesService._internal();

  factory PlacesService() => _instance;

  static Future<List<Place>> search(String criteria, LocationData locationData,
      {int limit = 50}) async {
    try {
      ApiResponseModel response = await ServicesBaseApi().get(
        "search",
        queryParameters: {
          'query': criteria,
          'limit': limit,
          'll': '${locationData.latitude},${locationData.longitude}'
        },
      );

      List<Place> places = placesFromJson(response.results);
      return places;
    } catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }
}
