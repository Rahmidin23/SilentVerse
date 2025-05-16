// lib/models/user_profile.dart
class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final String avatarUrl;

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.avatarUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json, String uid) {
    return UserProfile(
      uid: uid,
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }
}
