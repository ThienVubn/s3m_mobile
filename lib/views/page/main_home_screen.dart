import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s3m_mobile/constants/constant.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/views/page/home/home_screen.dart';
import 'package:s3m_mobile/views/page/chart/chart_screen.dart';
import 'package:s3m_mobile/views/page/profile/profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  User? user;
  MainHomeScreen({super.key, required this.user});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentIndex = 0;

  List<Widget> body = const [
    Center(
      child: HomeScreen(),
    ),
    Center(
      child: ChartScreen(),
    ),
    Center(
      child: Text("Devices_Screen"),
    ),
    Center(
      child: Text("Notifications_Screen"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        endDrawer: Drawer(
          child: ProfileScreen(user: widget.user,)
        ),

        body: Column(
          children: [
            /**Header Information */
            
            /**HeaderScreen(user: widget.user, key: _key) */
            Container(
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
                          _key!.currentState?.openEndDrawer(); //<-- SEE HERE
                        },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                      )),
                ],
              ),
            ),

            /**Display body fragment */
            SingleChildScrollView(
              child: Column(
            children: [
              body[_currentIndex]
            ],
          )),]
        ),

        /**Bottom Navigation Bar */
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedIconTheme: const IconThemeData(
            color: Colors.white60,
          ),
          unselectedItemColor: Colors.white60,
          backgroundColor: kPrimaryBlueColor_100,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices_rounded),
              label: 'Devices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notifications',
            ),
          ],
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
