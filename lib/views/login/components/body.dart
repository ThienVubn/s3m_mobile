import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/material.dart';

import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/views/login/components/background.dart';
import 'package:s3m_mobile/views/home/main_home/home_screen.dart';

import 'package:s3m_mobile/services/authService.dart' as auth_service;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Body> {
  final _formkey = GlobalKey<FormState>();
  User user = User("admin", "SES@2019s3m");

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    var res = await SharedPreferences.getInstance();
    var newuser;
    if(res.getString('username') != null) {
       newuser = res.getString('username')!.isNotEmpty ? res.getString('username').toString() : null;
    }
    
    print(newuser);
    if (newuser != null) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future loginData(BuildContext context) async {
    var res = await auth_service.AuthService().login(user);
    var data = jsonDecode(res['data']);
    int status = res['status'];
    if (status == 200) {
      auth_service.AuthService().saveToken(data['jwt']);
      Map<String, dynamic> infor = Jwt.parseJwt(data['jwt'].toString());
      if (infor['roles'] != null && infor['roles'].length > 0) {
        if (infor['roles'][0] != "ROLE_EVN") {
          // Load and obtain the shared preferences for this app.
          final prefs = await SharedPreferences.getInstance();

          // Save the counter value to persistent storage under the 'counter' key.
          await prefs.setString('username', user.username);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width * 0.7,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: TextEditingController(text: user.username),
                onChanged: (value) {
                  user.username = value;
                },
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Username is Empty';
                    }
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0x77FFFFFF),
                    hintText: 'Username',
                    isDense: true,
                    isCollapsed: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            Container(
              width: size.width * 0.7,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: TextEditingController(text: user.password),
                onChanged: (value) {
                  user.password = value;
                },
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Password is Empty';
                    }
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0x77FFFFFF),
                    hintText: 'Password',
                    isDense: true,
                    isCollapsed: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
              ),
              onPressed: () {
                loginData(context);
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
