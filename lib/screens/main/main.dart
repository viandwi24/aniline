import 'package:aniline/components/navbar.dart';
import 'package:aniline/constant.dart';
import 'package:aniline/screens/main/tabs/bookmark.dart';
import 'package:aniline/screens/main/tabs/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'tabs/home.dart';
import 'tabs/explorer.dart';

class AnilineMainScreen extends StatefulWidget {
  const AnilineMainScreen({Key? key}) : super(key: key);

  @override
  State<AnilineMainScreen> createState() => _AnilineMainScreenState();
}

class _AnilineMainScreenState extends State<AnilineMainScreen> {
  final List<List> _pages = [
    ['Home', const HomeTabScreen(), UniconsLine.home_alt],
    ['Explorer', const ExplorerTabScreen(), UniconsLine.search_alt],
    ['News', const NewsTabScreen(), UniconsLine.newspaper],
    ['Bookmark', const BookmarkScreen(), UniconsLine.bookmark],
  ];
  @override
  Widget build(BuildContext context) {
    return AnilineScaffoldWithNavbar(
      pages: _pages,
    );
  }
}
