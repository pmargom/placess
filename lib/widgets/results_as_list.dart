import 'package:flutter/material.dart';
import 'package:places_app/utils.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/place_model.dart';

class ResultsAsList extends StatelessWidget {
  final List<Place> places;
  const ResultsAsList({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (_, index) {
          final Place place = places[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 177, 221, 126),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: _preparePlaceIcon(place),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            place.categories.first.name,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(height: 8),
                // if (place.location.formattedAddress != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDistance(place.distance),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Text(
                        place.location.formattedAddress!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _preparePlaceIcon(Place place) =>
      '${place.categories.first.icon.prefix}64${place.categories.first.icon.suffix}';
}
