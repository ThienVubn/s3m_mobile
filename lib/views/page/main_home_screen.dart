import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s3m_mobile/constants/constant.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/models/customer.dart';
import 'package:s3m_mobile/views/page/footer/footer_screen.dart';
import 'package:s3m_mobile/views/page/header/header_screen.dart';
import 'package:s3m_mobile/views/page/home/home_screen.dart';
import 'package:s3m_mobile/views/page/chart/chart_screen.dart';
import 'package:s3m_mobile/views/page/profile/profile_screen.dart';

import 'package:jwt_decode/jwt_decode.dart';

import 'package:s3m_mobile/services/authService.dart' as auth_service;
import 'package:s3m_mobile/services/customerService.dart' as customer_Service;

class MainHomeScreen extends StatefulWidget {
  User? user;
  Customer? customer;
  MainHomeScreen({super.key, required this.user, this.customer});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentIndex = 0;
  late Customer customer = Customer.createAll(0, '');
  late List<Widget> body = body = [const Center()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future init() async {
    /**Lấy danh sách khách hàng */
    List<Customer> listCustomer = [];
    var jwt = auth_service.AuthService().getToken();
    Map<String, dynamic> infor = Jwt.parseJwt(jwt.toString());
    if (infor['roles'] != null && infor['roles'].length > 0) {
      if (infor['roles'][0] == "ROLE_ADMIN") {
        var res = await customer_Service.CustomerService().getListCustomer();
        var data = res['data'];
        for (var item in data) {
          Customer cus = Customer.fromJson(item);
          listCustomer.add(cus);
        }
      }
    }
    /**Gắn giá trị đầu tiên trong danh sách*/
    if (widget.customer?.customerId != null) {
      print('Customer is not empty ');
      setState(() {
        customer.customerId = widget.customer!.customerId;
        customer.customerName = widget.customer!.customerName;
        print(widget.customer?.customerName);
        body = [
          Center(
            child: HomeScreen(customer: widget.customer),
          ),
          const Center(
            child: ChartScreen(),
          ),
          const Center(
            child: Text("Devices_Screen"),
          ),
          const Center(
            child: Text("Notifications_Screen"),
          ),
        ];
      });
    } else {
      if (listCustomer.length > 0) {
        print('Customer is empty and set value ');
        setState(() {
          customer = Customer.fromCustomer(listCustomer[0]);
          body = [
            Center(
              child: HomeScreen(customer: listCustomer[0]),
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
        });
      }
    }
  }

  void onClickedBottomNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onTapSideMenu() {
    _key!.currentState?.openEndDrawer();
  }

  void setCustomer(Customer cus) {
    setState(() {
      customer = Customer.fromCustomer(cus);
      body = [
        Center(
          child: HomeScreen(customer: customer),
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
    });
    Navigator.pop(context);
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
          HeaderScreen(
              user: widget.user,
              customer: customer,
              onClicked: onTapSideMenu),

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
