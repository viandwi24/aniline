import 'package:aniline/components/catalog_card.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/material.dart';

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
    // AnilineCatalogCard(
    //   title: 'Hige wo Soru. Soshite Joshikousei wo Hirou.',
    //   cover:
    //       'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx114232-2rm50ZD1cQgP.jpg',
    //   eps: 4,
    //   genre: 'Romance',
    // ),
    // AnilineCatalogCard(
    //   title: 'Osananajimi ga Zettai ni Makenai Love Come',
    //   cover:
    //       'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx124675-fNI06ipb65vy.jpg',
    //   eps: 2,
    //   genre: 'Romance',
    // ),
  ];

  // fetch
  _fetchData() async {
    final response = await UseApi().revoke(ApiMovieRecommendationGet());
    final animes = ApiMovieRecommendationGet.parseBody(response);
    final List<AnilineCatalogCard> newItems = [];
    for (final anime in animes) {
      newItems.add(AnilineCatalogCard(
        title: anime.title,
        cover: anime.image,
      ));
    }
    setState(() {
      items = newItems;
    });
  }

  // fetch data on init
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[
                for (var item in items)
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: item,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
