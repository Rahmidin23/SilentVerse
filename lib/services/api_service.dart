// lib/services/api_service.dart
import 'package:dio/dio.dart';
import '../models/book.dart';
import '../models/event.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://yourapi.example.com/api'));

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await _dio.get('/books');
      final data = response.data as List;
      return data.map((json) => Book.fromJson(json, json['id'] ?? '')).toList();
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await _dio.get('/events');
      final data = response.data as List;
      return data.map((json) => Event.fromJson(json, json['id'] ?? '')).toList();
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }
}
