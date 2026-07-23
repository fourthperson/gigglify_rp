// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:gigglify_rp/data/repository/choice_repo_impl.dart' as _i0;
import 'package:gigglify_rp/data/repository/joke_repo_impl.dart' as _i576;
import 'package:gigglify_rp/data/repository/theme_repo_impl.dart' as _i1053;
import 'package:gigglify_rp/data/source/local/db/db_data_source.dart' as _i44;
import 'package:gigglify_rp/data/source/local/db/gig_db.dart' as _i565;
import 'package:gigglify_rp/data/source/local/prefs/prefs_data_source.dart'
    as _i500;
import 'package:gigglify_rp/data/source/local/prefs/prefs_service.dart'
    as _i687;
import 'package:gigglify_rp/data/source/remote/api/api_data_source.dart'
    as _i666;
import 'package:gigglify_rp/data/source/remote/api/rest_service.dart' as _i900;
import 'package:gigglify_rp/di.dart' as _i275;
import 'package:gigglify_rp/domain/entity/core/config.dart' as _i264;
import 'package:gigglify_rp/domain/repository/choice_repository.dart' as _i480;
import 'package:gigglify_rp/domain/repository/joke_repository.dart' as _i216;
import 'package:gigglify_rp/domain/repository/theme_repository.dart' as _i198;
import 'package:gigglify_rp/domain/use_case/choice_get_use_case.dart' as _i516;
import 'package:gigglify_rp/domain/use_case/choice_set_use_case.dart' as _i392;
import 'package:gigglify_rp/domain/use_case/joke_get_use_case.dart' as _i904;
import 'package:gigglify_rp/domain/use_case/joke_history_get_use_case.dart'
    as _i16;
import 'package:gigglify_rp/domain/use_case/joke_save_use_case.dart' as _i852;
import 'package:gigglify_rp/domain/use_case/theme_get_use_case.dart' as _i19;
import 'package:gigglify_rp/domain/use_case/theme_set_use_case.dart' as _i220;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final gigglifyModule = _$GigglifyModule();
    gh.singleton<_i264.AppConfig>(() => gigglifyModule.config);
    gh.lazySingleton<_i974.Logger>(() => gigglifyModule.logger);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => gigglifyModule.flutterSecureStorage,
    );
    await gh.lazySingletonAsync<_i565.GigDb>(
      () => gigglifyModule.gigDb(),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i687.PrefsService>(
      () => gigglifyModule.prefsService(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => gigglifyModule.dio());
    gh.lazySingleton<_i900.RestService>(
      () => _i900.RestService(dio: gh<_i361.Dio>(), logger: gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i44.DatabaseDataSource>(
      () => _i44.DatabaseDataSourceImpl(
        gigDb: gh<_i565.GigDb>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i666.ApiDataSource>(
      () => _i666.ApiDataSourceImpl(
        restService: gh<_i900.RestService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i216.JokeRepository>(
      () => _i576.JokeRepositoryImpl(
        apiDataSource: gh<_i666.ApiDataSource>(),
        databaseDataSource: gh<_i44.DatabaseDataSource>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i500.PrefsDataSource>(
      () => _i500.PrefsDataSourceImpl(
        prefsService: gh<_i687.PrefsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i16.JokeHistoryGetUseCase>(
      () => _i16.JokeHistoryGetUseCase(
        jokeRepository: gh<_i216.JokeRepository>(),
      ),
    );
    gh.lazySingleton<_i852.JokeSaveUseCase>(
      () => _i852.JokeSaveUseCase(jokeRepository: gh<_i216.JokeRepository>()),
    );
    gh.lazySingleton<_i480.ChoiceRepository>(
      () => _i0.ChoiceRepositoryImpl(
        config: gh<_i264.AppConfig>(),
        prefsDataSource: gh<_i500.PrefsDataSource>(),
      ),
    );
    gh.lazySingleton<_i198.ThemeRepository>(
      () => _i1053.ThemeRepoImpl(
        prefsDataSource: gh<_i500.PrefsDataSource>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i904.JokeGetUseCase>(
      () => _i904.JokeGetUseCase(
        jokeRepository: gh<_i216.JokeRepository>(),
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    gh.lazySingleton<_i516.ChoiceGetUseCase>(
      () => _i516.ChoiceGetUseCase(
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    gh.lazySingleton<_i392.ChoiceSetUseCase>(
      () => _i392.ChoiceSetUseCase(
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    gh.lazySingleton<_i19.ThemeGetUseCase>(
      () => _i19.ThemeGetUseCase(repository: gh<_i198.ThemeRepository>()),
    );
    gh.lazySingleton<_i220.ThemeSetUseCase>(
      () => _i220.ThemeSetUseCase(repository: gh<_i198.ThemeRepository>()),
    );
    return this;
  }
}

class _$GigglifyModule extends _i275.GigglifyModule {}
