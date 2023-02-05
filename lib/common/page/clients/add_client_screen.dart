import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';
import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/common/components/address_component.dart';
import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/page/clients/client_list_screen.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:billing_app/dto/client_dto.dart';
import 'package:billing_app/model/client.dart';
import 'package:billing_app/services/client_service.dart';

class AddClientScreen extends StatefulWidget {
  ClientDTO? clientDTO;
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController billing_address1;
  late TextEditingController billing_address2;
  late TextEditingController shipping_address1;
  late TextEditingController shipping_address2;
  late TextEditingController zone;
  late TextEditingController state;
  late TextEditingController email;
  late TextEditingController contact1;
  late TextEditingController contact2;
  late TextEditingController phone1;
  late TextEditingController phone2;

  AddClientScreen({Key? key, this.clientDTO}) : super(key: key) {
    name = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.name : "");
    phone = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.phone : "");
    billing_address1 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.billing_address1 : "");
    billing_address2 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.billing_address2 : "");
    shipping_address1 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.shipping_address1 : "");
    shipping_address2 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.shipping_address2 : "");

    email = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.email : "");
    contact1 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.contact1 : "");
    contact2 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.contact2 : "");
    phone1 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.phone1 : "");
    phone2 = TextEditingController(
        text: clientDTO != null ? clientDTO!.client!.phone2 : "");
  }

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  bool isSameAddress = false;

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFF588FE7);
      }
      return labelTextGrey;
    }

    return LandingScreen(
        appBarTitle: "Add Client",
        backButton: true,
        onPressedAppBarButton: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ClientListScreen();
            })),
        mainComponent: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Header1(title: "Client's Info"),
                Center(
                  child: TextInput(
                    controller: widget.name,
                    label: "Customer's name",
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: widget.phone,
                    label: "Phone no.",
                    keyboardType: TextInputType.phone,
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                      controller: widget.email,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                      controller: widget.contact1,
                      label: "Principle's name",
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                      controller: widget.phone1,
                      label: "Principle's mobile",
                      keyboardType: TextInputType.phone,
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                    controller: widget.contact2,
                    label: "Contact Person",
                    keyboardType: TextInputType.text,
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: widget.phone2,
                    label: "Contacts mobile",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Center(
                  child: TextInput(
                      controller: widget.billing_address1,
                      label: "Billing Address",
                      keyboardType: TextInputType.phone,
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                    controller: widget.billing_address2,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Row(
                    children: [
                      const Text(
                        'Use same Address',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: labelTextGrey),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isSameAddress,
                        onChanged: (bool? value) {
                          if (value == true) {
                            widget.shipping_address1.text =
                                widget.billing_address1.value.text;
                            widget.shipping_address2.text =
                                widget.billing_address2.value.text;
                            setState(() {
                              isSameAddress = value!;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: widget.shipping_address1,
                    label: "Shipping Address",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: widget.shipping_address2,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Center(
                    child: Button(
                        label: "Create Client",
                        onTap: () async {
                          Client client = Client(
                            widget.clientDTO != null
                                ? widget.clientDTO!.client!.client_id
                                : null,
                            widget.name.value.text,
                            widget.phone.value.text,
                            widget.email.value.text,
                            widget.contact1.value.text,
                            widget.contact2.value.text,
                            widget.phone1.value.text,
                            widget.phone2.value.text,
                            widget.billing_address1.value.text,
                            widget.billing_address2.value.text,
                            widget.shipping_address1.value.text,
                            widget.shipping_address2.value.text,
                          );

                          await ClientService()
                              .createClient(client)
                              .then((val) {
                            SnackBar snackBar = SnackBar(
                              content: Text(
                                  'client ${widget.name.value.text} saved successfully'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const ClientListScreen();
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
