// lib/screens/book_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import 'book_form_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ชั้นหนังสือ')),
      body: Consumer<BookProvider>(
        builder: (context, p, _) {
          if (p.books.isEmpty) {
            return const Center(child: Text('ยังไม่มีหนังสือ'));
          }
          return ListView.builder(
            itemCount: p.books.length,
            itemBuilder: (ctx, i) {
              final b = p.books[i];
              return ListTile(
                title: Text(b.title),
                subtitle: Text(
                    '${b.author} • ${b.genre.name} • ${b.price.toStringAsFixed(2)} บาท'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookFormScreen(book: b)),
                ),
                leading: Checkbox(
                  value: b.isRead,
                  onChanged: (v) => context.read<BookProvider>().updateBook(
                        Book(
                          id: b.id,
                          title: b.title,
                          author: b.author,
                          price: b.price,
                          isRead: v ?? false,
                          addedAt: b.addedAt,
                          genre: b.genre,
                        ),
                      ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      context.read<BookProvider>().deleteBook(b.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BookFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
