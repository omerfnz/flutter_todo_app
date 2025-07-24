import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_event.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_state.dart';
import 'package:flutter_todo_app/product/service/todo_service.dart';

/// BLoC for managing todo state and handling events.
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  /// Creates a [TodoBloc] with the given [TodoService].
  TodoBloc(this._todoService) : super(TodoState.initial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  final TodoService _todoService;

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final todos = await _todoService.loadTodos();
      emit(state.copyWith(isLoading: false, todos: todos));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    // Add todo için loading gösterebiliriz çünkü dialog açık
    emit(state.copyWith(isLoading: true));
    try {
      await _todoService.addTodo(event.title);
      // Yeni todo'yu mevcut listeye ekle (tüm listeyi yeniden yükleme)
      final todos = await _todoService.loadTodos();
      emit(state.copyWith(isLoading: false, todos: todos));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    // Optimistic update - UI'ı hemen güncelle
    final currentTodos = List<TodoModel>.from(state.todos);
    final todoIndex = currentTodos.indexWhere((todo) => todo.id == event.id);

    if (todoIndex != -1) {
      final updatedTodo = currentTodos[todoIndex].copyWith(
        isCompleted: !currentTodos[todoIndex].isCompleted,
      );
      currentTodos[todoIndex] = updatedTodo;

      // Sıralama uygula
      currentTodos.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }
        final aTime = a.createdAt ?? DateTime.now();
        final bTime = b.createdAt ?? DateTime.now();
        return bTime.compareTo(aTime);
      });

      // UI'ı hemen güncelle (loading gösterme)
      emit(state.copyWith(todos: currentTodos));

      try {
        // Arka planda gerçek güncellemeyi yap
        await _todoService.toggleTodoCompletion(event.id);
      } catch (e) {
        // Hata durumunda eski haline geri döndür
        final originalTodos = List<TodoModel>.from(state.todos);
        final originalIndex =
            originalTodos.indexWhere((todo) => todo.id == event.id);
        if (originalIndex != -1) {
          originalTodos[originalIndex] = originalTodos[originalIndex].copyWith(
            isCompleted: !updatedTodo.isCompleted,
          );
          emit(state.copyWith(todos: originalTodos, error: e.toString()));
        }
      }
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    // Optimistic update - UI'dan hemen kaldır
    final currentTodos = List<TodoModel>.from(state.todos);
    final todoToDelete = currentTodos.firstWhere(
      (todo) => todo.id == event.id,
      orElse: () => throw Exception('Todo not found'),
    );
    currentTodos.removeWhere((todo) => todo.id == event.id);

    // UI'ı hemen güncelle
    emit(state.copyWith(todos: currentTodos));

    try {
      // Arka planda gerçek silme işlemini yap
      await _todoService.deleteTodo(event.id);
    } catch (e) {
      // Hata durumunda geri ekle
      final restoredTodos = List<TodoModel>.from(state.todos)
        ..add(todoToDelete)
        ..sort((a, b) => a.id.compareTo(b.id));
      emit(state.copyWith(todos: restoredTodos, error: e.toString()));
    }
  }
}
