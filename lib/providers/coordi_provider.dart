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
    notifyListeners();
  }

  String getTop() {
    QueryDocumentSnapshot temp = coordi_lists[0].docs[_idx];
    String topCategory = temp.get('items')[0]['category'];
    // Map<String, dynamic>.from(temp);
    // if (temp != null) print(temp.runtimeType);
    // return temp.get('items')[0].get('category');
    return topCategory;
  }

  String getBottom() {
    QueryDocumentSnapshot temp = coordi_lists[0].docs[_idx];
    String bottomCategory = temp.get('items')[1]['category'];
    // Map<String, dynamic>.from(temp);
    // if (temp != null) print(temp.runtimeType);
    // return temp.get('items')[0].get('category');
    return bottomCategory;
  }

  void idxIncrease() {
    _idx++;
    if (_idx >= coordi_lists[0].docs.length) _idx = 0;
    notifyListeners();
  }

  void idxDecrease() {
    _idx--;
    if (_idx < 0) {
      _idx = coordi_lists[0].docs.length - 1;
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
