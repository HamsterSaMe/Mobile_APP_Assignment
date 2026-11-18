import 'package:flutter/material.dart';

class MapExternalBridges {
  /// The ONLY outbound bridge connecting this feature to the Make Report page.
  static void openMakeReport(
    BuildContext context, {
    required String pinId,
    required String blockName,
    required String sectionTitle,
    required double lat,
    required double lng,
  }) {
    // Placeholder SnackBar & Dialog for your teammate to easily connect later.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Make Report Page...')),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Make Report (Placeholder)'),
          content: Text(
            'Pin ID: $pinId\n'
            'Block: $blockName\n'
            'Section: $sectionTitle\n'
            'Location: $lat, $lng',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            )
          ],
        );
      },
    );
  }
}
