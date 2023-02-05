import 'dart:ui';

import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  String label;
  double? width;
  double? height;
  double? borderRadius;
  Color? backgroundColor;
  Widget? child;
  BorderSide? borderSide;

  void Function()? onTap;

  Button(
      {Key? key,
      required this.label,
      this.height,
      this.width,
      this.borderRadius,
      this.backgroundColor,
      this.child,
      this.borderSide,
      required this.onTap})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(widget.width ?? fullWidth * .98,
                widget.height ?? fullHeight * .07),
            side: widget.borderSide ??
                const BorderSide(
                    width: 6,
                    style: BorderStyle.solid,
                    color: secondaryColorRed),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)),
            primary: widget.backgroundColor ?? primaryColorRed,
          ),
          child: widget.child ??
              Text(
                widget.label,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
    );
  }
}
