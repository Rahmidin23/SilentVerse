// lib/models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final String category;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json, String id) {
    return Book(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'description': description,
      'category': category,
    };
  }
}
