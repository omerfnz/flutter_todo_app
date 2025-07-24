import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/extensions/build_context_extension.dart';
import 'package:flutter_todo_app/feature/todo/view/widgets/add_todo_dialog.dart';
import 'package:flutter_todo_app/feature/todo/view/widgets/todo_list_item_card.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_bloc.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_event.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_state.dart';

/// Main screen displaying the todo list.
@RoutePage()
class TodoListView extends StatelessWidget {
  /// Creates a [TodoListView].
  const TodoListView({super.key});

  /// Shows the dialog for adding a new todo item.
  void _showAddDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('app.title'))),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          if (state.todos.isEmpty) {
            return Center(child: Text(context.tr('todos.empty')));
          }
          return ListView.builder(
            itemCount: state.todos.length,
            padding: const EdgeInsets.only(bottom: 80), // FAB için boşluk
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: TodoListItemCard(
                  key: ValueKey(todo.id),
                  todo: todo,
                  onToggle: (_) =>
                      context.read<TodoBloc>().add(UpdateTodo(todo.id)),
                  onDelete: () =>
                      context.read<TodoBloc>().add(DeleteTodo(todo.id)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
