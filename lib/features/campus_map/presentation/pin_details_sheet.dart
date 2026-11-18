import 'package:flutter/material.dart';
import '../data/models.dart';
import '../navigation/map_external_bridges.dart';
import 'pin_reports_dialog.dart';

class PinDetailsSheet extends StatelessWidget {
  final BlockPinModel pin;
  final int reportCount;
  final List<PinReportSummary> reports;

  const PinDetailsSheet({
    super.key,
    required this.pin,
    required this.reportCount,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pin.blockName, style: Theme.of(context).textTheme.titleLarge),
          Text(pin.sectionTitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
          const SizedBox(height: 12),
          if (pin.imageUrls.isNotEmpty)
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pin.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(
                      pin.imageUrls[index],
                      width: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 160,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 12),
          Text(pin.description),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  showDialog(context: context, builder: (_) => PinReportsDialog(reports: reports));
                },
                child: Text('Show Report ($reportCount)'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  MapExternalBridges.openMakeReport(
                    context,
                    pinId: pin.id,
                    blockName: pin.blockName,
                    sectionTitle: pin.sectionTitle,
                    lat: pin.lat,
                    lng: pin.lng,
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Report'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
