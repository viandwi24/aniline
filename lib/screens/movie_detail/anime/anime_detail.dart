import 'dart:convert';

import 'package:aniline/constant.dart';
import 'package:aniline/models/anime.dart';
import 'package:aniline/screens/movie_detail/character/character_detail.dart';
import 'package:aniline/screens/movie_detail/voice_actor/voice_actor.dart';
import 'package:aniline/services/api.dart';
import 'package:aniline/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({super.key, required this.anime});

  final AnimeModel anime;

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  bool _isLoading = false;
  dynamic data = {};
  dynamic characters = {};
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  getData<T>(String key, {dynamic def}) {
    final keys = key.split('.');
    dynamic value = data;
    for (final key in keys) {
      if (value is Map) {
        value = value[key];
      } else {
        return def;
      }
    }
    return (value ?? def) as T;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final jsonData = await UseApi().revoke(ApiMovieGet(id: widget.anime.malID));
    final jsonCharacters =
        await UseApi().revoke(ApiMovieCharactersGet(id: widget.anime.malID));
    // await Future.delayed(const Duration(seconds: 2));
    setState(() {
      try {
        data = jsonDecode(jsonData.body);
        data = data['data'] ?? {};
      } catch (e) {}
      try {
        characters = jsonDecode(jsonCharacters.body);
        characters = characters['data'] ?? {};
        print('characters: $characters');
      } catch (e) {}

      // check bookmark
      // find bookarms with item.id === widget.anime.malID
      DB.getBookmarks().forEach((element) {
        if (element.id == widget.anime.malID) {
          _isBookmarked = true;
        }
      });

      // loading
      _isLoading = false;
    });
  }

  Future<void> onBookmarkPress() async {
    try {
      var msg = "";
      msg = _isBookmarked
          ? "Remove ${widget.anime.title} from bookmark"
          : "Add ${widget.anime.title} to bookmark success";
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _isBookmarked ? Colors.red : kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        _isBookmarked = !_isBookmarked;

        try {
          if (_isBookmarked) {
            DB.addBookmark(id: widget.anime.malID, type: 'anime');
          } else {
            DB.removeBookmark(id: widget.anime.malID);
          }
        } catch (e) {
          print('error on bookmarked $e');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> onSharePress() async {
    try {
      // final FlutterShareMe flutterShareMe = FlutterShareMe();
      final String msg =
          '**${widget.anime.title}** \n\n https://myanimelist.net/anime/${widget.anime.malID}';
      print('msg to share: $msg');
      Share.share(msg, subject: 'Check this out!');
      // await flutterShareMe.shareToSystem(
      //   msg: msg,
      // );
    } catch (e) {
      print(e);
    }
  }

  Future checkBookmarked() async {
    // setState(() {
    //   _isLoading = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    checkBookmarked();

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
      wrapper = SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Text(
                      widget.anime.title,
                      style: Theme.of(context).textTheme.caption?.merge(
                            const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              child: Icon(Icons.share),
                              onTap: onSharePress,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              child: Icon(_isBookmarked
                                  ? Icons.bookmark_added
                                  : Icons.bookmark_outline),
                              onTap: onBookmarkPress,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: AnimeDetailLabel(
                      value: getData<String>('type', def: ''),
                    ),
                  ),
                  Flexible(
                    child: AnimeDetailLabel(
                      value: getData<String>('rating', def: ''),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Synopsis',
                style: Theme.of(context).textTheme.caption?.merge(
                      const TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                getData<String>('synopsis', def: ''),
                style: Theme.of(context).textTheme.caption?.merge(
                      const TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Characters',
                style: Theme.of(context).textTheme.caption?.merge(
                      const TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 140,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return CharacterDetailScreen(
                                    id: characters[index]?['character']
                                            ?['mal_id'] ??
                                        1,
                                    image: characters[index]?['character']
                                            ?['images']?['jpg']?['image_url'] ??
                                        '',
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  characters[index]?['character']?['images']
                                          ?['jpg']?['image_url'] ??
                                      '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                        Text(
                          characters[index]?['character']?['name'],
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          ((characters[index]?['voice_actors'] as List)
                                  .isNotEmpty
                              ? (characters[index]?['voice_actors']?[0]
                                      ?['person']?['name'] ??
                                  '')
                              : ''),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Voice Actors',
                style: Theme.of(context).textTheme.caption?.merge(
                      const TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 140,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    if (!((characters[index]?['voice_actors']) is List) ||
                        characters[index]?['voice_actors'].length == 0) {
                      return Container();
                    }

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return VoiceActorDetailScreen(
                                    id: characters[index]?['voice_actors']?[0]
                                            ?['person']?['mal_id'] ??
                                        1,
                                    image: characters[index]?['voice_actors']
                                                ?[0]?['person']?['images']
                                            ?['jpg']?['image_url'] ??
                                        1,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              characters[index]?['voice_actors']?[0]?['person']
                                      ?['images']?['jpg']?['image_url'] ??
                                  '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          (characters[index]?['voice_actors']?[0]?['person']
                                      ?['name'] ??
                                  '')
                              .toString(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
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
                background: Hero(
                  tag: 'back',
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: Image.network(
                          widget.anime.image,
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

class AnimeDetailLabel extends StatelessWidget {
  const AnimeDetailLabel({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
