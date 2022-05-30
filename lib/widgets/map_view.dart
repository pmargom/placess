import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../shared/location_service.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> markers = {};
  static LatLng showLocation = LatLng(
    LocationService.locationData.latitude!,
    LocationService.locationData.longitude!,
  );

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(
      LocationService.locationData.latitude!,
      LocationService.locationData.longitude!,
    ),
    zoom: 5.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        markers: getmarkers(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(27.7099116, 85.3132343), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
