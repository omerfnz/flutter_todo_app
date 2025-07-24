import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_app/product/cache/todo_cache_manager.dart';
import 'package:uuid/uuid.dart';

/// Provides business logic for todo operations.
class TodoService {
  /// Creates a [TodoService] with the given [TodoCacheManager].
  TodoService(this._cacheManager);

  final TodoCacheManager _cacheManager;
  final Uuid _uuid = const Uuid();

  /// Loads all todos from the cache.
  Future<List<TodoModel>> loadTodos() async {
    try {
      final todos = await _cacheManager.getAllTodos();
      // Önce tamamlanmamış görevler (createdAt'e göre sıralı),
      // sonra tamamlanmış görevler
      todos.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1; // Tamamlanmamış görevler üstte
        }
        // Null createdAt için fallback
        final aTime = a.createdAt ?? DateTime.now();
        final bTime = b.createdAt ?? DateTime.now();
        return bTime.compareTo(aTime); // Yeni görevler üstte
      });
      return todos;
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  /// Adds a new todo with the given title.
  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) {
      throw Exception('Todo title cannot be empty.');
    }
    final todo = TodoModel(
      id: _uuid.v4(),
      title: title.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    try {
      await _cacheManager.saveTodo(todo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  /// Toggles the completion status of a todo by ID.
  Future<void> toggleTodoCompletion(String id) async {
    try {
      final todos = await _cacheManager.getAllTodos();
      final todo = todos.firstWhere(
        (t) => t.id == id,
        orElse: () => throw Exception('Todo not found.'),
      );
      final updated = todo.copyWith(isCompleted: !todo.isCompleted);
      await _cacheManager.updateTodo(updated);
    } catch (e) {
      throw Exception('Failed to toggle todo completion: $e');
    }
  }

  /// Deletes a todo by ID.
  Future<void> deleteTodo(String id) async {
    try {
      await _cacheManager.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
