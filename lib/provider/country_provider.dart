import '/models/country.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<Countries> initialData = [];

  final List<Countries> _counts = [];

  List<Countries> get counts => _counts;

  void addToList(Countries country) {
    _counts.add(country);
    notifyListeners();
  }

  void removeFromList(int index) {
    _counts.removeAt(index);
    notifyListeners();
  }
}
