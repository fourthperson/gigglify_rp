import 'package:gigglify_rp/data/source/local/prefs/prefs_data_source.dart';
import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/domain/repository/theme_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: ThemeRepository)
class ThemeRepoImpl extends ThemeRepository {
  final PrefsDataSource _prefsDataSource;
  final Logger? _logger;

  ThemeRepoImpl({
    required PrefsDataSource prefsDataSource,
    required Logger? logger,
  }) : _prefsDataSource = prefsDataSource,
       _logger = logger;

  @override
  Future<GigThemeMode> getMode() async {
    final String theme = await _prefsDataSource.getTheme();
    _logger?.i('getMode: $theme');
    return GigThemeMode.fromString(theme);
  }

  @override
  Future<void> setMode(GigThemeMode mode) async {
    await _prefsDataSource.setTheme(mode.value);
  }
}
