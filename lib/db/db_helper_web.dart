import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static const _key = 'students_v1';

  Future<List<Map<String, dynamic>>> _loadRaw() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return [];
    final List<dynamic> decoded = json.decode(s) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }

  Future _saveRaw(List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(data));
  }

  Future<int> insertStudent(Student s) async {
    final raw = await _loadRaw();
    // ensure unique nim: replace if exists
    final idx = raw.indexWhere((e) => e['nim'] == s.nim);
    if (idx >= 0) {
      final existing = Map<String, dynamic>.from(raw[idx]);
      existing['name'] = s.name;
      raw[idx] = existing;
      await _saveRaw(raw);
      return existing['id'] as int? ?? idx + 1;
    } else {
      final nextId = (raw.isEmpty
          ? 1
          : (raw
                    .map((e) => e['id'] as int? ?? 0)
                    .reduce((a, b) => a > b ? a : b) +
                1));
      final map = {'id': nextId, 'nim': s.nim, 'name': s.name};
      raw.add(map);
      await _saveRaw(raw);
      return nextId;
    }
  }

  Future<List<Student>> getStudents({String? query}) async {
    final raw = await _loadRaw();
    var list = raw.map((e) => Student.fromMap(e)).toList();
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list
          .where(
            (s) =>
                s.nim.toLowerCase().contains(q) ||
                s.name.toLowerCase().contains(q),
          )
          .toList();
    }
    list.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
    return list;
  }

  Future<Student?> getStudentByNim(String nim) async {
    final raw = await _loadRaw();
    final found = raw.firstWhere((e) => e['nim'] == nim, orElse: () => {});
    if (found.isEmpty) return null;
    return Student.fromMap(found);
  }

  Future<int> deleteStudent(int id) async {
    final raw = await _loadRaw();
    raw.removeWhere((e) => e['id'] == id);
    await _saveRaw(raw);
    return 1;
  }
}
