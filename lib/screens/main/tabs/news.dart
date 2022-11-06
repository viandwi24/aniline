import 'dart:ffi';

import 'package:aniline/components/catalog_card.dart';
import 'package:aniline/constant.dart';
import 'package:aniline/models/post.dart';
import 'package:aniline/services/api.dart';
import 'package:aniline/utils/get_post.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' as parser;

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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'News',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                for (var item in items)
                  GestureDetector(
                    onTap: () async {
                      final result = await UseApi()
                          .revoke(ApiPostJurnalOtakuDetailGet(url: item.url));
                      final document = parser.parse(result.body);
                      final title = document
                              .querySelector(
                                  '.paper-main-full-wrapper .meta-info .title h1 span')
                              ?.text ??
                          '';
                      final cover = document
                              .querySelector(
                                '.meta-cover img',
                              )
                              ?.attributes['src'] ??
                          '';
                      final content =
                          document.querySelector('.meta-content')?.innerHtml ??
                              '';
                      print(content);
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
    );
  }
}
