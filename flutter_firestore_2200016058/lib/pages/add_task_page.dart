import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _controller = TextEditingController();
  final _firestoreService = FirestoreService();

  void _saveTask() {
    if (_controller.text.trim().isEmpty) return;
    final task = Task(
      id: '',
      title: _controller.text.trim(),
      isDone: false,
      timestamp: DateTime.now(),
    );
    _firestoreService.addTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nama Tugas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveTask,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
