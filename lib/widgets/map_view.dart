import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/utils.dart';

import '../cubit/custom_map_cubit.dart';
import '../shared/location_service.dart';
import 'map_widget.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showMap(initCameraPosition(
        LatLng(
          LocationService.locationData.latitude!,
          LocationService.locationData.longitude!,
        ),
        5.5,
      )),
    );
  }

  Widget _showMap(CameraPosition position) {
    return BlocBuilder<CustomMapCubit, CustomMapState>(
      builder: (context, state) {
        if (state is CustomMapInitial) {
          return Container();
        }

        if (state is CustomMapSuccess) {
          return MapWidget(
            places: state.places,
            zoom: 14,
          );
        }

        return Container();
      },
    );
  }
}
