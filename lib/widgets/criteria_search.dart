import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/places_cubit.dart';
import '../shared/location_service.dart';

class CriteriaSearch extends StatelessWidget {
  const CriteriaSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 20),
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onSubmitted: (value) => _doSearch(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a value",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void _doSearch(BuildContext context, String criteria) {
    final placeCubit = BlocProvider.of<PlacesCubit>(context);
    placeCubit.search(LocationService.locationData, criteria: criteria);
  }
}
