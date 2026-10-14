// lib/models/book.dart
enum Genre { fiction, nonfiction, tech }

class Book {
  final int? id;
  final String title;
  final String author;
  final double price;
  final bool isRead;
  final DateTime addedAt;
  final Genre genre;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.price,
    this.isRead = false,
    required this.addedAt,
    required this.genre,
  });

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id, // ใส่ id เฉพาะเมื่อมีค่า (ไม่งั้น update พัง)
        'title': title,
        'author': author,
        'price': price,
        'is_read': isRead ? 1 : 0, // bool -> INTEGER
        'added_at': addedAt.toIso8601String(), // DateTime -> TEXT
        'genre': genre.name, // enum -> TEXT
      };

  factory Book.fromMap(Map<String, dynamic> map) => Book(
        id: map['id'] as int,
        title: map['title'] as String,
        author: map['author'] as String,
        price: (map['price'] as num).toDouble(),
        isRead: map['is_read'] == 1,
        addedAt: DateTime.parse(map['added_at'] as String),
        genre: Genre.values.byName(map['genre'] as String),
      );
}
