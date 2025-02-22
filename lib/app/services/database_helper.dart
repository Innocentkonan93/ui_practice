import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/identity_card.dart';
import 'package:ui_challenge/app/modules/data_extractor/models/vehicle_card.dart';

class DatabaseHelper {
  static const String dbName = 'vehicles_and_drivers.db';
  static const String vehicleCardsTable = 'vehicles';
  static const String idCardsTable = 'idCards';
  static late Database _database;

  Future<Database> get database async {
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $vehicleCardsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        owner TEXT,
        number TEXT,
        registrationPlate TEXT,
        brand TEXT,
        model TEXT,
        cylinder INTEGER,
        gender TEXT,
        color TEXT,
        body TEXT,
        energy TEXT,
        seatingCapacity INTEGER,
        usage TEXT,
        axlesCount INTEGER,
        power INTEGER,
        grossWeight INTEGER,
        emptyWeight INTEGER,
        firstDate TEXT,
        editionDate TEXT,
        cu TEXT,
        remarks TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE $idCardsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        drivingLicenseCategory TEXT,
        country TEXT,
        number TEXT,
        lastName TEXT,
        firstName TEXT,
        dateOfBirth TEXT,
        gender TEXT,
        height TEXT,
        nationality TEXT,
        placeOfBirth TEXT,
        expirationDate TEXT,
        photo TEXT,
        signature TEXT,
        securityFeatures TEXT,
        remarks TEXT
      );
    ''');
  }

  Future<int> insertVehicleCard(VehicleCard vehicle) async {
    final db = await database;
    log(vehicle.firstDate.toString());
    final id = await db.insert(
      vehicleCardsTable,
      vehicle.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<void> insertIdCard(IdentityCard idCard) async {
    final db = await database;
    await db.insert(
      idCardsTable,
      idCard.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VehicleCard>> getAllVehicleCards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(vehicleCardsTable);

    return List.generate(maps.length, (i) {
      // log(maps[i].toString());
      return VehicleCard.fromMap(maps[i]);
    });
  }

  Future<List<IdentityCard>> getAllIdCards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(idCardsTable);

    return List.generate(maps.length, (i) {
      return IdentityCard.fromMap(maps[i]);
    });
  }

  Future<IdentityCard?> getIdCard(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(vehicleCardsTable, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return IdentityCard.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateVehicleCard(int id, VehicleCard vehicle) async {
    final db = await database;
    await db.update(
      vehicleCardsTable,
      vehicle.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateIdCard(int id, IdentityCard driver) async {
    final db = await database;
    await db.update(
      idCardsTable,
      driver.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteVehicleCard(int id) async {
    final db = await database;
    await db.delete(
      vehicleCardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteIdCard(int id) async {
    final db = await database;
    await db.delete(
      idCardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
