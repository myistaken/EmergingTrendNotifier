import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trenifyv1/forgot_password.dart';

import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static bool isDark = true;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

ThemeData lightTheme =
    ThemeData(brightness: Brightness.light, primaryColor: Colors.blue);

ThemeData darkTheme =
    ThemeData(brightness: Brightness.dark, primaryColor: Colors.black);

bool _volumeOn = true;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: SettingsPage.isDark ? lightTheme : darkTheme,
        home: Scaffold(
          appBar: AppBar(
            //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHome()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  height: 15,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildAccountOptionRow(context, "Change password"),
                //   buildAccountOptionRow(context, "Language"),
                const SizedBox(
                  height: 40,
                ),
                /*Row(
                  children: [
                    const Icon(
                      Icons.volume_up_outlined,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Sound Mode",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                        value: _volumeOn,
                        onChanged: (state) {
                          setState(() {
                            _volumeOn = state;
                          });
                        }),
                  ],
                ),*/
                const Divider(
                  height: 15,
                  thickness: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.light_mode,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Theme",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                        value: SettingsPage.isDark,
                        onChanged: (state) {
                          setState(() {
                            SettingsPage.isDark = state;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Do You Want to Change\nYour Password?",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      fixedSize: const Size.fromWidth(100),
                      padding: const EdgeInsets.all(10)),
                  child: const Text("YES"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      fixedSize: const Size.fromWidth(100),
                      padding: const EdgeInsets.all(10)),
                  child: const Text("NO"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 5),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
