import 'package:flutter/material.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/constants/constant.dart';

class HeaderScreen extends StatefulWidget {
  User? user;
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  HeaderScreen({super.key, required this.user, this.globalKey});

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryBlueColor_100,
      ),
      child: Row(
        children: [
          Text(
            'Hello ' + widget.user!.username,
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
          Spacer(),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: () {
                   widget.globalKey!.currentState?.openEndDrawer(); //<-- SEE HERE
                },
                icon: Icon(Icons.menu),
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
