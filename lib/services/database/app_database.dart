import 'package:bmitracker/services/log/app_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// This class used to return the SQL LITE Database instance
class AppDatabase {
  static Future<Database> getInstance() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ag_bmi_database.db');
    // open the database
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table

        await db.execute(
          'CREATE TABLE Records(id TEXT PRIMARY KEY, age INTEGER, weight REAL, height REAL, bmi_status TEXT, bmi_value REAL, created_date INTEGER)',
        );

        await db.execute(
          'CREATE TABLE Auth(id TEXT PRIMARY KEY, name TEXT, created_date INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        AppLog.logValueAndTitle('Old version', oldVersion);
        AppLog.logValueAndTitle('New version', oldVersion);
        if (oldVersion < newVersion) {
          // await alterTable();
        }
      },
    );
    return database;
  }

  Future<void> alterTable(
      Database database, String tableName, String columneName) async {
    await database.execute("ALTER TABLE $tableName ADD "
        "COLUMN $columneName TEXT;");
    return;
  }
}
