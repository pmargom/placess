import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FullPictureWidget extends StatelessWidget {
  final String photo;
  const FullPictureWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.red[200],
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: photo,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
