import 'dart:convert';
import 'dart:ffi';

import 'package:aniline/models/anime.dart';
import 'package:aniline/models/post.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';
import 'package:html/parser.dart' as parser;

class UseApi {
  Future<Response> revoke(ApiContract api) async {
    final response = await api.fetch();

    return response;
  }
}

class ApiContract {
  const ApiContract({required this.url, required this.method, this.params});

  final String url;
  final String method;
  final Map<String, dynamic>? params;

  Future<Response> onFetch() async {
    final urlRes = url + getParamsInURL();
    final fullURL = Uri.parse(urlRes);
    final response = await get(fullURL);
    print(fullURL);

    return response;
  }

  getParamsInURL() {
    if (params == null) return '';
    final paramsInURL =
        params!.entries.map((e) => '${e.key}=${e.value}').join('&');

    return '?$paramsInURL';
  }

  onParseResponse(Response response) {
    return response;
  }

  Future<Response> fetch() async {
    return await onFetch();
  }

  setResponse(Response response) {
    return onParseResponse(response);
  }

  static parseBody(Response response) {
    return response.body;
  }

  static parseToJson(Response response) {
    return jsonDecode(response.body);
  }
}

class ApiMovieRecommendationGet extends ApiContract {
  ApiMovieRecommendationGet()
      : super(
          url: 'https://api.jikan.moe/v4/recommendations/anime',
          method: 'GET',
        );

  static List<AnimeModel> parseBody(Response response, {maxAnime = 10}) {
    final List<AnimeModel> animes = [];

    // parse
    final parsedBody = ApiContract.parseToJson(response);
    final data = parsedBody['data'];

    // if data found and is array
    if (data != null && data is List) {
      // loop through data
      for (var i = 0; i < data.length; i++) {
        // get item
        final item = data[i];
        // if entry found and is map
        if (item != null && item is Map) {
          // get item entry
          final entry = item['entry'];
          // if entry found and is List
          if (entry != null && entry is List<dynamic>) {
            // loop through entry
            for (var j = 0; j < entry.length; j++) {
              try {
                // get entry item
                final animeData = entry[j];
                // if total animes > 10 then break
                if (animes.length > maxAnime) {
                  break;
                }
                // if animeData found and is Map
                if (animeData != null && animeData is Map) {
                  try {
                    final m = AnimeModel.fromJson(animeData);
                    animes.add(m);
                  } catch (e) {
                    print(e);
                  }
                }
              } catch (e) {}
            }
          }
        }
      }
    }

    return animes;
  }
}

class ApiMovieSearch extends ApiContract {
  ApiMovieSearch(String query)
      : super(
          url: 'https://api.jikan.moe/v4/anime',
          method: 'GET',
          params: {
            'q': query,
          },
        );

  static List<AnimeModel> parseBody(Response response, {maxAnime = 10}) {
    final List<AnimeModel> animes = [];

    // parse
    final parsedBody = ApiContract.parseToJson(response);
    final data = parsedBody['data'];

    // if data found and is array;
    // print(data);
    if (data != null && data is List) {
      // loop through data
      for (var i = 0; i < data.length; i++) {
        // get item
        final item = data[i];
        // if animeData found and is Map
        if (item != null && item is Map) {
          try {
            final m = AnimeModel.fromJson(item);
            animes.add(m);
          } catch (e) {
            print(e);
          }
        }
      }
    }

    // animes
    return animes;
  }
}

class ApiPostJurnalOtakuGet extends ApiContract {
  ApiPostJurnalOtakuGet()
      : super(
          url: 'http://jurnalotaku.com/all',
          method: 'GET',
        );

  static Future<List<PostModel>> parseBody(Response response) async {
    final List<PostModel> posts = [];
    final document = parser.parse(response.body);
    final divs = document.querySelectorAll('.section-content .article-wrapper');
    for (var i = 0; i < divs.length; i++) {
      try {
        final div = divs[i];
        final title = div
            .querySelector('.meta')
            ?.querySelector('.title')
            ?.querySelector('span')
            ?.text;
        final link = div
            .querySelector('.meta')
            ?.querySelector('.title')
            ?.attributes['href'];
        final summary = div
            .querySelector('.meta')
            ?.querySelector('.summary')
            ?.children[1]
            .text;
        final image = div
            .querySelector('.cover')
            ?.querySelector('img')
            ?.attributes['src'];

        // check img
        if (image == null) continue;
        final imgCheck = await get(Uri.parse(image));
        if (imgCheck.statusCode != 200) continue;

        // add
        print(summary);
        posts.add(PostModel(
          title: title ?? '',
          url: link ?? '',
          image: image ?? '',
          content: '',
          source: 'jurnalotaku',
          summary: summary,
        ));
      } catch (e) {}
    }
    return posts;
  }
}
