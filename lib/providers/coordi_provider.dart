import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoordiProvider with ChangeNotifier {
  List<QuerySnapshot> coordi_lists = [];
  Map<String, String> _dummy = {
    'gender': '1',
    'items': 'padding, shirt, training_pants',
    'url': 'insta.com'
  };
  Map get dummy => _dummy;
  int _idx = 0;
  int get idx => _idx;
  CoordiProvider();
  Future<QuerySnapshot> requestCooris() async {
    return await FirebaseFirestore.instance.collection('coordis').get();
  }

  void initCoordiList() async {
    QuerySnapshot qs = await requestCooris();
    addCoordiList(qs);
  }

  void idxIncrease() {
    _idx++;
    if (_idx >= coordi_lists.length) _idx = 0;
    notifyListeners();
  }

  void idxDecrease() {
    _idx--;
    if (_idx < 0) {
      _idx = coordi_lists.length - 1;
    }
    notifyListeners();
  }

  void resetIdx() {
    _idx = 0;
    notifyListeners();
  }

  void addCoordiList(QuerySnapshot newCordi) {
    coordi_lists.add(newCordi);
    notifyListeners();
  }
}
