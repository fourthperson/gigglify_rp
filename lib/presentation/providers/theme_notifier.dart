import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/domain/use_case/theme_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/theme_set_use_case.dart';

// New provider for platform brightness
final platformBrightnessProvider = StateProvider<Brightness>((ref) {
  return PlatformDispatcher.instance.platformBrightness;
});

class ThemeNotifier extends StateNotifier<GigThemeMode>
    with WidgetsBindingObserver {
  final ThemeGetUseCase _getUseCase;
  final ThemeSetUseCase _setUseCase;
  final Ref _ref;

  ThemeNotifier({
    required ThemeGetUseCase getUseCase,
    required ThemeSetUseCase setUseCase,
    required Ref ref,
  }) : _getUseCase = getUseCase,
       _setUseCase = setUseCase,
       _ref = ref,
       super(GigThemeMode.system) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // Update the platform brightness provider when system theme changes
    _ref.read(platformBrightnessProvider.notifier).state =
        PlatformDispatcher.instance.platformBrightness;
  }

  Future<GigThemeMode> getTheme() async {
    return await _getUseCase.invoke();
  }

  Future<void> loadTheme() async {
    final GigThemeMode themeMode = await getTheme();
    state = themeMode;
  }

  Future<void> setTheme(GigThemeMode mode) async {
    await _setUseCase.invoke(mode);
    state = mode;
  }
}

final StateNotifierProvider<ThemeNotifier, GigThemeMode> themeProvider =
    StateNotifierProvider<ThemeNotifier, GigThemeMode>((Ref ref) {
      return ThemeNotifier(
        getUseCase: locator<ThemeGetUseCase>(),
        setUseCase: locator<ThemeSetUseCase>(),
        ref: ref,
      );
    });

// New provider that resolves the actual Flutter ThemeMode
final resolvedThemeProvider = Provider<ThemeMode>((Ref ref) {
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
});
