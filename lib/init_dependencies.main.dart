part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  await _initHive();
  _initAuth();
  _initHistory();
  serviceLocator.registerLazySingleton(() => Connection());
  serviceLocator.registerLazySingleton(() => http.Client());
}

Future<void> _initHive() async {
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  final Box<String> box = await Hive.openBox("user_details");
  serviceLocator.registerLazySingleton(() => box);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        client: serviceLocator(),
        connection: serviceLocator(),
      ),
    )
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        box: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authLocalDataSource: serviceLocator(),
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => LoginUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => RegisterUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        loginUsecase: serviceLocator(),
        registerUsecase: serviceLocator(),
      ),
    );
}

void _initHistory() {
  serviceLocator
    ..registerFactory<HistoryRemoteDataSource>(
      () => HistoryRemoteDataSourceImpl(
        client: serviceLocator(),
        connection: serviceLocator(),
      ),
    )
    ..registerFactory<HistoryLocalDataSource>(() => HistoryLocalDataSourceImpl(
          box: serviceLocator(),
        ))
    ..registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(
        historyLocalDataSource: serviceLocator(),
        historyRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FetchHistoryUsecase(
        historyRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteInvoiceUsecase(
        historyRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => UpdatePaymentStatusUsecase(
        historyRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => HistoryBloc(
        fetchHistoryUsecase: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DeleteInvoiceCubit(
        deleteInvoiceUsecase: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => PaymentStatusUpdaterCubit(
        updatePaymentStatusUsecase: serviceLocator(),
      ),
    );
}
