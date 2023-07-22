import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import http package
import 'package:http/http.dart' as http;

class ListProvider extends ChangeNotifier {
  // final String uri = 'http://localhost:3000';
  final String uri = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  final List<Map> _list = [];

  List<Map> get list => _list;

  void addToList(String name, String description, {bool status = false}) async {
    Map data = {'name': name, 'description': description, 'status': status};
    _list.add(data);
    //request to api
    await http.post(
      Uri.parse('$uri/api/create-task/'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    notifyListeners();
  }

  // get data from api
  Future<void> getData() async {
    final response = await http.get(Uri.parse('$uri/api/tasks/'));
    if (response.statusCode == 200) {
      _list.clear();
      Map<String, dynamic> data = jsonDecode(response.body);
      for (var item in data['result']!) {
        _list.add(item);
      }
    }
  }

  void removeFromList(int id) async {
    _list.removeWhere((element) => element['id'] == id);
    //request to api
    print(id);
    http.post(
      Uri.parse('$uri/api/tasks/$id/delete'),
      headers: {'Content-Type': 'application/json'},
    );
    print(uri);
    // print(response.body);
    notifyListeners();
  }

  void updateStatus(int id, {bool? status = false}) async {
    Map data = _list.firstWhere((element) => element['id'] == id);
    data['status'] = status;
    //request to api
    http.post(
      Uri.parse('$uri/api/tasks/$id/update'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);
    notifyListeners();
  }
}
