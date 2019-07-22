class User {
  String id;

  String tasyCode;

  String name;

  String occupation;

  String token;

  String picture;

  User(
      {this.id,
      this.tasyCode,
      this.name,
      this.occupation,
      this.picture,
      this.token});

  bool operator ==(o) => o is User && o.id == id && o.tasyCode == tasyCode;
  int get hashCode => id.hashCode ^ tasyCode.hashCode ^ name.hashCode;

  factory User.fromMap(Map<String, dynamic> parsedJson) => User(
      id: parsedJson['id'] as String,
      tasyCode: parsedJson['personCode'] as String,
      name: parsedJson['name'] as String,
      occupation: parsedJson['occupation'] as String,
      picture: parsedJson['picture'] as String,
      token: parsedJson['token'] as String);  
}
