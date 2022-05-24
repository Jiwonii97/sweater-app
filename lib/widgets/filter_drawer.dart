import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:sweater/widgets/category_tile.dart';

import '../theme/global_theme.dart';

class FilterDrawer extends StatefulWidget {
  Map<String, dynamic> newPickedCategory = {
    "outer": [],
    "top": [],
    "bottom": [],
    "one_piece": []
  };
  FilterDrawer({
    Key? key,
    required this.newPickedCategory,
  }) : super(key: key);

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
    final coordiProvider = context.read<CoordiProvider>();
    final weatherProvider = context.read<WeatherProvider>();
    final userProvider = context.read<UserProvider>();
    Map<String, dynamic> filterList =
        context.watch<CoordiProvider>().filterList;
    var pickedCategory = context.watch<CoordiProvider>().pickedCategory;
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            Positioned(
                child: Column(children: [
              SizedBox(height: 90),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    Column(
                      children: [
                        filterList['outer'].isNotEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Text("아우터",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)),
                                    CategoryTile(
                                        elementList: filterList['outer'],
                                        pickedList:
                                            pickedCategory['outer'] ?? [],
                                        newPickedList:
                                            widget.newPickedCategory['outer'] ??
                                                []),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ))
                            : Container(),
                        filterList['top'].isNotEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Text("상의",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)),
                                    CategoryTile(
                                        elementList: filterList['top'],
                                        pickedList: pickedCategory['top'] ?? [],
                                        newPickedList:
                                            widget.newPickedCategory['top'] ??
                                                []),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ))
                            : Container(),
                        filterList['bottom'].isNotEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Text("하의",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)),
                                    CategoryTile(
                                        elementList: filterList['bottom'],
                                        pickedList:
                                            pickedCategory['bottom'] ?? [],
                                        newPickedList: widget
                                                .newPickedCategory['bottom'] ??
                                            []),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ))
                            : Container(),
                        filterList['one_piece'].isNotEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Text("원피스",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)),
                                    CategoryTile(
                                        elementList: filterList['one_piece'],
                                        pickedList:
                                            pickedCategory['one_piece'] ?? [],
                                        newPickedList: widget.newPickedCategory[
                                                'one_piece'] ??
                                            []),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ))
                            : Container(),
                      ],
                    )
                  ],
                )),
              )),
              //------------------------------------------------------------------------------------------
              Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 3,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "초기화",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {
                              widget.newPickedCategory = {
                                "outer": [],
                                "top": [],
                                "bottom": [],
                                "one_piece": []
                              };
                              setState(() {});
                            },
                          ),
                          SizedBox(
                              width: 116,
                              height: 36,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    coordiProvider.clearPickedCategory();
                                    context
                                            .read<CoordiProvider>()
                                            .setPickedCategory =
                                        json.decode(json
                                            .encode(widget.newPickedCategory));
                                    Navigator.pop(context);
                                    await coordiProvider
                                        .requestCoordiListWithFiltering(
                                            weatherProvider.getCurrentWeather(),
                                            userProvider.user);
                                  },
                                  child: Text("적용",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    primary: Theme.of(context).primaryColor,
                                  )))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ))),
            ])),
            Positioned(
              left: 0,
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Container(
                      margin: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("옷 필터",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(height: 4),
                              Text("추천되는 의상을 필터링할 수 있습니다.",
                                  style: Theme.of(context).textTheme.caption)
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          SizedBox(
                              child: IconButton(
                            onPressed: () {
                              widget.newPickedCategory = {
                                "outer": [],
                                "top": [],
                                "bottom": [],
                                "one_piece": [],
                              };

                              Navigator.pop(context);
                            },
                            icon: Icon(SweaterIcons.times,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            iconSize: 32,
                          ))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ))),
            ),
          ],
        ));
  }
}
