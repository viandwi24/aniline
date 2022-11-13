class AnimeModel {
  final String malID;
  final String title;
  final String image;
  final String content;
  final String score;

  const AnimeModel({
    required this.malID,
    required this.title,
    required this.content,
    required this.image,
    this.score = '0',
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
      score: json['score'] != null ? json['score'].toString() : '0',
    );
  }
}
