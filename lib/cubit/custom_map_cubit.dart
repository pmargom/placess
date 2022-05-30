// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';

part 'custom_map_state.dart';

class CustomMapCubit extends Cubit<CustomMapState> {
  CustomMapCubit() : super(CustomMapInitial());

  void init(CameraPosition posicion, List<Place> places) {
    emit(const CustomMapClean(places: []));
    emit(CustomMapSuccess(posicion: posicion, places: places));
  }
}
