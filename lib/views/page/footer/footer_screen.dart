import 'package:flutter/material.dart';
import 'package:s3m_mobile/constants/constant.dart';

class FooterScreen extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  FooterScreen({this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onClicked,
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
          ]       
        );
  }
}