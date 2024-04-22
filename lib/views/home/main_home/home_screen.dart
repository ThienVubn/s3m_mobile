import 'package:flutter/material.dart';
import 'package:s3m_mobile/views/home/main_home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return const SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true, // set it to false
            body: SingleChildScrollView(child: BdHomeScreen()),
          ),
        );
  }
}