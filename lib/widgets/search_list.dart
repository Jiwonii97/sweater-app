import 'package:flutter/material.dart';
import 'package:sweater/module/location.dart';

class SearchList extends StatelessWidget {
  Function refresh;
  Location address;

  SearchList({Key? key, required this.refresh, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: TextEditingController(text: address.address),
        readOnly: true,
        autofocus: false,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          refresh(address);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          filled: false,
          border: InputBorder.none,
        ));
  }
}
