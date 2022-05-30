part of 'places_details_cubit.dart';

abstract class PlacesDetailsState extends Equatable {
  const PlacesDetailsState();

  @override
  List<Object> get props => [];
}

class PlacesDetailsInitial extends PlacesDetailsState {}

class PlacesDetailsLoading extends PlacesDetailsState {}

class PlacesDetailsSuccess extends PlacesDetailsState {
  final List<Place> places;

  const PlacesDetailsSuccess({required this.places});
}

class PlacesDetailsError extends PlacesDetailsState {
  final String message;
  const PlacesDetailsError({this.message = ''});
}
