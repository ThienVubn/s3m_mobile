import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s3m_mobile/views/login/login_screen.dart';

class BdHomeScreen extends StatefulWidget {
  const BdHomeScreen({super.key});

  @override
  State<BdHomeScreen> createState() => _BdHomeScreenState();
}

class _BdHomeScreenState extends State<BdHomeScreen> {
  String username = "";
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayUsername();
  }
  void displayUsername() async {
    var res = await SharedPreferences.getInstance();
    if(res.getString('username') != null) {
       username = res.getString('username')!.isNotEmpty ? res.getString('username').toString() : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
        ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('username');
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Go back !!'),
        ),
        Text(
          username
        )
      ]),
    );
  }
}
