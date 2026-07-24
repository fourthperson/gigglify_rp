import 'package:flutter/material.dart';

class GigButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final void Function()? onTap;

  const GigButton({
    required this.label,
    this.backgroundColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: Text(label, style: theme.textTheme.titleSmall)),
        ),
      ),
    );
  }
}
