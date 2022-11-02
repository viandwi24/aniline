import 'package:aniline/models/post.dart';
import 'package:aniline/services/api.dart';

Future<List<PostModel>> getPost() async {
  List<ApiContract> apis = [ApiPostJurnalOtakuGet()];
  List<PostModel> posts = [];
  for (var api in apis) {
    final response = await UseApi().revoke(api);
    final postsSources = await ApiPostJurnalOtakuGet.parseBody(response);
    posts.addAll(postsSources);
  }

  return posts;
}
