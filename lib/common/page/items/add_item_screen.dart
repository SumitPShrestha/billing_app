import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/common/page/items/item_list.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:billing_app/dto/item_dto.dart';
import 'package:billing_app/model/client.dart';
import 'package:billing_app/model/item.dart';
import 'package:billing_app/services/item_service.dart';
import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  late TextEditingController item_id;
  late TextEditingController name;
  late TextEditingController price;
  late TextEditingController quantity;
  late TextEditingController discount;
  late TextEditingController discount_unit;
  late TextEditingController tax_rate;
  late TextEditingController description;
  late ItemDTO? itemDTO;

  AddItemScreen({Key? key, this.itemDTO}) : super(key: key) {
    item_id = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.item_id.toString() : "");
    name = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.name.toString() : "");
    price = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.price.toString() : "");
    quantity = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.quantity.toString() : "");
    discount = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.discount.toString() : "");
    discount_unit = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.discount_unit.toString() : "");
    tax_rate = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.tax_rate.toString() : "");
    description = TextEditingController(
        text: itemDTO != null ? itemDTO!.item!.description.toString() : "");
  }

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String dropdownValue = "1";

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return LandingScreen(
        appBarTitle: "Add Item",
        backButton: true,
        onPressedAppBarButton: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ItemListScreen();
            })),
        mainComponent: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Header1(title: "Item's Info"),
                Center(
                  child: TextInput(
                    controller: widget.name,
                    label: "Item Name",
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: widget.price,
                    label: "Price/Unit",
                    keyboardType: TextInputType.number,
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                      controller: widget.quantity,
                      label: "Inventory",
                      keyboardType: TextInputType.number,
                      isRequired: true),
                ),
                Row(
                  children: [
                    Center(
                      child: TextInput(
                          width: fullWidth * .55,
                          controller: widget.discount,
                          label: "Discount",
                          isRequired: true),
                    ),
                    Center(
                        child: TextInput(
                      label: "Discount Unit",
                      controller: widget.discount_unit,
                      type: 'select',
                      width: fullWidth * .43,
                      height: fullHeight * .11,
                    )),
                  ],
                ),
                Center(
                  child: TextInput(
                    controller: widget.tax_rate,
                    label: "Tax Rate",
                    keyboardType: TextInputType.number,
                  ),
                ),
                Center(
                  child: TextInput(
                    type: 'textarea',
                    height: fullHeight * .17,
                    controller: widget.description,
                    label: "Comment",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Center(
                    child: Button(
                        label: "Add Item",
                        onTap: () async {
                          Item item = Item(
                            widget.itemDTO != null
                                ? widget.itemDTO!.item!.item_id
                                : null,
                            widget.name.value.text,
                            double.parse(widget.price.value.text),
                            int.parse(widget.quantity.value.text),
                            widget.discount.text.isNotEmpty
                                ? double.parse(widget.discount.value.text)
                                : null,
                            widget.discount_unit.text.isNotEmpty
                                ? int.parse(widget.discount_unit.value.text)
                                : null,
                            widget.tax_rate.text.isNotEmpty
                                ? double.parse(widget.tax_rate.value.text)
                                : null,
                            widget.description.value.text,
                          );

                          await ItemService().create(item).then((val) {
                            SnackBar snackBar = SnackBar(
                              content: Text(
                                  'item ${widget.name.value.text} saved successfully'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const ItemListScreen();
                            }));
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
