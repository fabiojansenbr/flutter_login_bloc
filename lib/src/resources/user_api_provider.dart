import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/user/user.dart';
import '../models/user/authentication.dart';
import './api_exception.dart';

class UserApiProvider {
  Client client = Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<User> authenticate(Authentication credentials) async {
    final response = await client.post("127.0.0.1/auth",
        headers: headers, body: jsonEncode(credentials.toJson()));

    final Map<String, dynamic> parsedJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      return User.fromMap(parsedJson["data"]);
    }
    
    throw ApiException(
        statusCode: response.statusCode,
        message:
            (parsedJson.containsKey("message")) ? parsedJson["message"] : null);
  }
}
