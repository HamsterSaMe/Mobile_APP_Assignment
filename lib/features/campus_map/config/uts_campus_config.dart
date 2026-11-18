import 'package:google_maps_flutter/google_maps_flutter.dart';

class UtsCampusConfig {
  static const LatLng center = LatLng(2.3429, 111.8436);
  static const LatLng southWest = LatLng(2.3395, 111.8405);
  static const LatLng northEast = LatLng(2.3465, 111.8470);

  static final LatLngBounds bounds = LatLngBounds(
    southwest: southWest,
    northeast: northEast,
  );

  static const double minZoom = 16.0;
  static const double maxZoom = 20.0;

  static const String outOfCampusBannerText = "Not In Campus Area";
}
