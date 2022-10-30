import 'dart:async';

import 'package:aniline/components/catalog_card.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExplorerTabScreen extends StatefulWidget {
  const ExplorerTabScreen({Key? key}) : super(key: key);

  @override
  State<ExplorerTabScreen> createState() => _ExplorerTabScreenState();
}

class _ExplorerTabScreenState extends State<ExplorerTabScreen> {
  Timer? _debounce;
  bool _isLoading = false;
  final _searchController = TextEditingController();
  List<AnilineCatalogCard> _items = [];

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        print('searching...');
        print(_searchController.text);
        if (query.isNotEmpty) {
          _fetch();
        }
      },
    );
  }

  _fetch() async {
    setState(() {
      _items.clear();
      _isLoading = true;
    });
    print('fetching...');

    // fetchs
    final response =
        await UseApi().revoke(ApiMovieSearch(_searchController.text));
    final animes = ApiMovieSearch.parseBody(response);
    final List<AnilineCatalogCard> newItems = [];
    for (final anime in animes) {
      newItems.add(AnilineCatalogCard(
        title: anime.title,
        cover: anime.image,
        eps: 13,
        genre: 'Drama',
      ));
    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _items = newItems;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: const Icon(CupertinoIcons.search),
                  ),
                ),
                Flexible(
                  flex: 12,
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Search anime title...",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!_isLoading)
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: <Widget>[
                      for (var item in _items)
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: item,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          if (_isLoading)
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/anims/96031-loading-animation.json'),
                      const Text('Chottomatte kudasai...'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
