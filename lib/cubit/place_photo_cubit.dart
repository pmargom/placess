// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places_app/models/place_photo_model.dart';
import 'package:places_app/services/place_photo_service.dart';

part 'place_photo_state.dart';

class PlacePhotoCubit extends Cubit<PlacePhotoState> {
  PlacePhotoCubit() : super(PlacePhotoInitial());

  Future<void> getPhotos(String fsqId) async {
    emit(PlacePhotoLoading());
    try {
      final List<PlacePhoto> placePhotos =
          await PlacePhotoService.getPhotos(fsqId);
      emit(PlacePhotoSuccess(placePhotos: placePhotos));
    } catch (e) {
      emit(const PlacePhotoError(message: 'Error during search'));
    }
  }
}
