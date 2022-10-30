import 'package:aniline/constant.dart';
import 'package:aniline/screens/main/tabs/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tabs/home.dart';
import 'tabs/explorer.dart';

class AnilineMainScreen extends StatefulWidget {
  const AnilineMainScreen({Key? key}) : super(key: key);

  @override
  State<AnilineMainScreen> createState() => _AnilineMainScreenState();
}

class _AnilineMainScreenState extends State<AnilineMainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: kPrimaryColor,
        backgroundColor: kBackgroundColor,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: "Explorer",
            icon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            label: "News",
            icon: Icon(CupertinoIcons.news),
          ),
        ],
      ),
      tabBuilder: (ctx, index) {
        dynamic widget;
        if (index == 1) {
          widget = const ExplorerTabScreen();
        } else if (index == 2) {
          widget = const NewsTabScreen();
        } else {
          widget = const HomeTabScreen();
        }

        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(child: widget),
        );
      },
    );
  }
}
