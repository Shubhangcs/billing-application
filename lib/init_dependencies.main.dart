part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  await _initHive();
  _initAuth();
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
