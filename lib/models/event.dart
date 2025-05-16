// lib/models/event.dart
class Event {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json, String id) {
    return Event(
      id: id,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
