import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<String> _tasks = [];
  List<String> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _tasks = prefs.getStringList('tasks') ?? [];
    notifyListeners();
  }

  Future<void> addTask(String task) async {
    if (task.trim().isEmpty) return;
    _tasks.add(task);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }

  Future<void> updateTask(int index, String newTask) async {
    if (newTask.trim().isEmpty) return;
    _tasks[index] = newTask;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }
}
