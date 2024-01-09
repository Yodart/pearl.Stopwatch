import 'package:flutter/material.dart';

/// A custom button widget.
///
/// This widget represents a button that can be tapped by the user.
/// It has customizable properties such as color, text, and onTap callback.
/// The button can also be disabled by setting the [isDisabled] property to true.
class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    this.isDisabled = false,
  });

  final Color color;
  final bool isDisabled;
  final String text;
  final VoidCallback onTap;

  void handleTap() {
    if (isDisabled) return;
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: handleTap,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(minWidth: 100),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
