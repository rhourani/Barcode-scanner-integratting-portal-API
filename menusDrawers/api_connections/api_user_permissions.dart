import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ioi_barcode_scanner/model/userPermissions/companyList_model.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/user_permissions.dart';

final _base = "https://api.portal.ioi-tech.com";

final _tokenEndpoint = "/api/Account/UserPermissions";
final _tokenURL = _base + _tokenEndpoint;

final _getCompanyendPoint = "/api/Company/";
final _getCompanyURL = _base + _getCompanyendPoint;

final _changePasswordEndPoint = "/api/Account/ChangePassword?oldPassword=";
final _getChangePasswordURL = _base + _changePasswordEndPoint;

Future<UserPermissions> getUserPermissions(dynamic token) async {
  final http.Response response = await http.get(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "$token",
    },
  );
  if (response.statusCode == 200) {
    return UserPermissions.mapFromJsonToDB(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<CompanyDetails> getCompanyDetails(dynamic comID, token) async {
  final http.Response response = await http.get(
    _getCompanyURL+comID.toString(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "$token",
    },
  );
  if (response.statusCode == 200) {
    return CompanyDetails.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

/*
* Settings: Change user password
* */
Future<bool> changePassword(dynamic oldPassword, dynamic newPassword, token) async {
  final http.Response response = await http.put(
    _getChangePasswordURL+oldPassword+"&Password="+newPassword.toString(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "$token",
    },
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}