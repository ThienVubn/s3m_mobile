import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/services/userService.dart' as userService;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s3m_mobile/views/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  User? user;
  ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User userSES = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future getUser() async {
    var res = await userService.UserService()
        .getUserByUsername(widget.user!.username);
    var data = res['data'];
    setState(() {
      userSES.phone = data['phone'];
      userSES.email = data['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text( userSES.phone),
        Text( userSES.email),
         ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('username');
            Navigator.of(context).popUntil(
            (route) => route.isFirst);
          },
          child: const Text('Go back !!'),
        ),
      ],
    );
  }
}
