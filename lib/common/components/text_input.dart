import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  TextEditingController controller;
  String? label;
  String? type;
  bool? obscureText;
  bool? isRequired;
  double? width;
  double? height;
  EdgeInsets? padding;
  FocusNode? focusNode;
  void Function()? onTap;


  TextInputType? keyboardType;
  String? Function(String?)? validator;

  TextInput(
      {Key? key,
      required this.controller,
      this.label,
      this.type,
      this.width,
      this.height,
      this.padding,
      this.keyboardType,
      this.obscureText = false,
      this.isRequired = false,
      this.validator,
      this.onTap,
      this.focusNode})
      : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isChanged = false;
  bool _isRequired = false;
  TextEditingController? _controller;
  String? Function(String?)? _validator;
  String? _label;

  String? get _errorText {
    if (isChanged == true) {
      if (_isRequired == true) {
        if (_controller!.value.text.isEmpty) {
          return "${_label} is required.";
        } else {
          return null;
        }
      }
      if (_validator != null) {
        return _validator!(_controller!.value.text);
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = widget.controller;
    _label = widget.label;
    _validator = widget.validator;
    _isRequired = widget.isRequired ?? false;
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height ??
          (_label != null ? fullHeight * .12 : fullHeight * .08),
      width: widget.width ?? fullWidth * .98,
      padding: widget.padding ?? const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_label != null)
            Row(
              children: [
                if (_label != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 0, 0, 5),
                    child: Text(
                      _label ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: labelTextGrey),
                    ),
                  ),
                if (_isRequired == true && _label != null)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(3, 0, 0, 5),
                    child: Text(
                      "*",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF80404)),
                    ),
                  ),
              ],
            ),
          if (widget.type == null || widget.type == "text")
            TextField(
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              controller: _controller,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              onChanged: (val) {
                isChanged = true;
                setState(() {
                  _errorText;
                });
              },
              style: TextStyle(color: Colors.grey.shade900),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  /* label: Text(
                    _label ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff676666),

                    ),
                  ),*/

                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 10.0),
                  errorText: _errorText,
                  errorStyle: const TextStyle(
                      color: errorColor, fontSize: 13.5, height: .7),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF588FE7), width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          if (widget.type == 'select')
            DropdownButtonFormField<String>(
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    widget.controller.text = value ?? "1";
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 10.0),
                  enabledBorder: const OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: Color(0xFF588FE7), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                items: ["1", "2"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == "1" ? "%" : "Rs"),
                  );
                }).toList()),
          if (widget.type == 'textarea')
            TextField(
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              controller: _controller,
              onChanged: (val) {
                isChanged = true;
                setState(() {
                  _errorText;
                });
              },
              maxLines: 4,
              style: TextStyle(color: Colors.grey.shade900),
              decoration: InputDecoration(
                  helperMaxLines: 3,
                  filled: true,
                  fillColor: Colors.grey[200],
                  /* label: Text(
                    _label ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff676666),

                    ),
                  ),*/

                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
                  errorText: _errorText,
                  errorStyle: const TextStyle(
                      color: errorColor, fontSize: 13.5, height: .7),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF588FE7), width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            )
        ],
      ),
    );
  }
}
