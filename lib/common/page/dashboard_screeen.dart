import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/glass_container.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/common/page/clients/client_list_screen.dart';
import 'package:billing_app/common/page/invoice/invoice_list_screen.dart';
import 'package:billing_app/common/page/items/add_item_screen.dart';
import 'package:billing_app/common/page/items/item_list.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreeen extends StatefulWidget {
  const DashboardScreeen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

const menu = [
  "Clients",
  "Items",
  "Invoice",
  "Items",
  "Items",
  "Items",
  "Items",
  // "Items"
];
const menuIcons = [

  Icons.person_add,
  Icons.post_add,
  Icons.accessibility_new_rounded,
  Icons.accessibility_new_rounded,
  Icons.accessibility_new_rounded,
  Icons.accessibility_new_rounded,
  Icons.accessibility_new_rounded,
  Icons.accessibility_new_rounded,
];

class _DashboardScreenState extends State<DashboardScreeen> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return LandingScreen(
        appBarTitle: "Dashboard",
        mainComponent: Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(18),
              width: fullWidth * .9,
              height: fullWidth * .33,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade50, width: 2)),
              child: const Text(
                "Informations:",
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  width: fullWidth,
                  height: fullHeight * .7,
                  padding: EdgeInsets.all(5),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(menu.length, (index) {
                      return Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 50,
                            padding: EdgeInsets.zero,
                             minimumSize: Size(100, 100),
                            fixedSize: Size(fullWidth * .35, fullHeight * .18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: primaryColorRed,
                          ),
                          child: GlassContainer(
                            width: fullWidth * .5,
                            height: fullWidth * .45,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5,35,5,10),
                                child: Column(children: [
                                  Icon(
                                    menuIcons[index],
                                    color: Color(0xFFFFFFFF),
                                    size: 55,
                                  ),
                                  SizedBox(height: fullHeight * .005),
                                  Text(
                                    menu[index],
                                    style: const TextStyle(
                                        fontSize: 20, color: Color(0xFFFFFFFF)),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (menu[index] == 'Clients') {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientListScreen()));
                            } else if (menu[index] == 'Items') {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return ItemListScreen();
                              }));
                            } else if (menu[index] == 'Invoice') {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return InvoiceListScreen();
                              }));
                            } else {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return DashboardScreeen();
                              }));
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
