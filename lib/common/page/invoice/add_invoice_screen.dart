import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/common/page/items/item_list.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:billing_app/dto/Invoice_dto.dart';
import 'package:billing_app/dto/invoice_item_dto.dart';
import 'package:billing_app/dto/item_dto.dart';
import 'package:billing_app/model/client.dart';
import 'package:billing_app/model/invoice.dart';
import 'package:billing_app/model/invoice_item.dart';
import 'package:billing_app/model/item.dart';
import 'package:billing_app/services/client_service.dart';
import 'package:billing_app/services/invoice_service.dart';
import 'package:billing_app/services/item_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddInvoiceScreen extends StatefulWidget {
  late InvoiceDTO? invoiceDTO;
  late Invoice? invoiceInfo;

  AddInvoiceScreen({Key? key, this.invoiceDTO}) : super(key: key);

  @override
  _AddInvoiceScreenState createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  String dropdownValue = "1";
  List<InvoiceItem> invoiceItems = [];
  InvoiceItemDTO? itemDTO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.invoiceDTO != null) {
      InvoiceService().getInvoiceById(1);
    }
    //try to load all your data in this method :)
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    late TextEditingController date = TextEditingController(
        text: (widget.invoiceDTO != null
                ? DateTime.parse(widget.invoiceDTO!.date.toString())
                : DateTime.now().toString())
            .toString());
    late TextEditingController invoiceNo = TextEditingController();
    late TextEditingController customerName = TextEditingController();
    late TextEditingController totalPrice = TextEditingController();
    late TextEditingController itemName = TextEditingController();
    late TextEditingController itemPrice = TextEditingController();
    late TextEditingController itemQuantity = TextEditingController();
    late TextEditingController discount = TextEditingController();
    late TextEditingController discount_unit = TextEditingController();
    late TextEditingController tax_rate = TextEditingController();
    late TextEditingController comment = TextEditingController();
    late TextEditingController dueDate = TextEditingController();
    late TextEditingController invoiceID = TextEditingController();
    return LandingScreen(
        appBarTitle: "Create Invoice",
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
                Header1(title: "Invoice"),
                Row(
                  children: [
                    Center(
                      child: TextInput(
                        controller: invoiceID,
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        label: "Invoice ID",
                        width: fullWidth * .5,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                    ),
                    Center(
                      child: TextInput(
                        controller: date,
                        label: "Date",
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        width: fullWidth * .5,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              date.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Autocomplete<Client>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.length > 2) {
                        var iterable = ClientService().getClientsWhere(["name"],
                            [textEditingValue.text.toLowerCase() + "%"], 50);
                        return iterable;
                      } else {
                        return [];
                      }
                    },
                    displayStringForOption: (Client? option) =>
                        option!.name ?? "",
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextInput(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        label: "Client",
                      );
                    },
                    onSelected: (Client selection) {
                      widget.invoiceDTO!.clientName = selection.name;
                      widget.invoiceDTO!.clientID = selection.client_id;
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Client> onSelected,
                        Iterable<Client> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            margin: EdgeInsets.zero,
                            height: double.parse((options.length > 0
                                    ? (60 * options.length)
                                    : 60)
                                .toString()),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                            color: Colors.white60,
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(10, 0, 20, 5),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Client option = options.elementAt(index);

                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(option.name ?? "",
                                        style: const TextStyle(
                                            color: labelTextGrey)),
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
                Center(
                  child: Autocomplete<Item>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.length > 2) {
                        var iterable = ItemService().getClientsWhere(["name"],
                            [textEditingValue.text.toLowerCase() + "%"], 50);
                        return iterable;
                      } else {
                        return [];
                      }
                    },
                    displayStringForOption: (Item? option) =>
                        option!.name ?? "",
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextInput(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        label: "Items",
                      );
                    },
                    onSelected: (Item selection) {
                      int quantity = itemQuantity.text.isNotEmpty
                          ? int.parse(itemQuantity.text.toString())
                          : 1;
                      double? price = itemPrice.text.isNotEmpty
                          ? (double.parse(itemPrice.text.toString()) * quantity)
                          : selection.price;
                      itemDTO = InvoiceItemDTO(selection.item_id,
                          selection.name, quantity, true, price);
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Item> onSelected,
                        Iterable<Item> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            margin: EdgeInsets.zero,
                            height: double.parse((options.length > 0
                                    ? (60 * options.length)
                                    : 60)
                                .toString()),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
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
                                        style: const TextStyle(
                                            color: labelTextGrey)),
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
                        controller: itemQuantity,
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        label: "Quantity",
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        width: fullWidth * .4,
                      ),
                    ),
                    Center(
                      child: TextInput(
                          width: fullWidth * .4,
                          padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                          controller: itemPrice,
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
                            border:
                                Border.all(color: primaryColorRed, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: fullWidth * .11,
                          child: IconButton(
                              onPressed: () {
                                widget.invoiceDTO?.invoiceItems?.add(itemDTO!);
                              },
                              icon: Icon(Icons.add, color: primaryColorRed))),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    width: fullWidth * .9,
                    color: Colors.white,
                    height: fullHeight * .15,
                    child: Center(
                      child: widget.invoiceDTO != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: widget.invoiceDTO!.invoiceItems!
                                  .map((w) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              // Text()
                                            ],
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: fullHeight * 0.15,
                              width: fullWidth * .8,
                              child: const Text(
                                "No Item Selected",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ),
                  ),
                ),
                Center(
                  child: TextInput(
                    type: 'textarea',
                    height: fullHeight * .17,
                    controller: comment,
                    label: "Comment",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Center(
                    child: Button(
                        label: "Create Client",
                        onTap: () async {
                          /*Item item = Item(
                            widget.invoiceDTO != null
                                ? widget.invoiceDTO!.invoiceId
                                : null,
                            widget.customerName.value.text,
                            double.parse(widget..value.text),
                            int.parse(widget.quantity.value.text),
                            double.parse(widget.discount.value.text),
                            int.parse(widget.discount_unit.value.text),
                            double.parse(widget.tax_rate.value.text),
                            widget.description.value.text,
                          );
*/
                          // await ItemService().create(item).then((val) {
                          SnackBar snackBar = SnackBar(
                            content: Text('item  saved successfully'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const ItemListScreen();
                          }));
                          // });
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
