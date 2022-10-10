class AnimeModel {
  final String malID;
  final String title;
  final String image;
  final String content;

  const AnimeModel({
    required this.malID,
    required this.title,
    required this.content,
    required this.image,
  });

  factory AnimeModel.fromJson(Map<dynamic, dynamic> json) {
    return AnimeModel(
      malID: json['mal_id'].toString(),
      content: json['content'] ?? '',
      title: json['title'] ?? '',
      image: json['images'] != null
          ? json['images']['jpg'] != null
              ? json['images']['jpg']['image_url'] as String
              : ''
          : '',
    );
  }
}
