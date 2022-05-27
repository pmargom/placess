part of 'places_cubit.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesSuccess extends PlacesState {
  final List<Place> places;

  const PlacesSuccess({required this.places});
}

class PlacesError extends PlacesState {
  final String message;
  const PlacesError({this.message = ''});
}
