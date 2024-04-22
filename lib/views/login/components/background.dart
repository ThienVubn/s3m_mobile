import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s3m_mobile/constants/constant.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xffFFFFFF), (kPrimaryOrangeColor_40)]),
      ),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.3,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/global-02.svg",
                width: size.width,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/icons/logo-02.svg",
                    width: size.width * 0.5,
                  ),
                ),
              ),
              Column(
                children: [child],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
