import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/student.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'mahasiswa.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertStudent(Student s) async {
    final db = await database;
    return await db.insert(
      'students',
      s.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents({String? query}) async {
    final db = await database;
    final where = (query != null && query.isNotEmpty)
        ? "WHERE nim LIKE '%$query%' OR name LIKE '%$query%'"
        : '';
    final res = await db.rawQuery(
      'SELECT * FROM students $where ORDER BY id DESC',
    );
    return res.map((e) => Student.fromMap(e)).toList();
  }

  Future<Student?> getStudentByNim(String nim) async {
    final db = await database;
    final res = await db.query('students', where: 'nim = ?', whereArgs: [nim]);
    if (res.isEmpty) return null;
    return Student.fromMap(res.first);
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
