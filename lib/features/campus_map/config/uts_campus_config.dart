import 'package:google_maps_flutter/google_maps_flutter.dart';

class UtsCampusConfig {
  // Center of the campus (Roughly around Block 8 / Academic Resource Centre)
  static const LatLng center = LatLng(2.341500, 111.846000);
  
  // Southwest corner (Padded slightly below Block 5 / Main Entrance)
  static const LatLng southWest = LatLng(2.340000, 111.841500);
  
  // Northeast corner (Padded slightly above Chancellor Hall / Recreation Center)
  static const LatLng northEast = LatLng(2.342800, 111.850500);
  
  // STRICT BOUNDS: The map cannot be dragged outside this box!
  static final LatLngBounds bounds = LatLngBounds(
    southwest: southWest,
    northeast: northEast,
  );

  // Zoom limits to prevent zooming out to the whole world
  static const double minZoom = 16.5; 
  static const double maxZoom = 20.0;

  static const String outOfCampusBannerText = "Not In Campus Area";
}
