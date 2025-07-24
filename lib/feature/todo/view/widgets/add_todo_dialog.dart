import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/extensions/build_context_extension.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_bloc.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_event.dart';
import 'package:flutter_todo_app/product/widget/common_elevated_button.dart';

/// Dialog widget for adding a new todo item.
class AddTodoDialog extends StatefulWidget {
  /// Creates an [AddTodoDialog].
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles saving the new todo item.
  Future<void> _save() async {
    final title = _controller.text.trim();
    if (title.isEmpty) {
      setState(() => _error = context.tr('todos.hint'));
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      context.read<TodoBloc>().add(AddTodo(title));
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = context.tr('general.error');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: context.tr('todos.hint'),
                errorText: _error,
              ),
              autofocus: true,
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 24),
            CommonElevatedButton(
              onPressed: _save,
              isLoading: _isLoading,
              child: Text(context.tr('general.save')),
            ),
          ],
        ),
      ),
    );
  }
}
