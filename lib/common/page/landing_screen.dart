import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/common/components/glass_container.dart';
import 'package:billing_app/common/page/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandingScreen extends StatefulWidget {
  String? appBarTitle;
  String? headerTitle;
  Widget mainComponent;
  IconData? appBarButtonIcon;
  bool? backButton;
  void Function()? onPressedAppBarButton;

  BottomNavigationBar? bottomNavigationBar;

  void Function()? onFloatingButtonPressed;

  LandingScreen(
      {Key? key,
      this.appBarTitle,
      this.headerTitle,
      required this.mainComponent,
      this.onPressedAppBarButton,
      this.bottomNavigationBar,
      this.appBarButtonIcon,
      this.onFloatingButtonPressed,
      this.backButton})
      : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    String? selectedMenu;
    return Scaffold(
      backgroundColor: Color(0xFFCBC8C8),
      appBar: widget.appBarTitle != null
          ? AppBar(
              leading: widget.backButton == true
                  ? BackButton(
                      color: Colors.white,
                      onPressed: () => widget.onPressedAppBarButton == null
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()))
                          : widget.onPressedAppBarButton!
                              .call(), // Change the color here
                    )
                  : PopupMenuButton<String>(
                      initialValue: selectedMenu,
                      // Callback that sets the selected popup menu item.
                      onSelected: (String item) {
                        if (item == "Setting") {
                        } else if (item == "Logout") {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: "Setting",
                          child: Text('Setting'),
                        ),
                        const PopupMenuItem<String>(
                          value: "Logout",
                          child: Text('Logout'),
                        )
                      ],
                    ),
              centerTitle: true,
              backgroundColor: primaryColorRed,
              title: Center(
                  child:
                      Text(widget.appBarTitle ?? "", style: header1TextStyle)),
            )
          : null,
      body: widget.mainComponent,
      floatingActionButton: widget.onFloatingButtonPressed != null
          ? FloatingActionButton(
              onPressed: () => widget.onFloatingButtonPressed!.call(),
              backgroundColor: primaryColorRed,
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
