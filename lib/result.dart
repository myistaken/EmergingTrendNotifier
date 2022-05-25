import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trenifyv1/search_page.dart';

class Result extends StatefulWidget {
  String woeid, country, countryCode;

  Result(
      {Key? key,
      required this.country,
      required this.woeid,
      required this.countryCode})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  static String consumerApiKey = "3CSWEz90VoTSuHHQjc7DQgvwQ";
  static String consumerApiSecret =
      "gTwuNxcnThwDchRZ6cq3nS9VX5Hja8iAWkF6OMnXQaSWza6QdE";
  static String accessToken =
      "1284682835559944193-tF0gpkzODSpQiJnjevgumsB2i0R40E";
  static String accessTokenSecret =
      "pUsnhepYa6cRywfFkdNcmgxLPZTXvyXhndp26cTdUIcb9";

  bool isLoading = false;

  List<String> trends = [];
  List<int?> volumes = [];

  final twitterApi = TwitterApi(
      client: TwitterClient(
          consumerKey: consumerApiKey,
          consumerSecret: consumerApiSecret,
          token: accessToken,
          secret: accessTokenSecret));

  Future<void> searchTweets() async {
    setState(() {
      isLoading = true;
    });
    try {
      final homeTimeline =
          await twitterApi.trendsService.place(id: int.parse(widget.woeid));
      for (var tweet in homeTimeline) {
        for (int i = 0; i < tweet.trends!.length; i++) {
          setState(() {
            trends.add(tweet.trends![i].name.toString());
            volumes.add(tweet.trends![i].tweetVolume);
          });
        }
      }
      await twitterApi.tweetService.update(
        status: 'Hello world!',
      );
    } catch (error) {
      print("here, it keeps the over one " + error.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void fake() async {
    await searchTweets();
    trends.length;
  }

  @override
  void initState() {
    fake();
    super.initState();
  }

  int? x = 0;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(widget.country),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/countries/${widget.countryCode.toString().toLowerCase()}.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: const Center(child: CircularProgressIndicator()),
            ),
          )
        : SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(widget.country),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/countries/${widget.countryCode.toString().toLowerCase()}.svg',
                        allowDrawingOutsideViewBox: true,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    x = volumes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          SearchPage.twitterList.clear();
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(trends[index])));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: const Offset(3, 4))
                          ],
                        ),
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          title: Text(
                            trends[index],
                            style: const TextStyle(
                                fontSize: 25, color: Colors.black),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                x.toString() != "null"
                                    ? x.toString()
                                    : "Under 10k",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 20,
                ),
              ),
            ),
          );
  }
}
