import 'dart:math';

const double earthRadius = 6372.8;

double distanceBetweenLatLng(
    double lat1, double lon1, double lat2, double lon2) {
  final radiansLat1 = _toRadians(lat1);
  final radiansLat2 = _toRadians(lat2);
  final radiansDeltaLat = _toRadians(lat2 - lat1);
  final radiansDeltaLon = _toRadians(lon2 - lon1);

  final a = pow(sin(radiansDeltaLat / 2), 2) +
      cos(radiansLat1) * cos(radiansLat2) * pow(sin(radiansDeltaLon / 2), 2);
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}
