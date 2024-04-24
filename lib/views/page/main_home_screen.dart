import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s3m_mobile/constants/constant.dart';
import 'package:s3m_mobile/views/page/home/home_screen.dart';
import 'package:s3m_mobile/views/page/chart/chart_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
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
    Center (
      child: Text("Notifications_Screen"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(
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
        resizeToAvoidBottomInset: true, // set it to false
        body: SingleChildScrollView(child: body[_currentIndex]),
      ),
    );
  }
}
