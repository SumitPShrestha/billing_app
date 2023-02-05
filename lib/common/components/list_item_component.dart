import 'package:billing_app/common/components/ScreenSizeHelper.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:flutter/material.dart';

class ListItemComponent extends StatefulWidget {
  String? headerText;
  String? subText1;
  String? subText2;
  void Function()? onEditPressed;
  void Function()? onDeletePressed;

  ListItemComponent(
      {Key? key,
      this.headerText,
      this.subText1,
      this.subText2,
      this.onEditPressed,
      this.onDeletePressed})
      : super(key: key);

  @override
  _ListItemComponentState createState() => _ListItemComponentState();
}

class _ListItemComponentState extends State<ListItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          /* border: Border.all(
                                  width: 2, color: const Color(0xFF802E2E)),*/
          borderRadius: BorderRadius.circular(10),
        ),
        height: ScreenSizeHelper.INSTANCE!.height * .16,
        width: ScreenSizeHelper.INSTANCE!.width * .9,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(7, 5, 0, 5),
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: ScreenSizeHelper.INSTANCE!.height * .13,
                          width: ScreenSizeHelper.INSTANCE!.width * .74,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                widget.headerText ?? "",
                                style: const TextStyle(
                                    color: primaryColorRed,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.subText1 ?? "",
                                style: const TextStyle(
                                    color: subTextGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.subText2 ?? "",
                                style: const TextStyle(
                                    color: subTextGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => widget.onEditPressed!.call(),
                                icon: const Icon(
                                  Icons.edit_note_rounded,
                                  size: 25,
                                  color: Colors.teal,
                                )),
                            IconButton(
                                onPressed: () =>
                                    widget.onDeletePressed!.call(),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.red,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
