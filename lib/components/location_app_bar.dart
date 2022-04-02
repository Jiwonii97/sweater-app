import 'package:flutter/material.dart';
import 'package:sweater/pages/add_location_page.dart';

class LocationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const LocationAppBar({Key? key, this.title = "title"})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context)),
      actions: title == "위치 관리"
          ? [
              IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddLocationPage()))
                      }),
            ]
          : null,
    );
  }

  @override
  final Size preferredSize; // default is 56.0

}
