import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class DBHelper {
  DBHelper._private();
  static final DBHelper instance = DBHelper._private();

  final CollectionReference<Map<String, dynamic>> _col = FirebaseFirestore
      .instance
      .collection('students');

  Future<int> insertStudent(Student s) async {
    final id = s.id ?? DateTime.now().millisecondsSinceEpoch;
    final map = s.toMap();
    map['id'] = id;
    await _col.doc(s.nim).set(map);
    return id;
  }

  Future<List<Student>> getStudents({String? query}) async {
    final snap = await _col.get();
    var list = snap.docs.map((d) => Student.fromMap(d.data())).toList();
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
    final doc = await _col.doc(nim).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return Student.fromMap(data);
  }

  Future<int> deleteStudent(int id) async {
    final q = await _col.where('id', isEqualTo: id).limit(1).get();
    if (q.docs.isEmpty) return 0;
    await q.docs.first.reference.delete();
    return 1;
  }

  Stream<List<Student>> studentsStream() {
    return _col.snapshots().map(
      (q) => q.docs.map((d) => Student.fromMap(d.data())).toList(),
    );
  }
}
