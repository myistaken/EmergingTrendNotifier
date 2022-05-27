import 'package:flutter/material.dart';

class TrendProvider with ChangeNotifier {
  List trends = [];

  final List volumes = [];


  void addToList(String trend) {
    trends.add(trend);
    notifyListeners();
  }

  void removeFromList(int index) {
    trends.removeAt(index);
    notifyListeners();
  }
}