import 'package:flutter/material.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/components/go_back_app_bar.dart';

class GenderChangePage extends StatefulWidget {
  const GenderChangePage({Key? key}) : super(key: key);

  @override
  State<GenderChangePage> createState() => _GenderChangePage();
}

class _GenderChangePage extends State<GenderChangePage> {
  bool _iamWoman = false;
  bool _iamMan = true;

  void _setMan() {
    setState(() {
      _iamMan = true;
      _iamWoman = false;
    });
  }

  void _setWoman() {
    setState(() {
      _iamMan = false;
      _iamWoman = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GoBackAppBar(
          title: '성별 관리',
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: _setWoman,
                child: CheckMenu(
                  leadingIcon: Icons.girl,
                  title: "여자",
                  checked: _iamWoman,
                ),
              ),
              GestureDetector(
                onTap: _setMan,
                child: CheckMenu(
                  leadingIcon: Icons.boy,
                  title: "남자",
                  checked: _iamMan,
                ),
              )
            ]));
  }
}
