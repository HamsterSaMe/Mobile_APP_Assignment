import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config/uts_campus_config.dart';
import '../data/models.dart'; // ADDED: Required for BlockPinModel
import 'map_controller.dart';
import 'pin_details_sheet.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  late final MapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
    _controller.onOutOfBounds = () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(UtsCampusConfig.outOfCampusBannerText)),
      );
    };
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPinTapped(String pinId) {
    final pin = _controller.pins.firstWhere((p) => p.id == pinId);
    final pinReports = _controller.getReportsForPin(pinId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => PinDetailsSheet(
        pin: pin,
        reportCount: pinReports.length,
        reports: pinReports,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTS Campus Map'),
        actions: [
          Row(
            children: [
              const Text('Offline DB'),
              Switch(
                value: _controller.isOfflineMode,
                onChanged: (_) => _controller.toggleOfflineMode(),
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: UtsCampusConfig.center,
              zoom: 17.0,
              // Removed bearing: 90.0 to restore default North-Up orientation
            ),
            cameraTargetBounds: CameraTargetBounds(UtsCampusConfig.bounds),
            minMaxZoomPreference: const MinMaxZoomPreference(
              UtsCampusConfig.minZoom,
              UtsCampusConfig.maxZoom,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            
            markers: _controller.pins.map((pin) {
              return Marker(
                markerId: MarkerId(pin.id),
                position: LatLng(pin.lat, pin.lng),
                onTap: () => _onPinTapped(pin.id),
              );
            }).toSet(),
          ),

          if (!_controller.isInCampus)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  UtsCampusConfig.outOfCampusBannerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          if (_controller.isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _controller.toggleLocationSimulation,
        label: Text(_controller.isSimulatingOutside ? 'Simulate Inside' : 'Simulate Outside'),
        icon: const Icon(Icons.gps_fixed),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
