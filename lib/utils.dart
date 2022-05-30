String formatDistance(int distance) {
  String unitOfMeasure = 'm';
  String formatedDistance = '$distance';

  if (distance > 999) {
    unitOfMeasure = 'km';
    formatedDistance = (distance / 1000).toStringAsFixed(2);
  }

  return '$formatedDistance\n$unitOfMeasure';
}
