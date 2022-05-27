import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/places_cubit.dart';

class BlocDependency {
  static setBlocs() {
    return [
      BlocProvider<PlacesCubit>(
        create: (context) => PlacesCubit(),
      ),
    ];
  }
}
