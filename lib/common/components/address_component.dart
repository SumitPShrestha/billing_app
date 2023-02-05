import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:flutter/material.dart';

class AddressComponent extends StatefulWidget {
  TextEditingController street1 = TextEditingController(text: "Green Street");
  TextEditingController street2 = TextEditingController(text: "Gatthaghar");
  TextEditingController mmp_vdc =TextEditingController(text: "Madhyapur, Thimi");
  TextEditingController district = TextEditingController(text: "Bhaktaput");
  TextEditingController zone = TextEditingController(text: "Bagmati");
  TextEditingController state = TextEditingController(text: "Bagmati");

  AddressComponent({
    Key? key,
    required this.street1,
    required this.street2,
    required this.mmp_vdc,
    required this.district,
    required this.zone,
    required this.state,
  }) : super(key: key);

  @override
  _AddressComponentState createState() => _AddressComponentState();
}

class _AddressComponentState extends State<AddressComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Header1(title: "Address"),
        Center(
          child: TextInput(
              controller: widget.street1,
              label: "Street 1",
              keyboardType: TextInputType.text,
              isRequired: true),
        ), Center(
          child: TextInput(
              controller: widget.street2,
              label: "Street 2",
              keyboardType: TextInputType.text,
              isRequired: true),
        ), Center(
          child: TextInput(
              controller: widget.mmp_vdc,
              label: "VDC/MP",
              keyboardType: TextInputType.text,
              isRequired: true),
        ), Center(
          child: TextInput(
              controller: widget.district,
              label: "District",
              keyboardType: TextInputType.text,
              isRequired: true),
        ), Center(
          child: TextInput(
              controller: widget.zone,
              label: "Zone",
              keyboardType: TextInputType.text,
              isRequired: true),
        ),Center(
          child: TextInput(
              controller: widget.state,
              label: "State",
              keyboardType: TextInputType.text,
              isRequired: true),
        ),
      ],
    ));
  }
}
