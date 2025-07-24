import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';

/// Represents the state of the todo list.
class TodoState extends Equatable {
  /// Creates a [TodoState] with the given parameters.
  const TodoState({required this.isLoading, required this.todos, this.error});

  /// Initial state: not loading, empty list, no error.
  factory TodoState.initial() => const TodoState(isLoading: false, todos: []);

  /// Whether the state is currently loading.
  final bool isLoading;

  /// The list of todos.
  final List<TodoModel> todos;

  /// Any error message.
  final String? error;

  /// Returns a copy of this state with optional new values.
  TodoState copyWith({bool? isLoading, List<TodoModel>? todos, String? error}) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      todos: todos ?? this.todos,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, todos, error];
}
