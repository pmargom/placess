import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/place_photo_cubit.dart';
import '../models/place_model.dart';
import '../models/place_photo_model.dart';
import '../shared/user_prefs.dart';
import '../utils.dart';
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
  late StreamController<String> _isFavouriteController;
  late Uri _url;

  @override
  void initState() {
    super.initState();
    _url = Uri.parse('https://foursquare.com/');
    _isFavouriteController = StreamController<String>.broadcast();
    _place = widget.place;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await UserPrefs.prefs;
      final key = '${_place?.fsqId}';
      if (prefs.containsKey(key)) {
        _isFavouriteController.sink.add(key);
      } else {
        _isFavouriteController.sink.add('');
      }
      final String fsqId = _place?.fsqId ?? '';
      if (fsqId.isNotEmpty) {
        await _getPhotos(fsqId);
      }
    });
  }

  @override
  void dispose() {
    _isFavouriteController.close();
    super.dispose();
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
          _showMap(),
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
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _launchUrl,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.remove_red_eye_outlined),
                        SizedBox(width: 6),
                        Text(
                          'Go to website',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
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
                  _place!.categories.isEmpty
                      ? ''
                      : '${_place?.categories.first.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<String>(
            stream: _isFavouriteController.stream,
            builder: (context, snapshot) {
              final newValue = snapshot.data ?? '';
              return IconButton(
                icon: Icon(
                  newValue.isEmpty ? Icons.favorite_outline : Icons.favorite,
                ),
                onPressed: _togleFavourite,
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _togleFavourite() async {
    final prefs = await UserPrefs.prefs;
    final key = '${_place?.fsqId}';
    if (!prefs.containsKey(key)) {
      prefs.setString(key, key);
      _isFavouriteController.sink.add(key);
    } else {
      prefs.remove(key);
      _isFavouriteController.sink.add('');
    }
  }

  Widget _showMap() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: BlocBuilder<PlacePhotoCubit, PlacePhotoState>(
          builder: (context, state) {
        if (state is PlacePhotoLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PlacePhotoSuccess) {
          final photos = state.placePhotos;
          if (photos.isEmpty) {
            return Container();
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: preparePlacePhoto(photos.first),
              fit: BoxFit.cover,
            ),
          );
        }

        return Container();
      }),
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
                .take(10)
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
