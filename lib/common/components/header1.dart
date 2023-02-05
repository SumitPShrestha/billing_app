import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';

class Header1 extends StatefulWidget {
  String title;

  Header1({Key? key, required this.title}) : super(key: key);

  @override
  Header1State createState() => Header1State();
}

class Header1State extends State<Header1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Center(

          child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 2, color: Color(0xff949191)))),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 35, color: primaryColorRed),
            ),
          ),
        ));
  }
}
