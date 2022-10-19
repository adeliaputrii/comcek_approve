import 'package:myactivity_project/models/models_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tb_act';
  final String columnId = 'id_act';
  final String columnNik = 'nik';
  final String columnName = 'fullname';
  final String columnSubdivisi = 'subdivisi';
  final String columnLocation = 'location';
  final String columnStatus = 'status';
  final String columnDescription = 'description';
  final String columnTarget = 'target';
  final String columnDateVisit = 'dateVisit';
  final String columnStkNumbers = 'stkNumbers';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'activity.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNik TEXT,"
        "$columnName TEXT,"
        "$columnSubdivisi TEXT,"
        "$columnLocation TEXT,"
        "$columnStatus TEXT,"
        "$columnDescription TEXT,"
        "$columnTarget TEXT,"
        "$columnDateVisit TEXT,"
        "$columnStkNumbers TEXT)";

    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveActivityy(Activityy activityy) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, activityy.toMap());
  }

  //read database
  Future<List?> getAllFormat() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNik,
      columnName,
      columnSubdivisi,
      columnLocation,
      columnStatus,
      columnDescription,
      columnTarget,
      columnDateVisit,
      columnStkNumbers,
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateActivityy(Activityy activityy) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, activityy.toMap(),
        where: '$columnId = ?', whereArgs: [activityy.id_act]);
  }

  //hapus database
  Future<int?> deleteActivityy(int id_act) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id_act]);
  }
}
