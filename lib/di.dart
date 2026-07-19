import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:gigglify_rp/di.config.dart';
import 'package:logger/logger.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
void configureDependencies() => locator.init();

@module
abstract class GigglifyModule {
  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();
}
