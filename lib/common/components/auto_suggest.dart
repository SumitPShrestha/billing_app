import 'dart:async';

import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';

class AutoSuggest<T extends Object> extends StatelessWidget {
  final BuildContext context;
  TextEditingController controller;
  String? label;
  String? type;
  bool? obscureText;
  bool? isRequired;
  double? width;
  double? height;
  EdgeInsets? padding;
  FocusNode? focusNode;
  TextInputType? keyboardType;

  String? Function(String?)? validator;
  String Function(T) displayStringForOption;
  void Function(T)? onSelected;
  final Future<Iterable<T>> Function(TextEditingValue)
      optionsBuilderFunction;

  String displayProperty;

  AutoSuggest(
      {Key? key,
      required this.context,
      required this.controller,
      required this.optionsBuilderFunction,
      this.label,
      this.type,
      this.width,
      this.height,
      this.padding,
      this.keyboardType,
      this.obscureText = false,
      this.isRequired = false,
      this.validator,
    required  this.displayProperty,
      required this.displayStringForOption,
      required this.onSelected,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.length > 2) {
          return optionsBuilderFunction
              .call( textEditingValue);
        } else {
          return [];
        }
      },
      displayStringForOption:(T option) => displayStringForOption.call(option),
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextInput(
          controller: controller,
          focusNode: focusNode,
          label: label,
        );
      },
      onSelected: this.onSelected,
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              margin: EdgeInsets.zero,
              height: double.parse(
                  (options.length > 0 ? (60 * options.length) : 60).toString()),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              color: Colors.white60,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 0, 20, 5),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final T option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(displayStringForOption.call(option),
                          style: const TextStyle(color: labelTextGrey)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
