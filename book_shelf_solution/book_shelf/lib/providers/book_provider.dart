// lib/providers/book_provider.dart
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  static const _dbName = 'books.db';
  static const _table = 'books';

  Database? _database;
  List<Book> _books = [];
  List<Book> get books => [..._books];

  BookProvider() {
    fetchAndSetBooks();
  }

  Future<Database> _initDatabase() async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), _dbName);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            author TEXT NOT NULL,
            price REAL NOT NULL,
            is_read INTEGER NOT NULL,
            added_at TEXT NOT NULL,
            genre TEXT NOT NULL
          )
        ''');
      },
    );
    return _database!;
  }

  // Read
  Future<void> fetchAndSetBooks() async {
    final db = await _initDatabase();
    final rows = await db.query(_table, orderBy: 'added_at DESC');
    _books = rows.map(Book.fromMap).toList();
    notifyListeners();
  }

  // Create
  Future<void> addBook(Book book) async {
    final db = await _initDatabase();
    await db.insert(_table, book.toMap());
    await fetchAndSetBooks();
  }

  // Update (ต้องมี where + whereArgs)
  Future<void> updateBook(Book book) async {
    final db = await _initDatabase();
    await db.update(_table, book.toMap(),
        where: 'id = ?', whereArgs: [book.id]);
    await fetchAndSetBooks();
  }

  // Delete (ต้องมี where + whereArgs)
  Future<void> deleteBook(int id) async {
    final db = await _initDatabase();
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
    await fetchAndSetBooks();
  }
}
