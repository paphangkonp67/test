# เฉลยโจทย์ซ้อม: book_shelf (Flutter + SQLite + Provider)

## วิธีใช้
1. `flutter create book_shelf`
2. คัดลอกโฟลเดอร์ `lib/` ในนี้ทับของโปรเจกต์
3. เพิ่ม dependencies ใน `pubspec.yaml` แล้วรัน `flutter pub get`

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.2
  path: ^1.9.1
  provider: ^6.1.5+1
```

4. ถ้าเคยรันแอปชื่อเดียวกันมาก่อนแล้วโครงสร้างตารางไม่ตรง ให้ถอนการติดตั้งแอปจาก emulator แล้วรันใหม่

## โครงสร้างไฟล์
```
lib/
  main.dart
  models/book.dart
  providers/book_provider.dart
  screens/book_list_screen.dart
  screens/book_form_screen.dart
```

## เช็กลิสต์ก่อนส่งข้อสอบ
- `toMap()` ใส่ `id` เฉพาะเมื่อไม่ null
- bool <-> 1/0, DateTime <-> ISO string, enum <-> `.name` / `byName`
- `update` / `delete` มี `where` + `whereArgs`
- หลังแก้ DB เรียก fetch แล้ว `notifyListeners()`
- `if (!mounted) return;` หลัง `await` ก่อนใช้ context
- `context.read` ใน handler, `Consumer` / `context.watch` ใน build
- ไม่ตั้งชื่อคลาสว่า `Transaction` (ชนกับ sqflite)
- push ขึ้น GitHub แบบ Private และเพิ่ม nattaponk@nu.ac.th เป็น collaborator
