import 'companyList_model.dart';

class UserPermissions {
  final String userName;
  final  List<ComListPermissions> comLists;
  final bool active;

  final String groupName;
  final int companyId;
  final String permissions;
  final ComListPermissions company;

  UserPermissions({this.company, this.groupName, this.companyId, this.permissions, this.userName, this.active, this.comLists});

  factory UserPermissions.mapFromJsonToDB(Map<String, dynamic> data) {
    if (data['comLists'] != null) {
      var companyObjJson = data['comLists'] as List;
      String s = companyObjJson.toString();

      List<ComListPermissions> _companies = companyObjJson
          .map((companyJson) => ComListPermissions.fromJson(companyJson))
          .toList();

      return UserPermissions(
        userName: data['userName'],
        active: data['active'],
        comLists: _companies,
      );
    } else {
      return UserPermissions(
        userName: data['userName'],
        active: data['active'],
      );
    }
  }

  Map<String, dynamic> mapToDB() => {
        "userName": userName,
        "active": active,
      };

  Map<String, dynamic> toDatabaseForCompany(int index) => {
    "companyID": comLists[index].companyId,
    "groupName": comLists[index].groupName,
    "permissions": comLists[index].permissions,
  };
}
