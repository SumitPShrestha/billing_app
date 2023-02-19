import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/dto/item_dto.dart';
import 'package:billing_app/model/item.dart';
import 'package:billing_app/services/item_service.dart';
import 'package:flutter/material.dart';

import '../../dto/invoice_item_dto.dart';

class AddItemComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddItemComponentState();

  TextEditingController itemController;
  TextEditingController quantityController;
  TextEditingController priceController;
  List<InvoiceItemDTO>? itemDTOs = [];

  AddItemComponent(this.itemController, this.quantityController,
      this.priceController, this.itemDTOs);
}

class AddItemComponentState extends State<AddItemComponent> {
  int noOfItems = 0;
  InvoiceItemDTO? itemDTO = null;
  List<InvoiceItemDTO>? itemDTOs = [];
  Item? selectedItem;
  TextEditingValue textEditingValue = TextEditingValue();
  TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemDTOs = widget.itemDTOs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    itemController = widget.itemController;
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        children: [
          Center(
            child: Autocomplete<Item>(
              optionsBuilder: (textEditingValue) async {
                if (textEditingValue.text.length > 2) {
                  var iterable = ItemService().getClientsWhere(["name"],
                      [textEditingValue.text.toLowerCase() + "%"], 50);
                  return iterable;
                } else {
                  return [];
                }
              },
              displayStringForOption: (Item? option) => option!.name ?? "",
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                itemController = fieldTextEditingController;
                return TextInput(
                  height: fullHeight*.086,
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  label: "Items",
                );
              },
              onSelected: (Item selection) {
                setState(() {
                  print('object');
                  itemDTO = itemDTO ?? InvoiceItemDTO();
                  selectedItem = selection;
                  widget.quantityController.text = '1';
                  widget.priceController.text = selection.price.toString();

                  ;
                });
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<Item> onSelected,
                  Iterable<Item> options) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    child: Container(
                      margin: EdgeInsets.zero,
                      width: fullWidth*.9,
                      height: double.parse(
                          (options.length > 0 ? (60 * options.length) : 60)
                              .toString()),
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 5),
                      color: Colors.white60,
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 5),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Item option = options.elementAt(index);

                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option.name ?? "",
                                  style: const TextStyle(color: labelTextGrey)),
                              subtitle: Text('${option.quantity} remaining in inventory'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Center(
                child: TextInput(
                  height: fullHeight*.12,
                  controller: widget.quantityController,
                  padding: EdgeInsets.fromLTRB(18, 5, 0, 5),
                  margin: EdgeInsets.fromLTRB(18, 5, 0, 10),
                  label: "Quantity",
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  width: fullWidth * .4,
                  onChange: (String val) {
                    if (val.isNotEmpty) {
                      int quantity = int.parse(val);
                      setState(() {
                        if (selectedItem != null) {
                          widget.priceController.text =
                              (double.parse(quantity.toString()) *
                                      (selectedItem?.price ?? 1.00))
                                  .toString();
                        }
                      });
                    }
                  },
                ),
              ),
              Center(
                child: TextInput(
                    width: fullWidth * .4,
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    controller: widget.priceController,
                    label: "Price",
                    isRequired: true),
              ),
              Center(
                child: Container(
                    height: fullHeight * .055,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.fromLTRB(5, 5, 15, 15),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColorRed, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: fullWidth * .11,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            InvoiceItemDTO? dto = InvoiceItemDTO();
                            dto.quantity =
                                int.parse(widget.quantityController.text);
                            dto.item = selectedItem;
                            itemController.clear();
                            widget.itemController.clear();
                            widget.priceController.clear();
                            widget.quantityController.clear();
                            textEditingValue = TextEditingValue();
                            itemDTO = dto;
                            itemDTOs?.add(itemDTO!);
                          });
                        },
                        icon: const Icon(Icons.add, color: primaryColorRed))),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: fullWidth*.9,
            height: itemDTOs == null && (itemDTOs!.isEmpty)
                ? 20.0
                : (100.0 * ((itemDTOs == null && (itemDTOs!.isEmpty)) ? 1.0 : itemDTOs!.length)),
            child: itemDTOs != null && (itemDTOs?.isNotEmpty)!
                ? ListView.builder(
                    itemCount: itemDTOs!.length,
                    itemBuilder: (context, int index) {
                      InvoiceItemDTO? dto;
                      dto = itemDTOs![index];
                      noOfItems = index + 1;
                      var invoiceItemContainer = Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                              Border.all(color: Colors.grey, width: 1)),
                        height: (100.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              width: fullWidth * .8,
                              child: Column(
                                children: [
                                  Row(children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                      alignment: Alignment.bottomLeft,
                                      width: fullWidth * .27,
                                      child: Text(
                                        '${dto.item?.name}',
                                        style: TextStyle(
                                            color: labelTextGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        width: fullWidth * .25,
                                        child: Text(
                                            '${dto.quantity}*${dto.item?.price}')),

                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: fullWidth * .22,
                                      child: Text(
                                        '\t${(dto?.item?.price ?? 1) * double.parse((dto?.quantity ?? 1).toString())} ',
                                        style: TextStyle(
                                            color: labelTextGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]),
                                  Row(children: [

                                    Container(
                                        alignment: Alignment.bottomRight,
                                        width: fullWidth * .52,
                                        child: const Text(
                                          'Discount',
                                          style: TextStyle(
                                              color: labelTextGrey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: fullWidth * .22,
                                      child: Text(
                                        '\t0.00',
                                        style: TextStyle(
                                            color: labelTextGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ]),
                                  Row(children: [

                                    Container(
                                        alignment: Alignment.bottomRight,
                                        width: fullWidth * .52,
                                        child: const Text(
                                          'Tax',
                                          style: TextStyle(
                                              color: labelTextGrey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: fullWidth * .22,
                                      child: Text(
                                        '\t0.00',
                                        style: TextStyle(
                                            color: labelTextGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ]),
                                  Row(children: [

                                    Container(
                                        alignment: Alignment.bottomRight,
                                        width: fullWidth * .52,
                                        child: const Text(
                                          'Total',
                                          style: TextStyle(
                                              color: labelTextGrey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: fullWidth * .22,
                                      child: Text(
                                        '\t${dto.quantity * (dto.item?.price ?? 1.00)}',
                                        style: TextStyle(
                                            color: labelTextGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              width: fullWidth * .08,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          InvoiceItemDTO dtoToEdit =
                                              itemDTOs![index];
                                          selectedItem = dtoToEdit.item;

                                          itemController.text =
                                              dtoToEdit.item!.name!;
                                          widget.itemController.text =
                                              dtoToEdit.item!.name!;
                                          widget.priceController.text =
                                              ((dtoToEdit.item!.price ?? 1.00) *
                                                      dtoToEdit.quantity)
                                                  .toString();
                                          widget.quantityController.text =
                                              dtoToEdit.quantity.toString();
                                          itemDTOs?.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit_note_rounded,
                                        size: 20,
                                        color: Colors.teal,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          itemDTOs!.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                      return invoiceItemContainer;
                    })
                : Container(
                    child: const Text("No Items added to invoice"),
                  ),
          ),
        ],
      ),
    );
  }


}
