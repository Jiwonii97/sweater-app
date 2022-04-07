import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController text_controller = TextEditingController();
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
    text_controller.text = text;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextField(
          controller: text_controller,
          onTap: choose
              ? () => FocusManager.instance.primaryFocus?.unfocus()
              : () {},
          autofocus: false,
          showCursor: choose ? false : true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20.0),
            filled: true,
            // border: InputBorder.none,
            suffixIcon: IconButton(
                onPressed: () => search(text_controller.text),
                icon: const Icon(
                  Icons.search,
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
