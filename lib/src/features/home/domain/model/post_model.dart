import 'dart:convert';

class PostModel {
  String title;
  String content;
  String imageUrl;
  PostModel({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  PostModel copyWith({
    String? title,
    String? content,
    String? imageUrl,
  }) {
    return PostModel(
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

  @override
  String toString() => 'PostModel(title: $title, content: $content, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostModel &&
      other.title == title &&
      other.content == content &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ imageUrl.hashCode;
}
