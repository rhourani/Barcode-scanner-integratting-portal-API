import 'dart:convert';

class ComListPermissions {
  ComListPermissions({
    this.groupName,
    this.companyId,
    this.permissions,
  });

  String groupName;
  int companyId;
  String permissions;
  //List<String> permissions;



  factory ComListPermissions.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      var permissionsObjJson = json['permissions'] as List;
      String s = permissionsObjJson.toString();

      return ComListPermissions(
        groupName: json["groupName"],
        companyId: json["companyID"],
        permissions: s,
      );
    } else {
      return ComListPermissions(
        groupName: json["groupName"],
        companyId: json["companyID"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "companyID": companyId,
        "permissions": permissions,

    //"permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}

class CompanyDetails {

  int companyId;
  String companyName;
  String host;
  String connectionString;
  String phone;
  String address;
  String details;
  String licnExpiration;
  int numProUser;
  int numLimUser;
  bool locked;
  bool hasSAPIntegration;
  String saP_User;
  String groups;

  CompanyDetails({
    this.companyId,
    this.companyName,
    this.host,
    this.connectionString,
    this.phone,
    this.address,
    this.details,
    this.licnExpiration,
    this.numProUser,
    this.numLimUser,
    this.locked,
    this.hasSAPIntegration,
    this.saP_User,
    this.groups,

  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    if(json['groups'] != null) {
      var companyObjJson = json['groups'] as List;
      String s = companyObjJson.toString();

     return CompanyDetails(
      companyId: json["id"],
      companyName: json["name"],
      host: json["host"],
      connectionString: json["connectionString"],
      phone: json["phone"],
      address: json["address"],
      details: json["details"],
      licnExpiration: json["licnExpiration"],
      numProUser: json["numProUser"],
      numLimUser: json["numLimUser"],
      locked: json["locked"],
      hasSAPIntegration: json["hasSAPIntegration"],
      saP_User: json["saP_User"],
      groups: s,
    );
  } else {
      return CompanyDetails(
        companyId: json["id"],
        companyName: json["name"],
        host: json["host"],
        connectionString: json["connectionString"],
        phone: json["phone"],
        address: json["address"],
        details: json["details"],
        licnExpiration: json["licnExpiration"],
        numProUser: json["numProUser"],
        numLimUser: json["numLimUser"],
        locked: json["locked"],
        hasSAPIntegration: json["hasSAPIntegration"],
        saP_User: json["saP_User"],
      );
    }

  }



  Map<String, dynamic> toJson() => {
    "companyID": companyId,
    "companyName": companyName,
    "host": host,
    "connectionString": connectionString,
  };

}