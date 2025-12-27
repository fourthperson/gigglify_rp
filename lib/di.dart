part of 'main.dart';

final GetIt locator = GetIt.instance;

Future<void> initDependencies() async {
  // register logger
  final Logger logger = locator.registerSingleton(Logger());
  // load .env file
  await dotenv.load();
  // read info from .env
  final String baseUrl = dotenv.get('API_BASE_URL');
  final List<String> apiPaths = dotenv.get('API_PATHS').split(' ');
  final List<String> blacklists = dotenv.get('BLACKLIST_CATEGORIES').split(' ');
  // network and database instances
  final Dio dio = locator.registerSingleton(_dio(baseUrl: baseUrl));
  final GigDb db = await GigDb.create();
  locator.registerSingleton(db);
  // preference instance
  final FlutterSecureStorage secureStorage = locator.registerSingleton(
    const FlutterSecureStorage(),
  );

  // services
  final RestService restService = locator.registerSingleton(
    RestService(dio, logger: logger),
  );
  final PrefsService prefsService = locator.registerSingleton(
    PrefsService(secureStorage),
  );
  await prefsService.clearOnReinstall();

  // data sources
  final PrefsDataSource prefsDataSource = locator.registerSingleton(
    PrefsDataSourceImpl(prefsService, logger: logger),
  );
  final DatabaseDataSource databaseDataSource = locator.registerSingleton(
    DatabaseDataSourceImpl(db, logger: logger),
  );
  final ApiDataSource apiDataSource = locator.registerSingleton(
    ApiDataSourceImpl(restService, logger: logger),
  );

  // choice repository
  final ChoiceRepository choiceRepository = locator.registerSingleton(
    ChoiceRepositoryImpl(apiPaths, prefsDataSource),
  );

  // joke repository
  final JokeRepository jokeRepository = JokeRepositoryImpl(
    apiDataSource,
    databaseDataSource,
    logger: logger,
  );

  // use-cases
  locator.registerSingleton(GetJokeUseCase(jokeRepository, choiceRepository));
  locator.registerSingleton(SaveJokeUseCase(jokeRepository));
  locator.registerSingleton(GetSavedJokesUseCase(jokeRepository));
  locator.registerSingleton(GetChoiceUseCase(choiceRepository));
  locator.registerSingleton(SaveChoiceUseCase(choiceRepository));
}

Dio _dio({required final String baseUrl}) {
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

  return dio;
}
