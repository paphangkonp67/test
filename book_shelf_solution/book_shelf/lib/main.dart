// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/book_provider.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookProvider(),
      child: const MaterialApp(
        title: 'Book Shelf',
        home: BookListScreen(),
      ),
    ),
  );
}
