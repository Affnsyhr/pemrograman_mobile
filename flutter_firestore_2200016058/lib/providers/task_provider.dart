import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';

class TaskProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Stream untuk real-time updates
  Stream<List<Task>> get tasksStream => _firestoreService.getTasks();

  // Add task
  Future<void> addTask(Task task) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.addTask(task);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update task
  Future<void> updateTask(Task task) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateTask(task);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.deleteTask(taskId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle done
  Future<void> toggleTaskDone(String taskId, bool isDone) async {
    try {
      await _firestoreService.toggleDone(taskId, isDone);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
