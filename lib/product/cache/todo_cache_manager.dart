import 'package:flutter_todo_app/core/constants/cache_constants.dart';
import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';
import 'package:hive/hive.dart';

/// Manages Hive storage operations for TodoModel.
class TodoCacheManager {
  /// Returns the Hive box for todos.
  Future<Box<TodoModel>> _getBox() async {
    return Hive.openBox<TodoModel>(CacheConstants.todoBox);
  }

  /// Retrieves all todos from the Hive box.
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final box = await _getBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  /// Saves a new todo to the Hive box.
  Future<void> saveTodo(TodoModel todo) async {
    try {
      final box = await _getBox();
      await box.put(todo.id, todo);
    } catch (e) {
      throw Exception('Failed to save todo: $e');
    }
  }

  /// Updates an existing todo in the Hive box.
  Future<void> updateTodo(TodoModel todo) async {
    try {
      final box = await _getBox();
      await box.put(todo.id, todo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  /// Deletes a todo by ID from the Hive box.
  Future<void> deleteTodo(String id) async {
    try {
      final box = await _getBox();
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  /// Clears all todos from the Hive box.
  Future<void> clearAllTodos() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw Exception('Failed to clear todos: $e');
    }
  }
}
