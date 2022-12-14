import 'dart:convert';

import 'package:aniline/constant.dart';
import 'package:aniline/models/anime.dart';
import 'package:aniline/screens/movie_detail/character/character_detail.dart';
import 'package:aniline/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VoiceActorDetailScreen extends StatefulWidget {
  const VoiceActorDetailScreen({
    super.key,
    required this.id,
    required this.image,
  });

  final int id;

  final String image;

  @override
  State<VoiceActorDetailScreen> createState() => _VoiceActorDetailScreenState();
}

class _VoiceActorDetailScreenState extends State<VoiceActorDetailScreen> {
  bool _isLoading = false;
  dynamic data = {};
  dynamic roles = {};

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
    final jsonData =
        await UseApi().revoke(ApiMovieVoiceActorGet(id: widget.id));
    final jsonRoles =
        await UseApi().revoke(ApiMovieVoiceActorRolesGet(id: widget.id));
    setState(() {
      try {
        data = jsonDecode(jsonData.body);
        data = data['data'] ?? {};
      } catch (e) {}
      try {
        roles = jsonDecode(jsonRoles.body);
        print(roles);
        roles = data['data'] ?? {};
      } catch (e) {}
      _isLoading = false;
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
                      getData<String>('name', def: '-') +
                          ' (' +
                          getData<String>('given_name', def: '-') +
                          ')',
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
              const SizedBox(height: 30),
              Text(
                'About',
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
                getData<String>('about', def: '-'),
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
                'Roles',
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
                height: 200,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: getData('voices', def: []).length,
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
                                    id: getData('voices', def: [])[index]
                                            ?['character']?['mal_id'] ??
                                        1,
                                    image: getData('voices', def: [])[index]
                                                ?['character']?['images']
                                            ?['jpg']?['image_url'] ??
                                        '',
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              getData('voices', def: [])[index]['character']
                                      ?['images']?['jpg']?['image_url'] ??
                                  '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 60,
                          child: Column(
                            children: [
                              Text(
                                getData('voices', def: [])[index]['character']
                                        ?['name'] ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
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
