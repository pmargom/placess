import 'package:flutter/material.dart';
import 'package:places_app/widgets/map_view.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
      ),
      body: const MapView(),
    );
    // return const MapView();
  }
}
