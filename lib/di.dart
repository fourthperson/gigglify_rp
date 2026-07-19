import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gigglify_rp/data/source/db/gig_db.dart';
import 'package:gigglify_rp/env.dart';
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

  // @preResolve
  // @lazySingleton
  // Future<GigDb> get gigDb => await GigDb.create();

  @lazySingleton
  Dio dio() {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
        receiveDataWhenStatusError: false,
        validateStatus: (status) => true,
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
