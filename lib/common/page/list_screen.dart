import 'package:billing_app/common/consants/TableModel.dart';
import 'package:billing_app/common/page/clients/add_client_screen.dart';
import 'package:billing_app/common/page/dashboard_screeen.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  String? title;
  Widget mainComponent;
  String? appBarTitle;
  String? headerTitle;
  bool? backButton;
  void Function()? onPressedBackButton;
  void Function(int)? onBottomNavTap;
  BottomNavigationBar? bottomNavigationBar;
  void Function()? onFloatingButtonPressed;

  ListScreen(
      {Key? key,
      this.title,
      required this.mainComponent,
      this.onBottomNavTap,
      this.appBarTitle,
      this.headerTitle,
      this.onPressedBackButton,
      this.bottomNavigationBar,
      this.onFloatingButtonPressed,
      this.backButton})
      : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  var _selectedIndex = 0;

  Widget build(BuildContext context) {
    return LandingScreen(
      appBarTitle: widget.appBarTitle,
      backButton: true,
      onPressedAppBarButton: () => widget.onPressedBackButton!.call(),
      mainComponent: widget.mainComponent,
      onFloatingButtonPressed: widget.onFloatingButtonPressed,
      bottomNavigationBar: widget.onBottomNavTap == null
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: widget.onBottomNavTap,
              items: const [
                BottomNavigationBarItem(
                    label: "Dashboard", icon: Icon(Icons.dashboard)),
                BottomNavigationBarItem(
                    label: "Add", icon: Icon(Icons.person_add_alt)),
              ],
            ),
    );
  }
}
