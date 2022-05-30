// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../models/place_model.dart';
import '../services/places_service.dart';

part 'places_details_state.dart';

class PlacesDetailsCubit extends Cubit<PlacesDetailsState> {
  PlacesDetailsCubit() : super(PlacesDetailsInitial()) {
    // search();
  }

  Future<void> search(LocationData locationData, {String criteria = ''}) async {
    emit(PlacesDetailsLoading());
    try {
      final List<Place> places =
          await PlacesService.search(criteria, locationData);
      emit(PlacesDetailsSuccess(places: places));
    } catch (e) {
      emit(const PlacesDetailsError(message: 'Error during search'));
    }
  }
}
