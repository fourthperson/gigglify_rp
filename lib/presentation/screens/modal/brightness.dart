import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/theme_notifier.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';
import 'package:ionicons_plus/ionicons_plus.dart';

class BrightnessModal extends ConsumerStatefulWidget {
  const BrightnessModal({super.key});

  @override
  ConsumerState<BrightnessModal> createState() => _PreferenceModalState();
}

class _PreferenceModalState extends ConsumerState<BrightnessModal> {
  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

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
              Text(strings.title_theme, style: textBold.copyWith(fontSize: 16)),
              const SizedBox(height: 10),
              _CategoryItem(
                checked: followSystem,
                label: strings.follow_system_theme,
                onTap: (bool _) {
                  if (followSystem) {
                    ref
                        .read(themeProvider.notifier)
                        .setTheme(GigThemeMode.light);
                  } else {
                    ref
                        .read(themeProvider.notifier)
                        .setTheme(GigThemeMode.system);
                  }
                },
              ),
              Opacity(
                opacity: mode == GigThemeMode.system ? 0.3 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: followSystem
                          ? null
                          : () {
                              if (lightMode) return;
                              ref
                                  .read(themeProvider.notifier)
                                  .setTheme(GigThemeMode.light);
                            },
                      icon: Icon(
                        Ionicons.sunny_outline,
                        size: 36,
                        color: lightMode ? Colors.purple : Colors.black12,
                      ),
                    ),
                    IconButton(
                      onPressed: followSystem
                          ? null
                          : () {
                              if (darkMode) return;
                              ref
                                  .read(themeProvider.notifier)
                                  .setTheme(GigThemeMode.dark);
                            },
                      icon: Icon(
                        Ionicons.moon_outline,
                        size: 36,
                        color: darkMode ? Colors.purple : Colors.black12,
                      ),
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
    return ListTile(
      dense: true,
      onTap: () => onTap(!checked),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -4),
      leading: Platform.isIOS
          ? CupertinoCheckbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: Colors.purple,
            )
          : Checkbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: Colors.purple,
            ),
      title: Text(label, style: textRegular),
    );
  }
}
