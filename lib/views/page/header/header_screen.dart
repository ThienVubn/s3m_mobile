import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:s3m_mobile/models/customer.dart';
import 'package:s3m_mobile/constants/constant.dart';

import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';

import 'package:s3m_mobile/services/authService.dart' as auth_service;
import 'package:s3m_mobile/services/customerService.dart' as customer_Service;
import 'package:s3m_mobile/views/page/home/home_screen.dart';
import 'package:s3m_mobile/views/page/main_home_screen.dart';

class HeaderScreen extends StatefulWidget {
  User? user;
  Customer? customer;
  void Function() onClicked;

  HeaderScreen(
      {super.key, required this.user, this.customer, required this.onClicked});

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  late List<Customer> listCustomer = [];
  late Customer customer = Customer.createAll(0, '');

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
        var data = res['data'];
        for (var item in data) {
          Customer cus = Customer.fromJson(item);
          listCustomer.add(cus);
        }
      }
    }
    if (widget.customer?.customerId != null) {
      setState(() {
        customer.customerId = widget.customer!.customerId;
        customer.customerName = widget.customer!.customerName;
      });
    } else {
      if (listCustomer.length > 0) {
        setState(() {
          customer = Customer.fromCustomer(listCustomer[0]);
        });
      }
    }
  }

  void setCustomer(Customer cus) {
    setState(() {
      customer = Customer.fromCustomer(cus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: kPrimaryBlueColor_100,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'Xin chào ' + widget.user!.username,
                      style: const TextStyle(
                        color: Colors.white,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: widget.onClicked,
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
              height: 30,
              decoration: const BoxDecoration(color: kPrimaryBlueColor_60),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Khách hàng: ${customer.customerName}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              4.0 *
                                              1.5),
                                  child: ListView.builder(
                                    itemCount: listCustomer.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              setCustomer(listCustomer[index]);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainHomeScreen(
                                                            user: widget.user,
                                                            customer:
                                                                listCustomer[index])),
                                              );
                                            },
                                            child: Text(
                                                '${listCustomer[index].customerName}'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: .9,
                                            ),
                                          ]),
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                        size: 25,
                                      )),
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    },
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    color: Colors.white,
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  )
                ],
              )),
        )
      ],
    );
  }
}
