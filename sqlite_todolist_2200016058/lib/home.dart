import 'package:sqflite/sqflite.dart';
import 'class_penangkap.dart';
import 'access_database.dart';

class CRUD {
  static const todoTable = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';

  final AccessDatabase dbHelper = AccessDatabase();

  Future<int> insert(ClassPenangkap contact) async {
    try {
      final Database db = await dbHelper.initDb();
      final int result = await db.insert(todoTable, contact.toMap());
      return result;
    } catch (e) {
      print('CRUD.insert error: $e');
      return -1;
    }
  }

  Future<int> update(ClassPenangkap contact) async {
    try {
      final Database db = await dbHelper.initDb();
      final int result = await db.update(
        todoTable,
        contact.toMap(),
        where: '$id = ?',
        whereArgs: [contact.id],
      );
      return result;
    } catch (e) {
      print('CRUD.update error: $e');
      return -1;
    }
  }

  Future<int> delete(ClassPenangkap contact) async {
    try {
      final Database db = await dbHelper.initDb();
      final int result = await db.delete(
        todoTable,
        where: '$id = ?',
        whereArgs: [contact.id],
      );
      return result;
    } catch (e) {
      print('CRUD.delete error: $e');
      return -1;
    }
  }

  Future<List<ClassPenangkap>> getContactList() async {
    try {
      final Database db = await dbHelper.initDb();
      final List<Map<String, dynamic>> data = await db.query(todoTable);
      final List<ClassPenangkap> contacts = <ClassPenangkap>[];
      for (final node in data) {
        contacts.add(ClassPenangkap.fromMap(node));
      }
      return contacts;
    } catch (e) {
      print('CRUD.getContactList error: $e');
      return <ClassPenangkap>[];
    }
  }
}
