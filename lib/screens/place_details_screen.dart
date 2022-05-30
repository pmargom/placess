import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places_app/models/place_photo_model.dart';

import '../cubit/place_photo_cubit.dart';
import '../models/place_model.dart';
import '../utils.dart';
import '../widgets/map_widget.dart';
import '../widgets/picture_widget.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static String id = 'placeDetails';
  final Place? place;

  const PlaceDetailsScreen({
    Key? key,
    this.place,
  }) : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late Place? _place;

  @override
  void initState() {
    super.initState();
    _place = widget.place;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String fsqId = _place?.fsqId ?? '';
      if (fsqId.isNotEmpty) {
        await _getPhotos(fsqId);
      }
    });
  }

  Future<void> _getPhotos(String fsqId) async {
    final PlacePhotoCubit placePhotoCubit =
        BlocProvider.of<PlacePhotoCubit>(context);

    await placePhotoCubit.getPhotos(fsqId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_place?.name}'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // _showMap(),
          _createTopDetailsSection(),
          _createAddress(),
          _createDIstance(),
          Expanded(child: _createPicturesSection()),
        ],
      ),
    );
  }

  Widget _createDIstance() {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 16, right: 8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.map_outlined,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            'to ${formatDistance(_place?.distance ?? 0)} from you',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Container _createAddress() {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 16, right: 8),
      width: MediaQuery.of(context).size.width,
      child: Text('${_place?.location.formattedAddress}'),
    );
  }

  Widget _createTopDetailsSection() {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 16, right: 8),
      width: MediaQuery.of(context).size.width,
      // color: Colors.blue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_place?.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_place?.categories.first.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () => {},
          )
        ],
      ),
    );
  }

  Widget _showMap() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: MapWidget(
        places: [widget.place!],
        zoom: 17,
        onTapOnInfoWindowActivated: false,
      ),
    );
  }

  Widget _createPicturesSection() {
    return BlocBuilder<PlacePhotoCubit, PlacePhotoState>(
        builder: (context, state) {
      if (state is PlacePhotoLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is PlacePhotoSuccess) {
        final photos = state.placePhotos;
        if (photos.isEmpty) {
          return Container();
        }

        return Container(
          margin: const EdgeInsets.only(top: 20, left: 16, right: 8),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: photos
                .map(
                  (PlacePhoto photo) => Hero(
                    tag: 'location-img-${photo.id}',
                    child: PictureWidget(
                      photo: preparePlacePhoto(photo),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }

      return Container();
    });
  }
}
