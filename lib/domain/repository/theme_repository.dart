import 'package:gigglify_rp/domain/entity/theme_mode.dart';

abstract class ThemeRepository {
  Future<void> setMode(GigThemeMode mode);

  Future<GigThemeMode> getMode();
}
