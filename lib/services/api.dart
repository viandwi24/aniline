import 'dart:convert';
import 'dart:ffi';

import 'package:aniline/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class UseApi {
  Future<Response> revoke(ApiContract api) async {
    final response = await api.fetch();

    return response;
  }
}

class ApiContract {
  const ApiContract({required this.url, required this.method});

  final String url;
  final String method;

  Future<Response> onFetch() async {
    final response = await get(Uri.parse(url));

    return response;
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

  static parseToJSOn(Response response) {
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

    // parse json

    // parse
    final parsedBody = ApiContract.parseToJSOn(response);
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
