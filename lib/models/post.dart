class PostModel {
  final String title;
  final String image;
  final String content;
  final String source;
  final String url;
  final String? summary;

  const PostModel({
    required this.title,
    required this.content,
    required this.image,
    required this.source,
    required this.url,
    this.summary,
  });
}
