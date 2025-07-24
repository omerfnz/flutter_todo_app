import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

/// Model representing a todo item with persistence capabilities.
@JsonSerializable()
@HiveType(typeId: 0)
class TodoModel extends Equatable {
  /// Creates a [TodoModel] with the given parameters.
  const TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.createdAt,
  });

  /// Creates a TodoModel from a JSON map.
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  /// Unique identifier for the todo item.
  @HiveField(0)
  final String id;

  /// Task description.
  @HiveField(1)
  final String title;

  /// Completion status.
  @HiveField(2)
  final bool isCompleted;

  /// Creation timestamp for sorting.
  @HiveField(3, defaultValue: null)
  final DateTime? createdAt;

  /// Creates a copy of this TodoModel with optional new values.
  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Converts this TodoModel to a JSON map.
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  List<Object?> get props => [id, title, isCompleted, createdAt];
}
