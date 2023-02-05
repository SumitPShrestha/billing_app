import 'dart:async';

import 'package:billing_app/common/components/ScreenSizeHelper.dart';
import 'package:billing_app/common/page/auth/login_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper.init(context);
    return Container(
      height: ScreenSizeHelper.INSTANCE!.height,
      width: ScreenSizeHelper.INSTANCE!.width,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Image.asset("assets/images/Logo.png"),
    );
  }
}
