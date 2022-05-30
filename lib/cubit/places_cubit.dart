// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../models/place_model.dart';
import '../services/places_service.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesInitial());

  Future<void> search(LocationData locationData, {String criteria = ''}) async {
    emit(PlacesLoading());
    try {
      final List<Place> places =
          await PlacesService.search(criteria, locationData);
      emit(PlacesSuccess(places: places));
    } catch (e) {
      emit(const PlacesError(message: 'Error during search'));
    }
  }
}
