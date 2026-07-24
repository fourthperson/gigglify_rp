import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/domain/repository/theme_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeSetUseCase {
  final ThemeRepository _repository;

  ThemeSetUseCase({required ThemeRepository repository})
    : _repository = repository;

  Future<void> invoke(GigThemeMode mode) async {
    await _repository.setMode(mode);
  }
}
