import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trenifyv1/provider/country_provider.dart';
import 'package:trenifyv1/settings.dart';

import 'package:trenifyv1/theme_class.dart';
import 'models/country.dart';
import 'result.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late List data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/woeid.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }
  List<String> images = [
    "assets/Turkey.jpeg", //istanbul
    "assets/England.jpeg", //london
    "assets/USA.jpeg", //newyork
    "assets/France.jpeg", //paris
    "assets/Canada.jpeg", //toronto
    "assets/Germany.jpeg", //germany
    "assets/Italy.jpeg", //milan
    "assets/Brazil.jpeg", //rio
    "assets/Spain.jpeg", //madrid
  ];
  List<String> countries = [
    "Turkey", //istanbul
    "England", //london
    "USA", //newyork
    "France", //paris
    "Canada", //toronto
    "Germany", //germany
    "Italy", //milan
    "Brazil", //rio
    "Spain", //madrid
  ];
  List<String> woeids = [
    "23424969",
    "44418",
    "2459115",
    "615702",
    "4118",
    "23424829",
    "718345",
    "455825",
    "766273",
  ];
  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _counts = context.watch<CountryProvider>().counts;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SettingsPage.isDark
          ? ThemeClass().lightTheme
          : ThemeClass().darkTheme,
      home: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: !SettingsPage.isDark?[Colors.purple, Colors.black]:[Colors.white12, Colors.cyanAccent], stops: [0.4, 1.0],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            title: const Text('C-Trend'),
            elevation: 1,
            // leading: IconButton(
            //   icon: Icon(
            //     Icons.arrow_back,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => MyLogin()));
            //   },
            // ),
            actions: [
              /*
            IconButton(
                icon: const Icon(Icons.lightbulb),
                onPressed: () {

                }),*/
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: !SettingsPage.isDark?[Colors.grey.shade500, Colors.black]:[Colors.white60, Colors.cyanAccent], stops: [0.4, 1.0],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Hero(
                tag: 'logo',
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: _counts.length==0?ListTile(title: Text("Please add a region",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),):GridView.builder(
                          itemCount: _counts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                                onPressed: () {
                                  print(_counts[index].code+"  "+_counts[index].toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Result(
                                                country: _counts[index].countryName,
                                                countryCode: _counts[index].code,
                                                woeid: _counts[index].woeid.toString(),
                                              )));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/countries/${_counts[index].code.toLowerCase()}.svg',
                                          allowDrawingOutsideViewBox: true,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    Text(
                                      _counts[index].countryName,
                                     style:  TextStyle(color: !SettingsPage.isDark?Colors.white:Colors.black),
                                    ),
                                  ],
                                ));
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          /*gradient: LinearGradient(
                            colors: !SettingsPage.isDark?[Colors.black, Colors.black]:[Colors.cyan, Colors.purple], stops: [0.4, 1.0],
                          ),*/
                        ),
                        child: ElevatedButton(

                          style: ButtonStyle(backgroundColor:!SettingsPage.isDark?MaterialStateProperty.all(Colors.purple):MaterialStateProperty.all(Colors.blue.shade400),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Select(
                                      data: data,
                                    ))),
                          },
                          child: const Text('Add/Remove a Region'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class Select extends StatelessWidget {
  List data;
  Select({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _counts = context.watch<CountryProvider>().counts;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !SettingsPage.isDark?[Colors.purple, Colors.black]:[Colors.white12, Colors.cyanAccent], stops: [0.4, 1.0],
            ),
          ),
        ),
        title: const Text("Select Region"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      trailing:
                      data[index]["countryCode"].toString().toLowerCase() !=
                          "null"
                          ? SizedBox(

                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          
                          'assets/countries/${data[index]["countryCode"].toString().toLowerCase()}.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      )
                          : null,
                      title: Text(
                        data[index]["name"],
                      ),
                      onTap: () {
                        bool check=false;
                        int ind=0;
                        Countries cr=Countries(
                            countryName: data[index]["name"],
                            code: data[index]["countryCode"],
                            woeid: data[index]["woeid"]);
                            _counts.forEach((element) {if(element.countryName==data[index]["name"]){
                              ind=_counts.indexOf(element);
                             check=true;
                        } });
                        if(check){
                          context.read<CountryProvider>().removeFromList(ind);
                        }
                        else{
                          context.read<CountryProvider>().addToList(cr);

                      }Navigator.pop(context);
                      },
                    ),
                    Divider(thickness: 1,color: Colors.black,)
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}