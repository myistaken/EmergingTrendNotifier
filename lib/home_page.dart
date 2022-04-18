import 'package:flutter/material.dart';

import 'result.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/hashtag.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Hero(
          tag: 'logo',
          child: Center(
            child: GridView.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Result(
                                    country: countries[index],
                                    woeid: woeids[index],
                                  )));
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              images[index],
                            ),
                            maxRadius: 40,
                          ),
                        ),
                        Text(
                          countries[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}
