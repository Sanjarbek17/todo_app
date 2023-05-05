import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  final List<Map> _list = [];

  List<Map> get list => _list;

  void addToList(String name, String description, {bool status = false}) {
    _list.add({'title': name, 'description': description, 'status': status});
    notifyListeners();
  }

  void removeFromList(int id) {
    _list.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }

  void clearList() {
    _list.clear();
    notifyListeners();
  }
}
