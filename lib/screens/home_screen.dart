import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/cubit/custom_map_cubit.dart';
import 'package:places_app/shared/location_service.dart';
import 'package:places_app/utils.dart';

import '../cubit/places_cubit.dart';
import '../models/place_model.dart';
import '../widgets/criteria_search.dart';
import '../widgets/error_results.dart';
import '../widgets/initial_results.dart';
import '../widgets/loading.dart';
import '../widgets/results_as_list.dart';
import 'map_screen.dart';

class HomesScreen extends StatefulWidget {
  static const String id = 'home';

  const HomesScreen({Key? key}) : super(key: key);

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  late StreamController<List<Place>> _toggleView;
  // late List<Place> _places;

  @override
  void initState() {
    super.initState();
    _toggleView = StreamController<List<Place>>.broadcast();
    // _places = [];
  }

  @override
  void dispose() {
    _toggleView.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Places'),
            CriteriaSearch(),
            SizedBox(height: 20)
          ],
        ),
        toolbarHeight: 120,
        elevation: 0,
      ),
      body: _buildResults(),
      floatingActionButton:
          _showFloatingButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _showFloatingButton() {
    return StreamBuilder<List<Place>>(
      stream: _toggleView.stream,
      builder: (context, snapshot) {
        final places = snapshot.data ?? [];
        return Visibility(
          visible: places.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () => _showMap(places),
            tooltip: 'Show Map',
            child: const Icon(Icons.map),
          ),
        );
      },
    );
  }

  Widget _buildResults() {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        if (state is PlacesInitial) {
          return const InitialResult();
        }

        if (state is PlacesLoading) {
          return const Loading();
        }

        if (state is PlacesSuccess) {
          _toggleView.sink.add(state.places);
          if (state.places.isEmpty) {
            return const ErrorResults(message: 'No results');
          }

          // _places = state.places;
          return _showData(state.places);
        }

        if (state is PlacesError) {
          return ErrorResults(message: state.message);
        }

        return Container();
      },
    );
  }

  Widget _showData(List<Place> places) {
    return ResultsAsList(places: places);
  }

  void _showMap(List<Place> places) {
    final LatLng coordinates = LatLng(
      LocationService.locationData.latitude!,
      LocationService.locationData.longitude!,
    );

    final initialPosition = initCameraPosition(coordinates, 10);
    final CustomMapCubit customMapCubit =
        BlocProvider.of<CustomMapCubit>(context);

    customMapCubit.init(initialPosition, places);

    Navigator.pushNamed(context, MapScreen.id);
  }

  // void _refresh() {
  //   final placeCubit = BlocProvider.of<PlacesCubit>(context);
  //   placeCubit.search();
  // }
}
