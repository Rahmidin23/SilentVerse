// lib/screens/reader_screen.dart
import 'package:flutter/material.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reader')),
      body: const Center(
        child: Text('Read your favorite books, manga or comics here.'),
      ),
    );
  }
}
