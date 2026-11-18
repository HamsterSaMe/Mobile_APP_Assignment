import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/campus_map_repository.dart';
import '../data/models.dart';
import '../config/uts_campus_config.dart';

class MapController extends ChangeNotifier {
  final CampusMapRepository _repository = CampusMapRepository();

  List<BlockPinModel> pins = [];
  List<PinReportSummary> reports = [];
  bool isLoading = true;
  bool isOfflineMode = false;
  bool isInCampus = true;
  bool isSimulatingOutside = false;

  StreamSubscription<Position>? _positionStream;

  // Callback to trigger Snackbar on the View layer
  void Function()? onOutOfBounds;

  MapController() {
    _initData();
    _startLocationTracking();
  }

  Future<void> _initData() async {
    isLoading = true;
    notifyListeners();

    pins = await _repository.getPins(forceOffline: isOfflineMode);
    reports = await _repository.getReports(forceOffline: isOfflineMode);

    isLoading = false;
    notifyListeners();
  }

  void toggleOfflineMode() {
    isOfflineMode = !isOfflineMode;
    _initData();
  }

  void toggleLocationSimulation() {
    isSimulatingOutside = !isSimulatingOutside;
    if (isSimulatingOutside) {
      _checkGeofence(const LatLng(2.35, 111.85)); // Force out of bounds
    } else {
      _checkGeofence(UtsCampusConfig.center); // Force in bounds
    }
  }

  Future<void> _startLocationTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    _positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (!isSimulatingOutside) {
        _checkGeofence(LatLng(position.latitude, position.longitude));
      }
    });
  }

  void _checkGeofence(LatLng currentPos) {
    final bounds = UtsCampusConfig.bounds;
    bool inBounds = currentPos.latitude >= bounds.southwest.latitude &&
        currentPos.latitude <= bounds.northeast.latitude &&
        currentPos.longitude >= bounds.southwest.longitude &&
        currentPos.longitude <= bounds.northeast.longitude;

    if (isInCampus != inBounds) {
      isInCampus = inBounds;
      notifyListeners();
      if (!isInCampus) {
        onOutOfBounds?.call();
      }
    }
  }

  List<PinReportSummary> getReportsForPin(String pinId) {
    return reports.where((r) => r.pinId == pinId).toList();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }
}
