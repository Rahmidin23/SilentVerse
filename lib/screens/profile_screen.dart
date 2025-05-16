// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../services/firestore_service.dart';
import '../models/user_profile.dart';
import '../utils/shared_prefs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  bool _loading = true;
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = context.read<AuthBloc>().state;
    if (user is Authenticated) {
      final profile = await FirestoreService().getUserProfile(user.user.uid);
      if (profile != null) {
        setState(() {
          _userProfile = profile;
          _nameController.text = profile.displayName;
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_userProfile == null) return;
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    final updatedProfile = UserProfile(
      uid: _userProfile!.uid,
      email: _userProfile!.email,
      displayName: newName,
      avatarUrl: _userProfile!.avatarUrl,
    );
    await FirestoreService().setUserProfile(updatedProfile);
    await SharedPrefs.saveUserName(newName);

    setState(() {
      _userProfile = updatedProfile;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
  }

  void _logout() {
    context.read<AuthBloc>().add(LoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('User Profile Info', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Email: ${_userProfile?.email ?? ''}'),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
