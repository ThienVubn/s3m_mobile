import 'package:flutter/material.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/models/customer.dart';
import 'package:s3m_mobile/constants/constant.dart';

import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';

import 'package:s3m_mobile/services/authService.dart' as auth_service;
import 'package:s3m_mobile/services/customerService.dart' as customer_Service;

class HeaderScreen extends StatefulWidget {
  User? user;
  void Function() onClicked;

  HeaderScreen({super.key, required this.user, required this.onClicked});

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  late List<Customer> customer = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomer();
  }

  Future getCustomer() async {
    var jwt = auth_service.AuthService().getToken();
    Map<String, dynamic> infor = Jwt.parseJwt(jwt.toString());
    if (infor['roles'] != null && infor['roles'].length > 0) {
      if (infor['roles'][0] == "ROLE_ADMIN") {
          var res = await customer_Service.CustomerService().getListCustomer();
          var data = jsonDecode(res['data']);
          for (var item in data) {
            Customer cus = Customer.fromJson(item);
            customer.add(cus);
          }
        }
    }
    for (var item in customer) {
     print(item.customerId.toString() + " - " + item.customerName);
    }
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
                onPressed: widget.onClicked,
                icon: Icon(Icons.menu),
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
