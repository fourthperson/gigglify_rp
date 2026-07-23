import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/theme_notifier.dart';
import 'package:ionicons_plus/ionicons_plus.dart';

class BrightnessModal extends ConsumerStatefulWidget {
  const BrightnessModal({super.key});

  @override
  ConsumerState<BrightnessModal> createState() => _BrightnessModalState();
}

class _BrightnessModalState extends ConsumerState<BrightnessModal> {
  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final ThemeData theme = Theme.of(context);

    final GigThemeMode mode = ref.watch(themeProvider);
    final bool followSystem = mode == GigThemeMode.system;
    final bool lightMode = mode == GigThemeMode.light;
    final bool darkMode = mode == GigThemeMode.dark;

    return RawScrollbar(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(strings.title_theme, style: theme.textTheme.titleLarge),
              const SizedBox(height: 10),
              _CategoryItem(
                checked: followSystem,
                label: strings.follow_system_theme,
                onTap: (bool _) {
                  if (followSystem) {
                    final Brightness brightness = WidgetsBinding
                        .instance
                        .platformDispatcher
                        .platformBrightness;
                    ref
                        .read(themeProvider.notifier)
                        .setTheme(
                          brightness == Brightness.light
                              ? GigThemeMode.light
                              : GigThemeMode.dark,
                        );
                  } else {
                    ref
                        .read(themeProvider.notifier)
                        .setTheme(GigThemeMode.system);
                  }
                },
              ),
              Opacity(
                opacity: followSystem ? 0.3 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: followSystem || lightMode
                              ? null
                              : () => ref
                                    .read(themeProvider.notifier)
                                    .setTheme(GigThemeMode.light),
                          icon: Icon(
                            Ionicons.sunny_outline,
                            size: 36,
                            color: lightMode
                                ? theme.colorScheme.secondary
                                : theme.iconTheme.color?.withValues(alpha: 0.3),
                          ),
                        ),
                        Text(
                          strings.theme_light,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: lightMode
                                ? theme.colorScheme.secondary
                                : theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: followSystem || darkMode
                              ? null
                              : () => ref
                                    .read(themeProvider.notifier)
                                    .setTheme(GigThemeMode.dark),
                          icon: Icon(
                            Ionicons.moon_outline,
                            size: 36,
                            color: darkMode
                                ? theme.colorScheme.secondary
                                : theme.iconTheme.color?.withValues(alpha: 0.3),
                          ),
                        ),
                        Text(
                          strings.theme_dark,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: darkMode
                                ? theme.colorScheme.secondary
                                : theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final bool checked;
  final String label;
  final void Function(bool) onTap;

  const _CategoryItem({
    required this.checked,
    required this.label,
    required this.onTap,
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
