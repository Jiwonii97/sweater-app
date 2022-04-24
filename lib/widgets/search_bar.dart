import 'package:flutter/material.dart';
import 'package:sweater/theme/sweater_icons.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  String text;
  bool choose;
  Function search;

  SearchBar({
    Key? key,
    this.text = "",
    this.choose = false,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textController.text = text;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextField(
          controller: textController,
          onTap: choose
              ? () => FocusManager.instance.primaryFocus?.unfocus()
              : () {},
          autofocus: false,
          showCursor: choose ? false : true,
          decoration: InputDecoration(
            prefixIcon: choose
                ? const Icon(
                    SweaterIcons.map_marker_alt,
                    color: Colors.black,
                  )
                : null,
            contentPadding: const EdgeInsets.all(20.0),
            filled: true,
            // border: InputBorder.none,
            suffixIcon: IconButton(
                onPressed: () => search(textController.text),
                icon: const Icon(
                  SweaterIcons.search,
                  color: Colors.black,
                )),
            hintText: '주소를 입력해 주세요',
            fillColor: const Color.fromARGB(255, 232, 239, 243),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
          ),
        ));
  }
}
