import 'package:flutter/material.dart';
import 'package:places_app/widgets/full_picture_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class PictureWidget extends StatelessWidget {
  final String photo;
  const PictureWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullPictureWidget(photo: photo),
          ),
        );
      }),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 5,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey, width: 1),
        ),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: photo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
