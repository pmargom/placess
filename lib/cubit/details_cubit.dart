import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial()) {
    // search();
  }

  // Future<void> search(LocationData locationData, {String criteria = ''}) async {
  //   emit(PlacesDetailsLoading());
  //   try {
  //     final List<Place> places =
  //         await PlacesService.search(criteria, locationData);
  //     emit(PlacesDetailsSuccess(places: places));
  //   } catch (e) {
  //     emit(const PlacesDetailsError(message: 'Error during search'));
  //   }
  // }
}
