import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {
  late String name;
  late String email;
  late String token;
  late int id;
  late List productList;
  List searchListName = [];
  late List myProductList;

  void updateSerchListItem(List li) {
    searchListName = li;
    notifyListeners();
  }
}
