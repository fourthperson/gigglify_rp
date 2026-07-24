import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gigglify_rp/data/source/local/db/gig_db.dart';
import 'package:gigglify_rp/data/source/local/prefs/prefs_service.dart';
import 'package:gigglify_rp/domain/entity/core/config.dart';
import 'package:gigglify_rp/domain/entity/core/env.dart';
import 'package:injectable/injectable.dart';
import 'package:gigglify_rp/di.config.dart';
import 'package:logger/logger.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await locator.init();

@module
abstract class GigglifyModule {
  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();

  @preResolve
  @lazySingleton
  Future<GigDb> gigDb() => GigDb.create();

  @preResolve
  @lazySingleton
  Future<PrefsService> prefsService() async {
    final PrefsService prefsService = PrefsService(
      secureStorage: flutterSecureStorage,
    );
    await prefsService.clearOnReinstall();
    return prefsService;
  }

  @singleton
  AppConfig get config => AppConfig(
    categories: Env.apiPaths.split(' '),
    blacklistable: Env.blacklistCategories.split(' '),
  );

  @lazySingleton
  Dio dio() {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
        receiveDataWhenStatusError: false,
        validateStatus: (int? status) => true,
        contentType: 'application/json; charset=UTF-8',
        baseUrl: Env.apiBaseUrl,
        responseType: ResponseType.plain,
      ),
    );
    dio.interceptors.clear();
    if (kDebugMode) {
      final Interceptor interceptor = LogInterceptor(
        responseBody: true,
        requestBody: true,
      );
      dio.interceptors.add(interceptor);
    }
    return dio;
  }
}
