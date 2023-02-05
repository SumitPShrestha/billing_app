import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatefulWidget {
  double height;
  double width;
  Widget child;

   GlassContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  _GlassContainerState createState() => _GlassContainerState();
}

class _GlassContainerState extends State<GlassContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.zero,

        margin: EdgeInsets.zero,
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(

                  border: Border.all(width: 2,color: Colors.black.withOpacity(.4)),
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.white.withOpacity(.4),
                        Colors.white.withOpacity(.1)
                      ])),
            ),
            widget.child
          ],
        ),
      ),
    );
  }
}
