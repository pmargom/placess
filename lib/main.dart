import 'package:flutter/material.dart';
import 'package:places_app/screens/home_screen.dart';
import 'package:places_app/screens/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomesScreen(),
      routes: {
        HomesScreen.id: (context) => const HomesScreen(),
        MapScreen.id: (context) => const MapScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
