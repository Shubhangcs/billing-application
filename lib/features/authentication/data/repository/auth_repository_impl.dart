import 'package:dartz/dartz.dart';
import 'package:new_billing/core/failures/exceptions.dart';
import 'package:new_billing/core/failures/failure.dart';
import 'package:new_billing/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:new_billing/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:new_billing/features/authentication/data/models/login_model.dart';
import 'package:new_billing/features/authentication/data/models/register_model.dart';
import 'package:new_billing/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });
  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final token = await authRemoteDataSource.login(
        loginDetails: LoginModel(
          email: email,
          password: password,
        ),
      );
      final response = authLocalDataSource.saveCredentials(token: token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalStorageException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: "Exception While Processing The Request."));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final token = await authRemoteDataSource.register(
        registerDetails: RegisterModel(
          userName: userName,
          email: email,
          password: password,
        ),
      );
      final response = authLocalDataSource.saveCredentials(token: token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalStorageException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: "Exception While Processing The Request."));
    }
  }

  @override
  Future<Either<Failure, String?>> autoLogin() async {
    try {
      final token = authLocalDataSource.autoLogin();
      return Right(token);
    } catch (e) {
      return Left(Failure(message: "Exception While Processing The Request."));
    }
  }
}
