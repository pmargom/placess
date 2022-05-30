import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places_app/cubit/place_photo_cubit.dart';

import 'cubit/custom_map_cubit.dart';
import 'cubit/places_cubit.dart';

class BlocDependency {
  static setBlocs() {
    return <BlocProvider>[
      BlocProvider<PlacesCubit>(
        create: (context) => PlacesCubit(),
      ),
      BlocProvider<CustomMapCubit>(
        create: (context) => CustomMapCubit(),
      ),
      BlocProvider<PlacePhotoCubit>(
        create: (context) => PlacePhotoCubit(),
      )
    ];
  }
}
