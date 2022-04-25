import 'package:flutter/material.dart';

class CheckMenu extends StatelessWidget {
  final leadingIcon;
  final String title;
  bool checked = false;
  bool isLocation = false;

  CheckMenu({
    Key? key,
    this.leadingIcon = null,
    this.title = "menu",
    this.isLocation = false,
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Material(
            color: checked ? Colors.blue[100] : Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: InkWell(
                child: ListTile(
              leading: leadingIcon != null
                  ? Icon(leadingIcon,
                      color: checked ? Colors.blue[400] : Colors.grey[400])
                  : null,
              title: Text(title,
                  style: checked
                      ? isLocation
                          ? TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)
                          : TextStyle(color: Theme.of(context).primaryColor)
                      : const TextStyle(color: Colors.grey)),
              trailing: checked
                  ? const Icon(Icons.check, color: Colors.blue)
                  : const Icon(null),
            ))));
  }
}
