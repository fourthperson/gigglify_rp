import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/presentation/providers/use_case_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class PlatformBrightness extends _$PlatformBrightness {
  @override
  Brightness build() {
    // Return initial platform brightness
    return PlatformDispatcher.instance.platformBrightness;
  }

  void updateBrightness(Brightness brightness) {
    state = brightness;
  }
}

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  late final WidgetsBindingObserver _observer;

  @override
  GigThemeMode build() {
    // Set up lifecycle observer for system brightness changes
    _observer = _SystemThemeObserver(() {
      ref
          .read(platformBrightnessProvider.notifier)
          .updateBrightness(PlatformDispatcher.instance.platformBrightness);
    });

    WidgetsBinding.instance.addObserver(_observer);

    // Clean up observer when the provider is disposed
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(_observer);
    });

    // Default initial state
    return GigThemeMode.system;
  }

  Future<GigThemeMode> getTheme() async {
    return await ref.read(themeGetUseCaseProvider).invoke();
  }

  Future<void> loadTheme() async {
    final GigThemeMode mode = await getTheme();
    state = mode;
  }

  Future<void> setTheme(GigThemeMode mode) async {
    await ref.read(themeSetUseCaseProvider).invoke(mode);
    state = mode;
  }
}

// Helper observer class to isolate WidgetsBinding logic
class _SystemThemeObserver extends WidgetsBindingObserver {
  final VoidCallback onBrightnessChanged;

  _SystemThemeObserver(this.onBrightnessChanged);

  @override
  void didChangePlatformBrightness() {
    onBrightnessChanged();
  }
}

// --- Resolved Theme Mode Provider ---
@Riverpod(keepAlive: true)
ThemeMode resolvedTheme(Ref ref) {
  final GigThemeMode userPreference = ref.watch(themeProvider);
  final Brightness platformBrightness = ref.watch(platformBrightnessProvider);

  switch (userPreference) {
    case GigThemeMode.light:
      return ThemeMode.light;
    case GigThemeMode.dark:
      return ThemeMode.dark;
    case GigThemeMode.system:
      return platformBrightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark;
  }
}
