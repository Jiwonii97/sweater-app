import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  final Function closeDrawer;
  final bool isOpenDrawer;
  const FilterDrawer(
      {Key? key, required this.closeDrawer, required this.isOpenDrawer})
      : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _controller,
      builder: (context) {
        return widget.isOpenDrawer
            ? Column(children: [
                // Container(
                //   child: Row(
                //     children: [
                //       Column(
                //         children: [
                //           Text("옷 필터"),
                //           // IconButton()
                //         ],
                //       ),
                //       Text("추천되는 의상을 필터링할 수 있습니다")
                //     ],
                //   ),
                // ),
                Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        widget.closeDrawer();
                      },
                      child: Text("닫기"),
                    ))
              ])
            : Text("");
      },
      onClosing: () {},
    );
  }
}
