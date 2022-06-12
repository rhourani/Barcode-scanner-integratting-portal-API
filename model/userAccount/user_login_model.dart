class UserLogin {
  String email;
  String password;

  UserLogin({this.email, this.password});

  Map <String, dynamic> toJson() => {
    "email": this.email,
    "password": this.password
  };
}

class ResetPassword {
  String oldPassword;
  String newPassword;

  ResetPassword({this.oldPassword, this.newPassword});

  Map <String, dynamic> toJson() => {
    "oldPassword": this.oldPassword,
    "newPassword": this.newPassword
  };
}

/*
class Token{
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token']
    );
  }
}*/