import 'package:flutter/material.dart';
import 'package:s3m_mobile/views/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true, // set it to false
            body: SingleChildScrollView(child: Body()),
        ));
  }
}
