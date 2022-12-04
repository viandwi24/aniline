import 'dart:convert';

import 'package:aniline/constant.dart';
import 'package:aniline/models/anime.dart';
import 'package:aniline/screens/movie_detail/character/character_detail.dart';
import 'package:aniline/screens/movie_detail/voice_actor/voice_actor.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      _isLoading = false;
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
                'Characters and Voice Actors',
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
                height: 400,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return Column(
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
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              characters[index]?['character']?['images']?['jpg']
                                      ?['image_url'] ??
                                  '',
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          child: Text(
                            characters[index]?['character']?['name'],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        Container(
                          width: 100,
                          height: 40,
                          child: Text(
                            "CV. " +
                                (characters[index]?['voice_actors']?[0]
                                        ?['person']?['name'])
                                    .toString(),
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
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
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
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
