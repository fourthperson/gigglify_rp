part of 'main.dart';

final GetIt locator = GetIt.instance;

Future<void> initDependencies() async {
  // load .env file
  // read info from .env
  final String baseUrl = Env.apiBaseUrl;
  final List<String> apiPaths = Env.apiPaths.split(' ');
  final List<String> blacklistCategories = Env.blacklistCategories.split(' ');

  // logger
  final Logger logger = Logger();

  // network and database instances
  final GigDb db = await GigDb.create();
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
      receiveDataWhenStatusError: false,
      validateStatus: (status) => true,
      contentType: 'application/json; charset=UTF-8',
      baseUrl: baseUrl,
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

  // preferences instance
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // rest & preference utility services
  final RestService restService = RestService(dio, logger: logger);
  final PrefsService prefsService = PrefsService(secureStorage);
  await prefsService.clearOnReinstall();

  // data sources
  final PrefsDataSource prefsDataSource = PrefsDataSourceImpl(
    prefsService,
    logger: logger,
  );
  final DatabaseDataSource databaseDataSource = DatabaseDataSourceImpl(
    db,
    logger: logger,
  );
  final ApiDataSource apiDataSource = ApiDataSourceImpl(
    restService,
    logger: logger,
  );

  // choice repository
  final ChoiceRepository choiceRepository = ChoiceRepositoryImpl(
    apiPaths: apiPaths,
    blacklistCategories: blacklistCategories,
    prefsDataSource: prefsDataSource,
  );

  // joke repository
  final JokeRepository jokeRepository = JokeRepositoryImpl(
    apiDataSource: apiDataSource,
    databaseDataSource: databaseDataSource,
    logger: logger,
  );

  // use-cases
  locator.registerSingleton(GetJokeUseCase(jokeRepository, choiceRepository));
  locator.registerSingleton(SaveJokeUseCase(jokeRepository));
  locator.registerSingleton(GetSavedJokesUseCase(jokeRepository));
  locator.registerSingleton(GetChoiceUseCase(choiceRepository));
  locator.registerSingleton(SaveChoiceUseCase(choiceRepository));
}
