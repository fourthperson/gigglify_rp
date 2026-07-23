import 'package:gigglify_rp/domain/entity/theme_mode.dart';
import 'package:gigglify_rp/domain/repository/theme_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeGetUseCase {
  final ThemeRepository _repository;

  ThemeGetUseCase({required ThemeRepository repository})
    : _repository = repository;

  Future<GigThemeMode> invoke() async {
    return await _repository.getMode();
  }
}
