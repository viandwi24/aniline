import 'package:aniline/components/catalog-card.dart';
import 'package:flutter/material.dart';
import 'package:aniline/components/category-card.dart';
import 'package:aniline/constant.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  List<AnilineCatalogCard> items = const [
    AnilineCatalogCard(
      title: 'Tonikaku Kawaii',
      cover:
          'https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/b116267-JArFvMYRdnbd.jpg',
      eps: 13,
      genre: 'Romance',
    ),
    AnilineCatalogCard(
      title: 'Hige wo Soru. Soshite Joshikousei wo Hirou.',
      cover:
          'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx114232-2rm50ZD1cQgP.jpg',
      eps: 4,
      genre: 'Romance',
    ),
    AnilineCatalogCard(
      title: 'Osananajimi ga Zettai ni Makenai Love Come',
      cover:
          'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx124675-fNI06ipb65vy.jpg',
      eps: 2,
      genre: 'Romance',
    ),
    AnilineCatalogCard(
      title: 'a',
      cover:
          'https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/b116267-JArFvMYRdnbd.jpg',
      eps: 13,
      genre: 'Romance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <AnilineCatalogCard>[for (var item in items) item],
              ),
            ],
          ),
        ));
  }
}
