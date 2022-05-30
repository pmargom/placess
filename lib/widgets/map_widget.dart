import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import '../shared/location_service.dart';
import '../utils.dart';

class MapWidget extends StatefulWidget {
  final double zoom;
  final List<Place> places;
  final bool onTapOnInfoWindowActivated;
  const MapWidget({
    Key? key,
    required this.zoom,
    required this.places,
    this.onTapOnInfoWindowActivated = true,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final Completer<GoogleMapController> _mapController;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _mapController = Completer();
    _markers = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _markers = buildMarkers(context, widget.places,
            onTapActivated: widget.onTapOnInfoWindowActivated);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: initCameraPosition(
          LatLng(
            LocationService.locationData.latitude!,
            LocationService.locationData.longitude!,
          ),
          14.0,
        ).target,
        zoom: widget.zoom,
      ),
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }
}
