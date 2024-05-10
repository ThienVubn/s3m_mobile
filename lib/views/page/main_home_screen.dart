import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s3m_mobile/constants/constant.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/views/page/footer/footer_screen.dart';
import 'package:s3m_mobile/views/page/header/header_screen.dart';
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

  void onClickedBottomNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onTapSideMenu() {
    _key!.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        endDrawer: Drawer(
          
        /**Profile */
        child: ProfileScreen(user: widget.user)),
        body: Column(children: [

          /**Header Information */
          HeaderScreen(user: widget.user, onClicked: onTapSideMenu),

          /**Display body fragment */
          SingleChildScrollView(
              child: Column(
            children: [body[_currentIndex]],
          )),
        ]),

        /**Footer - Bottom Navigation Bar */
        bottomNavigationBar: FooterScreen(
          selectedIndex: _currentIndex,
          onClicked: onClickedBottomNavigationBar,
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
