import 'models.dart';

class MapRemoteDatasource {
  Future<List<BlockPinModel>> fetchPins() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate Network Delay
    return [
      BlockPinModel(
        id: 'pin_1',
        blockName: 'Block A',
        sectionTitle: 'Main Entrance',
        description: 'The main administrative entrance of Block A.',
        lat: 2.3430,
        lng: 111.8436,
        imageUrls: ['https://via.placeholder.com/300x200?text=Block+A+Entrance'],
      ),
      BlockPinModel(
        id: 'pin_2',
        blockName: 'Block B',
        sectionTitle: 'Cafeteria Hub',
        description: 'Student cafeteria serving various local cuisines.',
        lat: 2.3435,
        lng: 111.8440,
        imageUrls: ['https://via.placeholder.com/300x200?text=Cafeteria'],
      ),
      BlockPinModel(
        id: 'pin_3',
        blockName: 'Block C',
        sectionTitle: 'Library',
        description: 'Quiet study areas and computer labs.',
        lat: 2.3425,
        lng: 111.8430,
        imageUrls: [
          'https://via.placeholder.com/300x200?text=Library+1',
          'https://via.placeholder.com/300x200?text=Library+2'
        ],
      ),
    ];
  }

  Future<List<PinReportSummary>> fetchReports() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      PinReportSummary(
        id: 'rep_1',
        pinId: 'pin_1',
        title: 'Broken Door Handle',
        reportedAt: DateTime.now().subtract(const Duration(days: 1)),
        isSolved: false,
      ),
      PinReportSummary(
        id: 'rep_2',
        pinId: 'pin_1',
        title: 'Slippery Floor near Stairs',
        reportedAt: DateTime.now().subtract(const Duration(days: 3)),
        isSolved: true,
        resolvedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PinReportSummary(
        id: 'rep_3',
        pinId: 'pin_2',
        title: 'Light bulb out',
        reportedAt: DateTime.now().subtract(const Duration(hours: 5)),
        isSolved: false,
      ),
    ];
  }
}
