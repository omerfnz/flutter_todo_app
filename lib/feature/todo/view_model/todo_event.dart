import 'package:equatable/equatable.dart';

/// Base class for all todo events.
abstract class TodoEvent extends Equatable {
  /// Creates a [TodoEvent].
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all todos.
class LoadTodos extends TodoEvent {
  /// Creates a [LoadTodos] event.
  const LoadTodos();
}

/// Event to add a new todo with a title.
class AddTodo extends TodoEvent {
  /// Creates an [AddTodo] event with the given [title].
  const AddTodo(this.title);

  /// The title of the todo to add.
  final String title;

  @override
  List<Object?> get props => [title];
}

/// Event to update (toggle) a todo by id.
class UpdateTodo extends TodoEvent {
  /// Creates an [UpdateTodo] event with the given [id].
  const UpdateTodo(this.id);

  /// The id of the todo to update.
  final String id;

  @override
  List<Object?> get props => [id];
}

/// Event to delete a todo by id.
class DeleteTodo extends TodoEvent {
  /// Creates a [DeleteTodo] event with the given [id].
  const DeleteTodo(this.id);

  /// The id of the todo to delete.
  final String id;

  @override
  List<Object?> get props => [id];
}
