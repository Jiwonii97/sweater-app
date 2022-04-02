import 'package:flutter/material.dart';
import 'package:sweater/components/check_menu.dart';
import 'package:sweater/components/go_back_app_bar.dart';
import 'package:sweater/providers/user_info.dart';
import 'package:provider/provider.dart';

class GenderChangePage extends StatefulWidget {
  const GenderChangePage({Key? key}) : super(key: key);

  @override
  State<GenderChangePage> createState() => _GenderChangePage();
}

class _GenderChangePage extends State<GenderChangePage> {
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
                onTap: () {
                  context.read<User>().changeGender(User.man);
                },
                child: CheckMenu(
                  leadingIcon: Icons.boy,
                  title: User.manString,
                  checked: context.watch<User>().gender == User.man,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<User>().changeGender(User.woman);
                },
                child: CheckMenu(
                  leadingIcon: Icons.girl,
                  title: User.womanString,
                  checked: context.watch<User>().gender == User.woman,
                ),
              ),
            ]));
  }
}
