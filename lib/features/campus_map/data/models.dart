class BlockPinModel {
  final String id;
  final String blockName;
  final String sectionTitle;
  final String description;
  final double lat;
  final double lng;
  final List<String> imageUrls;

  BlockPinModel({
    required this.id,
    required this.blockName,
    required this.sectionTitle,
    required this.description,
    required this.lat,
    required this.lng,
    required this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'blockName': blockName,
      'sectionTitle': sectionTitle,
      'description': description,
      'lat': lat,
      'lng': lng,
      'imageUrls': imageUrls.join(','),
    };
  }

  factory BlockPinModel.fromMap(Map<String, dynamic> map) {
    return BlockPinModel(
      id: map['id'],
      blockName: map['blockName'],
      sectionTitle: map['sectionTitle'],
      description: map['description'],
      lat: map['lat'],
      lng: map['lng'],
      imageUrls: (map['imageUrls'] as String).isNotEmpty ? (map['imageUrls'] as String).split(',') : [],
    );
  }
}

class PinReportSummary {
  final String id;
  final String pinId;
  final String title;
  final DateTime reportedAt;
  final bool isSolved;
  final DateTime? resolvedAt;

  PinReportSummary({
    required this.id,
    required this.pinId,
    required this.title,
    required this.reportedAt,
    required this.isSolved,
    this.resolvedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pinId': pinId,
      'title': title,
      'reportedAt': reportedAt.millisecondsSinceEpoch,
      'isSolved': isSolved ? 1 : 0,
      'resolvedAt': resolvedAt?.millisecondsSinceEpoch,
    };
  }

  factory PinReportSummary.fromMap(Map<String, dynamic> map) {
    return PinReportSummary(
      id: map['id'],
      pinId: map['pinId'],
      title: map['title'],
      reportedAt: DateTime.fromMillisecondsSinceEpoch(map['reportedAt']),
      isSolved: map['isSolved'] == 1,
      resolvedAt: map['resolvedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['resolvedAt']) : null,
    );
  }
}
