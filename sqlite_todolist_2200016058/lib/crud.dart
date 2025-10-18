import 'package:sqflite/sqflite.dart';
import 'class_penangkap.dart';
import 'access_database.dart';

class CRUD {
  static const todoTable = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';
  AccessDatabase dbHelper = AccessDatabase();

  Future<int> insert(ClassPenangkap todo) async {
    final Database db = await dbHelper.initDb();
    final sql =
        '''INSERT INTO $todoTable
    (
      $name,
      $phone
    )
    VALUES (?,?)''';
    final List<dynamic> params = [todo.name, todo.phone];
    final int result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> update(ClassPenangkap todo) async {
    final Database db = await dbHelper.initDb();
    final sql =
        '''UPDATE $todoTable
    SET $name = ?, $phone = ?
    WHERE $id = ?
    ''';
    final List<dynamic> params = [todo.name, todo.phone, todo.id];
    final int result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> delete(ClassPenangkap todo) async {
    final Database db = await dbHelper.initDb();
    final sql =
        '''DELETE FROM $todoTable
    WHERE $id = ?
    ''';
    final List<dynamic> params = [todo.id];
    final int result = await db.rawDelete(sql, params);
    return result;
  }

  Future<List<ClassPenangkap>> getContactList() async {
    final Database db = await dbHelper.initDb();
    final sql = '''SELECT * FROM $todoTable''';
    final List<Map<String, dynamic>> data = await db.rawQuery(sql);
    final List<ClassPenangkap> todos = <ClassPenangkap>[];
    for (final node in data) {
      final todo = ClassPenangkap.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}
