// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';
import '../models/event.dart';
import '../models/user_profile.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// BOOKS
  Future<List<Book>> getBooks() async {
    final snapshot = await _db.collection('books').get();
    return snapshot.docs
        .map((doc) => Book.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> addBook(Book book) async {
    await _db.collection('books').add(book.toJson());
  }

  /// EVENTS
  Future<List<Event>> getEvents() async {
    final snapshot = await _db.collection('events').orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => Event.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> addEvent(Event event) async {
    await _db.collection('events').add(event.toJson());
  }

  /// USER PROFILE
  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserProfile.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> setUserProfile(UserProfile profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }
}
