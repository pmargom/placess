import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place_photo_model.dart';
import 'package:places_app/screens/place_details_screen.dart';

import 'models/place_model.dart';

String formatDistance(int distance) {
  String unitOfMeasure = 'm';
  String formatedDistance = '$distance';

  if (distance > 999) {
    unitOfMeasure = 'km';
    formatedDistance = (distance / 1000).toStringAsFixed(2);
  }

  return '$formatedDistance $unitOfMeasure';
}

String preparePlaceIcon(Place place) =>
    '${place.categories.first.icon.prefix}64${place.categories.first.icon.suffix}';

String preparePlacePhoto(PlacePhoto photo) =>
    '${photo.prefix}500x650${photo.suffix}';

CameraPosition initCameraPosition(LatLng coordinates, double zoom) {
  return CameraPosition(
    target: LatLng(
      coordinates.latitude,
      coordinates.longitude,
    ),
    zoom: zoom,
  );
}

Set<Marker> buildMarkers(BuildContext context, List<Place> places,
    {bool onTapActivated = true}) {
  Set<Marker> markers = {};
  places.forEach((Place place) {
    final LatLng coordinates = LatLng(
      place.geocodes.main.latitude,
      place.geocodes.main.longitude,
    );

    markers.add(Marker(
      markerId: MarkerId(place.fsqId),
      position: coordinates, //position of marker
      infoWindow: InfoWindow(
          title: place.name,
          snippet: place.categories.first.name,
          onTap: !onTapActivated
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailsScreen(
                        place: place,
                      ),
                    ),
                  );
                }),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  });

  return markers;
}
