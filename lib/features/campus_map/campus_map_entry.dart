import 'package:flutter/material.dart';
import 'presentation/campus_map_screen.dart';

class CampusMapEntry {
  /// The ONLY entry point for the Dashboard to launch the Campus Map feature.
  static void openMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CampusMapScreen()),
    );
  }
}
