import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sweater/providers/location_info.dart';

class LocationTile extends StatelessWidget {
  final String title;
  bool checked = false;
  Function onPressButton = () {};
  final SlidableController slidableController;

  LocationTile({
    Key? key,
    required this.onPressButton,
    required this.slidableController,
    this.title = "menu",
    this.checked = false,
  }) : super(key: key);

  void open(BuildContext context) {
    Slidable.of(context)!.open();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Material(
            color: checked ? Colors.blue[200] : Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                controller: slidableController,
                actionExtentRatio: 0.2,
                key: const ValueKey(0),
                secondaryActions: <Widget>[
                  SlideAction(
                      color: Colors.white,
                      onTap: () => onPressButton(title),
                      closeOnTap: true,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(8.0),
                            bottomRight: const Radius.circular(8.0),
                          ),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ))
                ],
                child: LocTile(title: title, checked: checked))));
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

  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (Slidable.of(context)!.overallMoveAnimation.isCompleted)
          Slidable.of(context)!.close();
        else
          Slidable.of(context)!.open(actionType: SlideActionType.secondary);
      },
      child: ListTile(
        leading: Icon(Icons.location_on_outlined,
            color: checked ? Colors.blue[400] : Colors.grey[400]),
        title: Text(title,
            style: checked
                ? TextStyle(color: Theme.of(context).primaryColor)
                : const TextStyle(color: Colors.grey)),
        trailing: checked
            ? const Icon(Icons.check, color: Colors.blue)
            : const Icon(null),
      ),
    );
  }
}
