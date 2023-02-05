import 'package:flutter/cupertino.dart';

class ScreenSizeHelper {
  static ScreenSizeHelper? INSTANCE = null;

  late double height;
  late double width;
  BuildContext context;

  ScreenSizeHelper(this.context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  static ScreenSizeHelper? init(BuildContext context) {
    INSTANCE = INSTANCE ?? new ScreenSizeHelper(context);
    return INSTANCE;
  }
}
