import 'package:flutter/material.dart';

import '../models/api_photo_response_model.dart';
import '../models/place_photo_model.dart';
import 'auth/service_base_api_photos.dart';

class PlacePhotoService {
  static final PlacePhotoService _instance = PlacePhotoService._internal();

  PlacePhotoService._internal();

  factory PlacePhotoService() => _instance;

  static Future<List<PlacePhoto>> getPhotos(String fsqId) async {
    try {
      ApiPhotoResponseModel response = await ServicesBaseApiPhotos().get(
        '$fsqId/photos',
        queryParameters: {},
      );

      List<PlacePhoto> placePhotos = placePhotoFromJson(response.data);
      return placePhotos;
    } catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }
}
