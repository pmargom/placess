part of 'custom_map_cubit.dart';

abstract class CustomMapState extends Equatable {
  const CustomMapState();

  @override
  List<Object> get props => [];
}

class CustomMapInitial extends CustomMapState {}

class CustomMapSuccess extends CustomMapState {
  final CameraPosition posicion;
  final List<Place> places;

  const CustomMapSuccess({
    required this.posicion,
    required this.places,
  });
}

class CustomMapClean extends CustomMapState {
  final List<Place> places;

  const CustomMapClean({
    required this.places,
  });
}
