import 'package:flutter/material.dart';
import 'package:s3m_mobile/services/deviceService.dart' as deviceService;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s3m_mobile/views/login/login_screen.dart';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class BdHomeScreen extends StatefulWidget {
  const BdHomeScreen({super.key});

  @override
  State<BdHomeScreen> createState() => _BdHomeScreenState();
}

class _BdHomeScreenState extends State<BdHomeScreen> {
  String username = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayUsername();
  }

  void displayUsername() async {
    var res = await SharedPreferences.getInstance();
    if (res.getString('username') != null) {
      setState(() {
        username = res.getString('username')!.isNotEmpty
            ? res.getString('username').toString()
            : "";
      });
    }
  }

  Future listDv(BuildContext context) async {
    var res = await deviceService.DeviceService().listDevice(1,199,1);
    print(res['data']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: [
        ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('username');
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Go back !!'),
        ),
        Text(username),
        ElevatedButton(
          onPressed: () async {
            listDv(context);
          },
          child: const Text('Test'),
        ),
      ]),
    );
  }
}
