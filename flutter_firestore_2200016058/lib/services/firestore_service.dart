import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../models/task.dart';
// import '../models/user_model.dart';

class FirestoreService {
  final user = FirebaseAuth.instance.currentUser!;
  late final CollectionReference taskRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('tasks');

  Future<void> addTask(Task task) => taskRef.add(task.toMap());

  Future<void> updateTask(Task task) =>
      taskRef.doc(task.id).update(task.toMap());

  Future<void> deleteTask(String id) => taskRef.doc(id).delete();

  Stream<List<Task>> getTasks() {
    try {
      return taskRef
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Task.fromDoc(doc.id, data);
            }).toList(),
          );
    } catch (e) {
      debugPrint('Firestore error: $e');
      return const Stream.empty();
    }
  }

  Future<void> toggleDone(String id, bool value) async {
    await taskRef.doc(id).update({'isDone': value});
  }
}
