import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/services/userService.dart' as userService;
import 'package:jwt_decode/jwt_decode.dart';

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
    var data = jsonDecode(res['data']);
    setState(() {
      userSES.phone = data['phone'];
      userSES.email = data['email'];
    });

    print(userSES.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text( userSES.phone),
        Text( userSES.email)
      ],
    );
  }
}
