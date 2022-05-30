import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/shared/location_service.dart';

import 'bloc_dependency.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocDependency.setBlocs(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const HomesScreen(),
        routes: {
          HomesScreen.id: (context) => const HomesScreen(),
          MapScreen.id: (context) => const MapScreen(),
          PlaceDetailsScreen.id: ((context) => const PlaceDetailsScreen())
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
