import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoordiProvider with ChangeNotifier {
  QuerySnapshot? coordiLists;

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

  String getTopCloth() {
    QueryDocumentSnapshot temp = coordiLists!.docs[_idx];
    String topCategory = temp.get('items')[0]['category'];
    return topCategory;
  }

  String getBottomCloth() {
    QueryDocumentSnapshot temp = coordiLists!.docs[_idx];
    String bottomCategory = temp.get('items')[1]['category'];
    return bottomCategory;
  }

  void nextCoordi() {
    _idx++;
    if (_idx >= coordiLists!.docs.length) _idx = 0;
    notifyListeners();
  }

  void prevCoordi() {
    _idx--;
    if (_idx < 0) {
      _idx = coordiLists!.docs.length - 1;
    }
    notifyListeners();
  }

  void goFirstCoordi() {
    _idx = 0;
    notifyListeners();
  }

  void addCoordiList(QuerySnapshot? newCoordi) {
    coordiLists = newCoordi;
    notifyListeners();
  }
}
