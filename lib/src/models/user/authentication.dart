class Authentication {
  String username;

  String password;

  String firebaseToken;

  Authentication({this.username, this.password, this.firebaseToken});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "username": username,
        "password": password,
        "firebaseToken": firebaseToken,
        "appId": "APP_MEDICOS_GERAL"
      };
}
