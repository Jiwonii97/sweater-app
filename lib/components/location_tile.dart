import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sweater/theme/sweater_icons.dart';
import "package:sweater/components/my_custom_slidable_action.dart";

class LocationTile extends StatelessWidget {
  final String title;
  bool checked = false;
  Function onPressButton = () {};
  LocationTile({
    Key? key,
    required this.onPressButton,
    this.title = "menu",
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        margin: const EdgeInsets.only(right: 16.0, bottom: 8),
        child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                MyCustomSlidableAction(
                    onPressed: (context) => onPressButton(context, title),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: const Icon(
                      SweaterIcons.trash,
                    ))
              ],
            ),
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                //child: LocTile(title: title, checked: checked)
                child: LocTile(
                  title: title,
                  checked: checked,
                ))));
  }
}

class LocTile extends StatelessWidget {
  final String title;
  bool checked = false;

  LocTile({
    Key? key,
    this.title = "menu",
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: const EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
          child: ListTile(
            leading: Icon(SweaterIcons.map_marker_alt, color: Colors.grey[400]),
            title: Text(title, style: const TextStyle(color: Colors.grey)),
            trailing: const Icon(null),
          )),
    );
  }
}
