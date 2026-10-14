// lib/screens/book_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';

class BookFormScreen extends StatefulWidget {
  final Book? book; // null = เพิ่มใหม่, มีค่า = แก้ไข
  const BookFormScreen({super.key, this.book});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _author;
  late final TextEditingController _price;
  late Genre _genre;

  @override
  void initState() {
    super.initState();
    final b = widget.book;
    _title = TextEditingController(text: b?.title ?? '');
    _author = TextEditingController(text: b?.author ?? '');
    _price = TextEditingController(text: b?.price.toString() ?? '');
    _genre = b?.genre ?? Genre.fiction;
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    _price.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<BookProvider>();
    final old = widget.book;
    final book = Book(
      id: old?.id,
      title: _title.text.trim(),
      author: _author.text.trim(),
      price: double.parse(_price.text),
      isRead: old?.isRead ?? false,
      addedAt: old?.addedAt ?? DateTime.now(),
      genre: _genre,
    );
    if (old == null) {
      await provider.addBook(book);
    } else {
      await provider.updateBook(book);
    }
    if (!mounted) return; // เช็กหลัง await ก่อนใช้ context
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.book == null ? 'เพิ่มหนังสือ' : 'แก้ไขหนังสือ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'ชื่อหนังสือ'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'กรุณากรอกชื่อ' : null,
              ),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(labelText: 'ผู้แต่ง'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'กรุณากรอกผู้แต่ง' : null,
              ),
              TextFormField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'ราคา'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    double.tryParse(v ?? '') == null ? 'ราคาไม่ถูกต้อง' : null,
              ),
              DropdownButtonFormField<Genre>(
                value: _genre,
                decoration: const InputDecoration(labelText: 'ประเภท'),
                items: Genre.values
                    .map((g) => DropdownMenuItem(value: g, child: Text(g.name)))
                    .toList(),
                onChanged: (g) => setState(() => _genre = g!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('บันทึก')),
            ],
          ),
        ),
      ),
    );
  }
}
