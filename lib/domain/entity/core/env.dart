import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_PATHS')
  static const String apiPaths = _Env.apiPaths;

  @EnviedField(varName: 'BLACKLIST_CATEGORIES')
  static const String blacklistCategories = _Env.blacklistCategories;
}
