import 'package:aniline/components/catalog_card.dart';
import 'package:aniline/constant.dart';
import 'package:aniline/models/anime.dart';
import 'package:aniline/screens/movie_detail/anime/anime_detail.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  bool isLoading = false;
  List<AnimeModel> _itemsRecommendation = [];
  List<AnimeModel> _itemsTop = [];

  // fetch
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    // recommendation
    final responseAnimeRecommendation =
        await UseApi().revoke(ApiMovieRecommendationGet());
    final animesRecommendation =
        ApiMovieRecommendationGet.parseBody(responseAnimeRecommendation);
    // top
    final responseAnimeTop = await UseApi().revoke(ApiMovieTopGet());
    final animesTop = ApiMovieTopGet.parseBody(responseAnimeTop);
    // await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _itemsRecommendation.clear();
      _itemsRecommendation.addAll(animesRecommendation);
      _itemsTop.clear();
      _itemsTop.addAll(animesTop);
      // items = newItems;
      isLoading = false;
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'back',
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: Image.network(
                      'https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/02/27/3520283235.jpg',
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
          // display title
          title: Container(
            margin: const EdgeInsets.only(top: 22, left: 14),
            child: Image.network(
              'https://raw.githubusercontent.com/viandwi24/aniline/main/assets/images/logo.png',
              width: 32,
              height: 32,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 22, right: 22),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(UniconsLine.search_alt),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recommended Anime',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                // Text(
                                //   'See All',
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w300,
                                //     color: kTextColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 240,
                          // color: Colors.red,
                          child: ListView.builder(
                            itemCount: _itemsRecommendation.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              final item = _itemsRecommendation[index];

                              return Container(
                                width: 180,
                                margin: EdgeInsets.only(
                                  bottom: 15,
                                  left: (index == 0 ? 22 : 0),
                                  right:
                                      (index == _itemsRecommendation.length - 1
                                          ? 22
                                          : 0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => AnimeDetailScreen(
                                          anime: item,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                        image: NetworkImage(item.image),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 14,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    // child: Text(item.title),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Top Hits Anime',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                // Text(
                                //   'See All',
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w300,
                                //     color: kTextColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          for (var item in _itemsTop)
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => AnimeDetailScreen(
                                        anime: item,
                                      ),
                                    ),
                                  );
                                },
                                child: AnilineCatalogCard(
                                  title: item.title,
                                  cover: item.image,
                                  labelTop: item.score,
                                  // labelBottom: 'Drama',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
