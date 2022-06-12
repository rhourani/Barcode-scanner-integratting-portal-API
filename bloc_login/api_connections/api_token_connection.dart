import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ioi_barcode_scanner/model/userAccount/userLoginDetailsModel.dart';
import 'package:ioi_barcode_scanner/model/userAccount/user_login_model.dart';

final _base = "https://api.portal.ioi-tech.com";
final _tokenEndpoint = "/api/Account/token";
final _tokenURL = _base + _tokenEndpoint;

Future<UserLoginDetails> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toJson()),
  );
  if (response.statusCode == 200) {
    return UserLoginDetails.fromDatabaseJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}