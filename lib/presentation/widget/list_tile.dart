import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GigListTile extends StatelessWidget {
  final bool checked;
  final String label;
  final void Function(bool) onTap;

  const GigListTile({
    required this.checked,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      dense: true,
      onTap: () => onTap(!checked),
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Platform.isIOS
          ? CupertinoCheckbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: theme.colorScheme.secondary,
            )
          : Checkbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: theme.colorScheme.secondary,
            ),
      title: Text(label, style: theme.textTheme.bodyLarge),
    );
  }
}
