part of 'place_photo_cubit.dart';

abstract class PlacePhotoState extends Equatable {
  const PlacePhotoState();

  @override
  List<Object> get props => [];
}

class PlacePhotoInitial extends PlacePhotoState {}

class PlacePhotoLoading extends PlacePhotoState {}

class PlacePhotoSuccess extends PlacePhotoState {
  final List<PlacePhoto> placePhotos;

  const PlacePhotoSuccess({required this.placePhotos});
}

class PlacePhotoError extends PlacePhotoState {
  final String message;
  const PlacePhotoError({this.message = ''});
}
