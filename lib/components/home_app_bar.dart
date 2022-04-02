import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon leading;

  const HomeAppBar(
      {Key? key, this.title = "title", this.leading = const Icon(null)})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: leading, onPressed: () => Scaffold.of(context).openDrawer()));
  }

  @override
  final Size preferredSize; // default is 56.0

}
