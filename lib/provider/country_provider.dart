import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataBase/authantication.dart';
import '/models/country.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<Countries> initialData =  [];
  final List<Countries> _counts = [];
  List<Countries> get counts => _counts;
  List ls=[];
  Future<void> initData() async{
    _counts.clear();
    ls.clear();
     await FirebaseFirestore.instance.collection("lists").doc(Authentication().userUID).get().then((value){
      value.data()?.forEach((key, value) {value.forEach(
              (data){
                if(!ls.contains(data.toString())){
                  ls.add(data.toString());
                  List dataList=data.toString().split("*");
                  _counts.add(Countries(countryName: dataList[1], woeid: int.parse(dataList[2]), code: dataList[0]));
                }
          }
      );});
    });
  }
  void addToList(Countries country) {
    _counts.add(country);

    String s=country.code+"*"+country.countryName+"*"+country.woeid.toString();
    if(!ls.contains(s)){
      ls.add(s);
    }
    FirebaseFirestore.instance.collection('lists').doc(Authentication().userUID).set({
      'list':ls
    });
    notifyListeners();
  }

  void removeFromList(int index) {
    _counts.removeAt(index);
    ls.removeAt(index);
    FirebaseFirestore.instance.collection('lists').doc(Authentication().userUID).set({
      'list': ls
    });
    notifyListeners();
  }
}
