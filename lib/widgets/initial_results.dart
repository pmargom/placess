import 'package:flutter/material.dart';

class InitialResult extends StatelessWidget {
  const InitialResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Enter a search criteria",
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
