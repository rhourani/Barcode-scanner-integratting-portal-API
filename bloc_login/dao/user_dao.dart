import 'dart:convert';

import 'file:///C:/Users/rido/AndroidStudioProjects/ioi_barcode_scanner/lib/database/database.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userCompaniesDetails.dart';
import 'package:ioi_barcode_scanner/database/tables/table_user.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userCompanies.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userPermissions.dart';
import 'package:ioi_barcode_scanner/database/tables/table_userToken.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/settings/selectCompanySettings.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/settings/settings.dart';
import 'package:ioi_barcode_scanner/model/userAccount/userLoginDetailsModel.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/companyList_model.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/user_permissions.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(UserLoginDetails user) async {
    final db = await dbProvider.database;
    db.insert(userTable, user.toDatabaseForUserModel());
    var result = db.insert(userTokenTable, user.toDatabaseJson());
    return result;
  }

  Future<int> createUserCompanyDetails(CompanyDetails companyDetails) async {
    final db = await dbProvider.database;
    var result =
        db.insert(userCompaniesDetailsTableDB, companyDetails.toJson());
    return result;
  }

  Future<int> createUserPermissions(UserPermissions userPermissions) async {
    final db = await dbProvider.database;
    var result = db.insert(userPermissionsDBTable, userPermissions.mapToDB());
    int index = userPermissions.comLists.length;
    for (int i = 0; i < index; i++) {
      db.insert(userCompaniesTableDB, userPermissions.toDatabaseForCompany(i));
    }
    return result;
  }

  Future<dynamic> getUser() async {
    final db = await dbProvider.database;
    var res = await db.query(userTable);
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : null;
    }
  }

  Future<String> getUserTokenFromDb() async {
    final db = await dbProvider.database;
    var res = await db
        .rawQuery('SELECT token FROM $userTokenTable where id = ?', ['0']);
    String tkn = res.first['token'];
    String bearer = "Bearer ";
    String finaltkn = bearer + tkn;
    return finaltkn;
  }

  Future<int> howManyCompanyDAO() async {
    var db = await dbProvider.database;
    var res = await db.rawQuery('SELECT companyID FROM $userCompaniesTableDB');
    return res.length;
  }

  Future<bool> checkForLocalCompaniesDAO() async {
    var db = await dbProvider.database;
    try {
      List<Map> companies =
          await db.rawQuery('SELECT * FROM $userCompaniesDetailsTableDB');
      if (companies.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<int> getComID(index) async {
    var db = await dbProvider.database;
    var res = await db.rawQuery('SELECT companyID FROM $userCompaniesTableDB');
    return res.length;
  }

  Future<int> getDAOCompanyIDFromDb(int index) async {
    var db = await dbProvider.database;

    var res = await db.rawQuery(
        'SELECT companyID FROM $userCompaniesTableDB where id = $index');
    var data = res[0];
    int companyID = data['companyID'];

    return companyID;
  }

  Future<dynamic> getCompanyDetails() async {
    final db = await dbProvider.database;
    var res = await db.query(userCompaniesDetailsTableDB);
    if (res.length == 0) {
      return null;
    } else {
      return res;
    }
  }

  Future<List<String>> getAppsPermissionsForUser() async {
    final db = await dbProvider.database;
    //final Settings obj = Settings();

    int id = setCompanyID; // The default company came in id = 1
    var res = await db.rawQuery(
        'SELECT permissions FROM $userCompaniesTableDB WHERE id = $id');
    if (res.length == 0) {
      return null;
    } else {
      var data = res[0];
      String myAppsPermissionsString = data['permissions'];

      String myAppsPermissionsString_2 = myAppsPermissionsString.substring(
          myAppsPermissionsString.indexOf(myAppsPermissionsString[1]),
          myAppsPermissionsString.indexOf(
              myAppsPermissionsString[myAppsPermissionsString.length - 1]));

      var myAppsPermissionsList = myAppsPermissionsString_2.split(',');

      List<String> appsList = [];
      for (int i = 0; i < myAppsPermissionsList.length; i++) {
        String appItem = myAppsPermissionsList[i];
        var getAppStringAfterSub =
            appItem.trim().substring(3, appItem.trim().indexOf("."));
        String appStringTrimmed = getAppStringAfterSub.toString();

        if (!appsList.contains(capitalize(appStringTrimmed))) {
          appsList.add(capitalize(appStringTrimmed));
        }
      }

      return appsList;
    }
  }


  Future<List<String>> getServicesPermissionsForUser() async {
    final db = await dbProvider.database;
    int id = setCompanyID; // The default company came in id = 1
    var res = await db.rawQuery(
        'SELECT permissions FROM $userCompaniesTableDB WHERE id = $id');
    if (res.length == 0) {
      return null;
    } else {
      var data = res[0];
      String myAppsPermissionsString = data['permissions'];

      String myAppsPermissionsString_2 = myAppsPermissionsString.substring(
          myAppsPermissionsString.indexOf(myAppsPermissionsString[1]),
          myAppsPermissionsString.indexOf(
              myAppsPermissionsString[myAppsPermissionsString.length - 1])); // Trimming of [ and ] in the start & and ends of the string

      var myAppsPermissionsList = myAppsPermissionsString_2.split(',');

      List<String> appsList = [];
      for (int i = 0; i < myAppsPermissionsList.length; i++) {
        String appItem = myAppsPermissionsList[i].trim();
        appsList.add(appItem);
      }
      return appsList;
    }
  }

  Future<List<String>> getUserCompaniesNames() async {
    final db = await dbProvider.database;
    var res = await db.rawQuery(
        'SELECT companyName FROM $userCompaniesDetailsTableDB');

    if (res.length == 0) {
      return null;
    } else {
      List<String> comNames = [];
      for(int i=0; i < res.length; i++)
        {
          var data = res[i];
          String comItem = data["companyName"].trim();
          comNames.add(comItem);
        }

      return comNames;
    }
  }


  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  Future<dynamic> getPermissions() async {
    final db = await dbProvider.database;
    var res = await db.query(userPermissionsDBTable);
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      //TODO parse it to map , maybe on the other screen where you wantto use it
      return resMap.isNotEmpty ? resMap : null;
    }
  }

  Future<dynamic> getPermissionsFotCompany() async {
    final db = await dbProvider.database;
    var res = await db.query(userPermissionsDBTable);
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      //TODO parse it to map , maybe on the other screen where you wantto use it
      List<ComListPermissions> _companies = res
          .map((companyJson) => ComListPermissions.fromJson(companyJson))
          .toList();
      return res.isNotEmpty ? res : null;
    }
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(userTokenTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<void> dropUserDB() async {
    await dbProvider.deleteDatabase();
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTokenTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
