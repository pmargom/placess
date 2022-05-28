import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places_app/widgets/criteria_search.dart';
import 'package:places_app/widgets/error_results.dart';
import 'package:places_app/widgets/initial_results.dart';
import 'package:places_app/widgets/loading.dart';

import '../cubit/places_cubit.dart';
import '../models/place_model.dart';
import '../widgets/results_as_list.dart';
import 'map_screen.dart';

class HomesScreen extends StatefulWidget {
  static const String id = 'home';

  const HomesScreen({Key? key}) : super(key: key);

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
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
      floatingActionButton: FloatingActionButton(
        // onPressed: _showMap,
        onPressed: _refresh,
        tooltip: 'Show Map',
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          if (state.places.isEmpty) {
            return const ErrorResults(message: 'No results');
          }
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

  void _showMap() {
    Navigator.pushNamed(context, MapScreen.id);
  }

  void _refresh() {
    final placeCubit = BlocProvider.of<PlacesCubit>(context);
    placeCubit.search();
  }
}
