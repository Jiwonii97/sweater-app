import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoordiProvider with ChangeNotifier {
  List<QuerySnapshot> coordiLists = [];

  int _idx = 0;
  bool _initCoordiState = false;

  int get idx => _idx;
  bool get initCoordiState => _initCoordiState;
  CoordiProvider();

  Future<QuerySnapshot> requestCooris() async {
    return await FirebaseFirestore.instance.collection('coordis').get();
  }

  void initCoordiList() async {
    QuerySnapshot qs = await requestCooris();
    addCoordiList(qs);
    _initCoordiState = true;
    notifyListeners();
  }

  String getTop() {
    QueryDocumentSnapshot temp = coordiLists[0].docs[_idx];
    String topCategory = temp.get('items')[0]['category'];
    // Map<String, dynamic>.from(temp);
    // if (temp != null) print(temp.runtimeType);
    // return temp.get('items')[0].get('category');
    return topCategory;
  }

  String getBottom() {
    QueryDocumentSnapshot temp = coordiLists[0].docs[_idx];
    String bottomCategory = temp.get('items')[1]['category'];
    return bottomCategory;
  }

  void idxIncrease() {
    _idx++;
    if (_idx >= coordiLists[0].docs.length) _idx = 0;
    notifyListeners();
  }

  void idxDecrease() {
    _idx--;
    if (_idx < 0) {
      _idx = coordiLists[0].docs.length - 1;
    }
    notifyListeners();
  }

  void resetIdx() {
    _idx = 0;
    notifyListeners();
  }

  void addCoordiList(QuerySnapshot newCordi) {
    coordiLists.add(newCordi);
    notifyListeners();
  }
}
