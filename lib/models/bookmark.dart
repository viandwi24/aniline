class BookmarkItemModel {
  final String id;
  final DateTime addedAt;
  final String type;

  BookmarkItemModel({
    required this.id,
    required this.addedAt,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addedAt': addedAt.toIso8601String(),
      'type': type,
    };
  }

  factory BookmarkItemModel.fromJson(Map<String, dynamic> json) {
    return BookmarkItemModel(
      id: json['id'],
      addedAt: DateTime.parse(json['addedAt']),
      type: json['type'],
    );
  }
}
