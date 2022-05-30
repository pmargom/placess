import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/place_model.dart';
import '../utils.dart';
import '../widgets/map_widget.dart';

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
          _createPicturesSection(),
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
          Column(
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
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () => {},
          )
        ],
      ),
    );
  }

  Widget _showMap() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.amber,
      child: MapWidget(
        places: [widget.place!],
        zoom: 12,
        onTapOnInfoWindowActivated: false,
      ),
    );
  }

  Widget _createPicturesSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 8),
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: const [
          PictureWidget(),
          PictureWidget(),
          PictureWidget(),
          PictureWidget(),
          PictureWidget(),
          PictureWidget(),
        ],
      ),
    );
  }
}

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width / 5,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey, width: 1)),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image:
            'https://imgcy.trivago.com/c_lfill,d_dummy.jpeg,e_sharpen:60,f_auto,h_450,q_auto,w_450/itemimages/51/47/5147630_v15.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}
