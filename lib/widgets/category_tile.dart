import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class CategoryTile extends StatelessWidget {
  List<dynamic> elementList;
  List<dynamic> pickedList = [""];
  List<dynamic> newPickedList = [""];

  CategoryTile({
    Key? key,
    required this.elementList,
    required this.pickedList,
    required this.newPickedList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: UniqueKey(),
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      itemCount: elementList.length,
      itemBuilder: (int index) {
        final element = elementList[index];
        return ItemTags(
          key: UniqueKey(),

          textStyle: Theme.of(context).textTheme.bodyText2,
          textColor: Theme.of(context).colorScheme.onSurface,
          index: index,
          title: element,
          active: newPickedList.contains(element) ? true : false,
          elevation: 0,
          textActiveColor: Theme.of(context).primaryColor,
          color: Theme.of(context).colorScheme.surface,
          activeColor: Theme.of(context).colorScheme.surface, //체크 후 배경색
          onPressed: (element) {
            if (element.active) {
              newPickedList.add(element.title);
            } else {
              newPickedList.remove(element.title);
            }
          },
        );
      },
    );
  }
}
