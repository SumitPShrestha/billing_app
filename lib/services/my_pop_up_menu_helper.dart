import 'package:billing_app/dto/client_dto.dart';
import 'package:flutter/material.dart';

import '../common/page/clients/add_client_screen.dart';

class MyPopUpMenuHelper {
  static getTapPosition(BuildContext context, TapDownDetails details) {
    Offset _tapPosition = Offset.zero;
    final tapPosition = details.globalPosition;
    final x = tapPosition.dx;
    final y = tapPosition.dy;
    // print('x $x');
    // print('y $y');
    return details.globalPosition;
  }

  static showContextMenu(BuildContext context, Offset _tapPosition,
      List<PopupMenuItem> popupMenuItems, ClientDTO dto) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay!.paintBounds.size.height)),
        items: popupMenuItems);
    // perform action on selected menu item
    switch (result) {
      case 'Edit':
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return AddClientScreen(clientDTO: dto);
        }));
        break;
      case 'close':
        print('close');
        Navigator.pop(context);
        break;
      default:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return AddClientScreen(clientDTO: dto);
        }));
    }
  }

/*
   onTapDown: (position) {
                            setState(() {
                              _tapPosition = MyPopUpMenuHelper.getTapPosition(
                                  context, position);
                            });
                          },
                          onLongPress: () async {
                            await MyPopUpMenuHelper.showContextMenu(
                                context,
                                _tapPosition,
                                [
                                  PopupMenuItem(
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit),
                                        Text('Edit'),
                                      ],
                                    ),
                                    value: "Edit",
                                    onTap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                      return AddClientScreen(
                                          clientDTO: snapshot.data![index]);
                                    })),
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete),
                                        Text('Delete'),
                                      ],
                                    ),
                                    value: "close",
                                  )
                                ],
                                snapshot.data![index]);
                          },





  */
}
