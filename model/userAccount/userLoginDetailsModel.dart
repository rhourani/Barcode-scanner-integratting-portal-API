import 'package:ioi_barcode_scanner/model/userAccount/user_model.dart';

class UserLoginDetails {
  final String token;
  final String expiration;
  final User user;

  UserLoginDetails({this.token, this.expiration, this.user});

  factory UserLoginDetails.fromDatabaseJson(Map<String, dynamic> data) {
    return UserLoginDetails(
      token: data['token'],
      expiration: data['expiration'],
      user: User.fromDatabaseJson(data['user']),
    );
  }

  Map<String, dynamic> toDatabaseJson() => {
    "id": 0,
    "email": user.email,
    "expiration" : this.expiration,
    "token": this.token,
  };

  Map<String, dynamic> toDatabaseForUserModel() => {
    "name": user.name,
    "email": user.email,
    "phoneNumber": user.phoneNumber,
    "sapName": user.sapName,
    "isSapEnabled": user.isSapEnabled,
    "userType": user.userType,
    "active": user.active,
  };

}
