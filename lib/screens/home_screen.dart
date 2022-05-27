import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../cubit/places_cubit.dart';
import '../models/place_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        elevation: 0,
      ),
      body: _buildMainContent(),
      floatingActionButton: FloatingActionButton(
          // onPressed: _showMap,
          onPressed: _refresh,
          tooltip: 'Show Map',
          child: const Icon(Icons
              .add)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildMainContent() {
    return BlocBuilder<PlacesCubit, PlacesState>(
      // listener: (context, state) {},
      builder: (context, state) {
        if (state is PlacesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

        if (state is PlacesSuccess) {
          return _showData(state.places);
        }

        if (state is PlacesError) {
          return Center(child: Text(state.message));
        }

        return Container();
      },
    );
  }

  Widget _showData(List<Place> places) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (_, index) {
          final Place place = places[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 48,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        '${place.categories.first.icon.prefix}64${place.categories.first.icon.suffix}',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      place.fsqId,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  onPressed: _showMap,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMap() {
    Navigator.pushNamed(context, MapScreen.id);
  }

  void _refresh() {
    final placeCubit = BlocProvider.of<PlacesCubit>(context);
    placeCubit.search();
  }
}
