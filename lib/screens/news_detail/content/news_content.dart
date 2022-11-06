import 'dart:convert';

import 'package:aniline/constant.dart';
import 'package:aniline/models/anime.dart';
import 'package:aniline/screens/movie_detail/character/character_detail.dart';
import 'package:aniline/screens/movie_detail/voice_actor/voice_actor.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' as parser;

class NewsContentDetailScreen extends StatefulWidget {
  const NewsContentDetailScreen(
      {super.key, required this.link, required this.image});

  final String link;
  final String image;

  @override
  State<NewsContentDetailScreen> createState() =>
      _NewsContentDetailScreenState();
}

class _NewsContentDetailScreenState extends State<NewsContentDetailScreen> {
  bool _isLoading = false;

  String _content = '';
  String _cover = '';
  String _title = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final result =
        await UseApi().revoke(ApiPostJurnalOtakuDetailGet(url: widget.link));
    final document = parser.parse(result.body);
    final title = document
            .querySelector(
              '.paper-main-full-wrapper .meta-info .title h1 span',
            )
            ?.text ??
        '';
    final cover = document
            .querySelector(
              '.meta-cover img',
            )
            ?.attributes['src'] ??
        '';
    final content = document.querySelector('.meta-content')?.innerHtml ?? '';

    // final jsonData = await UseApi().revoke(ApiMovieGet(id: widget.anime.malID));
    setState(() {
      _isLoading = false;
      _title = title;
      _cover = cover;
      _content = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget wrapper = SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset('assets/anims/96031-loading-animation.json'),
          const Text('Chottomatte kudasai...'),
        ],
      ),
    );

    if (!_isLoading) {
      Widget htmlContentViewer = Html(data: _content);
      wrapper = SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      _title,
                      style: Theme.of(context).textTheme.caption?.merge(
                            const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              htmlContentViewer,
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: kPrimaryColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: wrapper,
            // ),
            wrapper,
          ],
        ),
      ),
    );
  }
}
