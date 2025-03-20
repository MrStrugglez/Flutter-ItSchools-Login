import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  static const _dbName = "UserData_DB.db";
  static const _dbVersion = 1;

  static const userDataTable = "UserData";
  static const idFieldName = "ID";
  static const usernameFieldName = "Username";
  static const hashFieldName = "Hash";

  Future<Database> get database async {
    return await init();
  }

  Future<Database> init() async {
    final externalDirectory = await getExternalStorageDirectory();

    if (externalDirectory == null) {
      throw Exception("No external directory found to store DB");
    }

    final path = join(externalDirectory.path, _dbName);
    Database database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDatabase,
    );

    return database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await _createUserDataTable(db);
  }

  Future<void> _createUserDataTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $userDataTable (
        $idFieldName INTEGER PRIMARY KEY,
        $usernameFieldName TEXT NOT NULL,
        $hashFieldName TEXT NOT NULL
      )
    ''');
  }
}
