import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/constants/auth_api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:sweet_cookie/sweet_cookie.dart';

class AuthService {
  String _key = "access_token";
  String _store = "user-storage";

  AuthService() {
    this._key = "access_token";
    this._store = "user-storage";
  }

  Future login(User user) async {
    var res = await http.post(Uri.parse(AUTH_API['LOGIN'].toString()),
        headers: {"Content-Type": "application/json"},
        body: json
            .encode({'username': user.username, 'password': user.password}));

    return {'data': res.body, 'status': res.statusCode};
  }

  getToken() {
    var access_token = SweetCookie.get("access_token");
    return access_token;
  }

  saveToken(value) {
    SweetCookie.set("access_token", value.toString());
  }
}
