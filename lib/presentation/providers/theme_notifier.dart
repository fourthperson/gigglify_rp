import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/domain/use_case/theme_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/theme_set_use_case.dart';

class ThemeNotifier extends StateNotifier<GigThemeMode> {
  final ThemeGetUseCase _getUseCase;
  final ThemeSetUseCase _setUseCase;

  ThemeNotifier({
    required ThemeGetUseCase getUseCase,
    required ThemeSetUseCase setUseCase,
  }) : _getUseCase = getUseCase,
       _setUseCase = setUseCase,
       super(GigThemeMode.system);

  Future<void> loadTheme() async {
    final GigThemeMode themeMode = await _getUseCase.invoke();
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
      );
    });
