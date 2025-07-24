import 'package:flutter/material.dart';

/// A reusable elevated button with loading state and consistent styling.
class CommonElevatedButton extends StatelessWidget {
  /// Creates a [CommonElevatedButton] with the given parameters.
  const CommonElevatedButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.enabled = true,
    super.key,
  });

  /// The callback to execute when the button is pressed.
  final VoidCallback? onPressed;

  /// The widget to display as the button's child.
  final Widget child;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading || !enabled) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: Theme.of(context).textTheme.labelLarge,
        elevation: 2,
      ),
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : child,
    );
  }
}
