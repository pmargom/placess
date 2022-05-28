import 'package:flutter/material.dart';

class ErrorResults extends StatelessWidget {
  final String message;
  const ErrorResults({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
