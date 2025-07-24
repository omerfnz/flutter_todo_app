import 'package:flutter/material.dart';
import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';

/// A card widget representing a single todo item with completion and delete
/// actions.
class TodoListItemCard extends StatefulWidget {
  /// Creates a [TodoListItemCard] with the given parameters.
  const TodoListItemCard({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    super.key,
  });

  /// The todo item to display.
  final TodoModel todo;

  /// Callback when the todo completion status is toggled.
  final ValueChanged<bool?> onToggle;

  /// Callback when the todo is deleted.
  final VoidCallback onDelete;

  @override
  State<TodoListItemCard> createState() => _TodoListItemCardState();
}

class _TodoListItemCardState extends State<TodoListItemCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for checkbox
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    // Slide animation for entry
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start entry animation
    _slideController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _handleToggle(bool? value) {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
      widget.onToggle(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = widget.todo.isCompleted;

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dismissible(
          key: ValueKey(widget.todo.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: colorScheme.onError, size: 28),
                const SizedBox(height: 4),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          onDismissed: (_) => widget.onDelete(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: isCompleted
                  ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.7)
                  : colorScheme.surface,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: isCompleted
                      ? Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.3),
                          width: 2,
                        )
                      : null,
                ),
                child: ListTile(
                  leading: AnimatedScale(
                    scale: isCompleted ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Checkbox(
                      value: isCompleted,
                      onChanged: _handleToggle,
                      activeColor: colorScheme.primary,
                      checkColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  title: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: isCompleted
                          ? colorScheme.onSurface.withValues(alpha: 0.6)
                          : colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight:
                          isCompleted ? FontWeight.normal : FontWeight.w500,
                    ),
                    child: Text(widget.todo.title),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: colorScheme.error,
                    ),
                    onPressed: widget.onDelete,
                    tooltip: 'Delete',
                    splashRadius: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
