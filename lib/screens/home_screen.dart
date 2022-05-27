import 'package:flutter/material.dart';
import 'package:places_app/screens/map_screen.dart';

class HomesScreen extends StatefulWidget {
  static const String id = 'home';

  const HomesScreen({Key? key}) : super(key: key);

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  void _showMap() {
    Navigator.pushNamed(context, MapScreen.id);
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
        onPressed: _showMap,
        tooltip: 'Show Map',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildMainContent() {
    final places = _buildPlaces(20);
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (_, index) {
          final String place = places[index];
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      place,
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
}

List<String> _buildPlaces(int nItems) {
  return List.generate(nItems, ((index) => 'Place $index'));
}
