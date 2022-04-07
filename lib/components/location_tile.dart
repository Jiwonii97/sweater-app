import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sweater/providers/location_info.dart';

class LocationTile extends StatelessWidget {
  final leadingIcon;
  final String title;
  bool checked = false;
  bool multi_select = false;
  Function onPressButton = () {};

  LocationTile({
    Key? key,
    this.leadingIcon = null,
    required this.onPressButton,
    this.title = "menu",
    this.checked = false,
    this.multi_select = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Material(
            color: checked ? Colors.blue[200] : Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     width: 1,
                //     color: Colors.transparent,
                //   ),
                //   borderRadius: BorderRadius.all(Radius.circular(10.0) // POINT
                //       ),
                // ),
                child: Slidable(

                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),
                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (ctx) => onPressButton(title),
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: '삭제',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: ListTile(
                      leading: Icon(leadingIcon != null ? leadingIcon : null,
                          color: checked ? Colors.blue[400] : Colors.grey[400]),
                      title: Text(title,
                          style: checked
                              ? TextStyle(color: Theme.of(context).primaryColor)
                              : const TextStyle(color: Colors.grey)),
                      trailing: checked
                          ? multi_select
                              ? const Icon(Icons.check_circle,
                                  color: Colors.blue)
                              : const Icon(Icons.check, color: Colors.blue)
                          : const Icon(null),
                    )))));
  }
}
