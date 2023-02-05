import 'package:billing_app/common/page/dashboard_screeen.dart';
import 'package:billing_app/common/page/items/add_item_screen.dart';
import 'package:billing_app/dto/item_dto.dart';
import 'package:billing_app/services/item_service.dart';
import 'package:flutter/material.dart';

import '../../components/list_item_component.dart';
import '../list_screen.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    Future<List<ItemDTO>> items = ItemService().getAllItems("", 50);

    return ListScreen(
      appBarTitle: "Item List",
      backButton: true,
      onPressedBackButton: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return const DashboardScreeen();
      })),
      mainComponent: FutureBuilder<List<ItemDTO>>(
          future: items,
          builder: (context, AsyncSnapshot<List<ItemDTO>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        return ListItemComponent(
                          headerText: snapshot.data![index].item!.name,
                          subText1:
                              "Gross Price: ${ItemService().getGrossPrice(snapshot.data![index].item!)}",
                        );
                      })
                  : const Center(
                      child: Text(
                      "No Data!!",
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Container(
                child: Column(children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ]),
              ));
            } else {
              return Center(
                child: Container(
                  child: Column(
                    children: const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
      onFloatingButtonPressed: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return AddItemScreen();
      })),
    );
  }
}
