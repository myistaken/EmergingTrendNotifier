import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static String consumerApiKey = "3CSWEz90VoTSuHHQjc7DQgvwQ";
  static String consumerApiSecret =
      "gTwuNxcnThwDchRZ6cq3nS9VX5Hja8iAWkF6OMnXQaSWza6QdE";
  static String accessToken =
      "1284682835559944193-tF0gpkzODSpQiJnjevgumsB2i0R40E";
  static String accessTokenSecret =
      "pUsnhepYa6cRywfFkdNcmgxLPZTXvyXhndp26cTdUIcb9";

  final twitterApi = TwitterApi(
      client: TwitterClient(
          consumerKey: consumerApiKey,
          consumerSecret: consumerApiSecret,
          token: accessToken,
          secret: accessTokenSecret));

  String s = "";
  List<String> listt = [];
  List<int?> volumes = [];

  Future<void> searchTweets() async {
    try {
      final homeTimeline = await twitterApi.trendsService.place(id: 23424969);
      for (var tweet in homeTimeline) {
        for (int i = 0; i < tweet.trends!.length; i++) {
          listt.add(tweet.trends![i].name.toString());
          volumes.add(tweet.trends![i].tweetVolume);
        }
      }
      await twitterApi.tweetService.update(
        status: 'Hello world!',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    searchTweets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                child: const Text("Press here"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result(
                                listt: listt,
                                volumes: volumes,
                              )));
                },
              ),
            ],
          ),
        ));
  }
}

class Result extends StatefulWidget {
  List<String> listt;
  List<int?> volumes;

  Result({Key? key, required this.listt, required this.volumes})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: widget.listt.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(
                    widget.listt[index],
                    style: const TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  trailing: Text(widget.volumes[index] != null
                      ? widget.volumes[index].toString()
                      : ""),
                );
              })),
    );
  }
}
