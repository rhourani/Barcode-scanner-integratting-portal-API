import 'dart:async';
import 'dart:io';

import 'file:///C:/Users/rido/AndroidStudioProjects/ioi_barcode_scanner/lib/database/tables/table_userToken.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userCompaniesDetails.dart';
import 'package:ioi_barcode_scanner/database/tables/table_user.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userCompanies.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userPermissions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';




class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  String path;

  Database _database;

  Future <Database> get database async {
    if (_database != null){
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  deleteDatabase() async {
    await _database.delete(userTokenTable);
    await _database.delete(userTable);
    await _database.delete(userPermissionsDBTable);
    await _database.delete(userCompaniesDetailsTableDB);
    await _database.delete(userCompaniesTableDB);

  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, "User.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  void onUpgrade(
      Database database,
      int oldVersion,
      int newVersion,
      ){
    if (newVersion > oldVersion){}
  }

  void initDB(Database database, int version) async {
    await database.execute(createUserTokenTableDB);
    await database.execute(createUserTableDB);
    await database.execute(createUserPermissionsDBTable);
    await database.execute(createUserCompaniesDetailsTableDB);
    await database.execute(createUserCompaniesTableDB);

  }
}