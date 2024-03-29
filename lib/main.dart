import 'package:billing_app/common/components/ScreenSizeHelper.dart';
import 'package:billing_app/common/page/intro_screen.dart';
import 'package:billing_app/common/page/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: IntroScreen());
  }
}
