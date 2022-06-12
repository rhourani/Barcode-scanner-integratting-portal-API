class User{
  final String name;
  final String email;
  final String phoneNumber;
  final String sapName;
  final bool isSapEnabled;
  final int userType;
  final bool active;

  User(
      {this.name,
        this.email,
        this.phoneNumber,
        this.sapName,
        this.isSapEnabled,
        this.userType,
        this.active});

  factory User.fromDatabaseJson(Map<String, dynamic> data) {
    return User(
      name: data["name"] as String,
      email: data["email"] as String,
      phoneNumber: data["phoneNumber"] as String,
      sapName: data["sapName"] as String,
      isSapEnabled: data["isSapEnabled"] as bool,
      userType: data["userType"] as int,
      active: data["active"] as bool,
    );
  }
}