import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  static final Location _currentLocation = Location();
  static late LocationData locationData;

  static Future<void> init() async {
    await _checkIfLocationServiceIsEnabled();
    await _requestPermissions();
    locationData = await _getCurrentLocation();
  }

  static Future<void> _checkIfLocationServiceIsEnabled() async {
    bool serviceEnabled = await _currentLocation.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _currentLocation.requestService();

      if (!serviceEnabled) {
        return;
      }
    }
  }

  static Future<void> _requestPermissions() async {
    PermissionStatus permissionGranted = await _currentLocation.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _currentLocation.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  static Future<LocationData> _getCurrentLocation() async {
    final LocationData locationData = await _currentLocation.getLocation();
    debugPrint(
        "User location: [${locationData.latitude},${locationData.longitude}]");
    return locationData;
  }
}
