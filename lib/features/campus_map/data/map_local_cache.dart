import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

class MapLocalCache {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'uts_campus_map_cache.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cached_section_pins (
            id TEXT PRIMARY KEY,
            blockName TEXT,
            sectionTitle TEXT,
            description TEXT,
            lat REAL,
            lng REAL,
            imageUrls TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE cached_pin_reports (
            id TEXT PRIMARY KEY,
            pinId TEXT,
            title TEXT,
            reportedAt INTEGER,
            isSolved INTEGER,
            resolvedAt INTEGER
          )
        ''');
      },
    );
  }

  Future<void> cachePins(List<BlockPinModel> pins) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('cached_section_pins');
      for (var pin in pins) {
        await txn.insert('cached_section_pins', pin.toMap());
      }
    });
  }

  Future<void> cacheReports(List<PinReportSummary> reports) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('cached_pin_reports');
      for (var report in reports) {
        await txn.insert('cached_pin_reports', report.toMap());
      }
    });
  }

  Future<List<BlockPinModel>> getCachedPins() async {
    final db = await database;
    final maps = await db.query('cached_section_pins');
    return maps.map((e) => BlockPinModel.fromMap(e)).toList();
  }

  Future<List<PinReportSummary>> getCachedReports() async {
    final db = await database;
    final maps = await db.query('cached_pin_reports');
    return maps.map((e) => PinReportSummary.fromMap(e)).toList();
  }
}
