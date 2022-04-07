import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  Function refresh;
  Map address;

  SearchList({Key? key, required this.refresh, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: TextEditingController(text: address['주소']),
        readOnly: true,
        autofocus: false,
        onTap: () {
          // output = [search_textfield()];
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
