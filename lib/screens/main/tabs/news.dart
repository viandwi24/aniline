import 'dart:ffi';

import 'package:aniline/components/catalog_card.dart';
import 'package:aniline/constant.dart';
import 'package:aniline/models/post.dart';
import 'package:aniline/screens/news_detail/content/news_content.dart';
import 'package:aniline/services/api.dart';
import 'package:aniline/utils/get_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewsTabScreen extends StatefulWidget {
  const NewsTabScreen({Key? key}) : super(key: key);

  @override
  State<NewsTabScreen> createState() => _NewsTabScreenState();
}

class _NewsTabScreenState extends State<NewsTabScreen> {
  List<PostModel> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    print('get news');
    final posts = await getPost();
    // await Future.delayed(const Duration(seconds: 2));
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
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
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'News',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  for (var item in items)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => NewsContentDetailScreen(
                              link: item.url,
                              image: item.image,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AnilineCatalogCard(
                          title: item.title,
                          cover: item.image,
                          labelTop: item.source,
                          content: item.summary,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
