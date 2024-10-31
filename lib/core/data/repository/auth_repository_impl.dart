import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:golf_app/core/data/model/request/signup_request_model.dart';
import 'package:golf_app/core/domain/entity/request/signup_request_entity.dart';

import '../../domain/entity/request/login_request_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../../error/failures.dart';
import '../datasource/auth_data_source.dart';
import '../../local_storage/secure_storage.dart';
import '../model/request/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required SecureStorage secureStorage,
  })  : _authDataSource = authDataSource,
        _secureStorage = secureStorage;

        @override
  Future<Either<Failure, void>> signup(SignupRequestEntity request) async {
    try {
      final requestModel = SignupRequestModel.fromEntity(request);
      final data = await _authDataSource.signup(requestModel);

      final accessToken = data['access_token'] ?? '';
      final refreshToken = data['refresh_token'] ?? '';
      await _secureStorage.setAccessToken(accessToken);
      await _secureStorage.setRefreshToken(refreshToken);

      return const Right(null);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.cancel:
          return Left(NetworkFailure(message: e.message ?? ''));
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
            return Left(AuthFailure(message: e.message ?? ''));
          }
          return Left(ServerFailure(
              message: e.message ?? '',
              statusCode: e.response?.statusCode.toString() ?? ''));
        default:
          return Left(UnexpectedFailure(message: e.toString()));
      }
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login(LoginRequestEntity request) async {
    try {
      final requestModel = LoginRequestModel.fromEntity(request);
      final data = await _authDataSource.login(requestModel);

      final accessToken = data['access_token'] ?? '';
      final refreshToken = data['refresh_token'] ?? '';
      await _secureStorage.setAccessToken(accessToken);
      await _secureStorage.setRefreshToken(refreshToken);

      return const Right(null);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.cancel:
          return Left(NetworkFailure(message: e.message ?? ''));
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
            return Left(AuthFailure(message: e.message ?? ''));
          }
          return Left(ServerFailure(
              message: e.message ?? '',
              statusCode: e.response?.statusCode.toString() ?? ''));
        default:
          return Left(UnexpectedFailure(message: e.toString()));
      }
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      final currentRefreshToken = await _secureStorage.getRefreshToken();
      final data = await _authDataSource.refreshToken(currentRefreshToken);

      final accessToken = data['access_token'] ?? '';
      final refreshToken = data['refresh_token'] ?? '';
      await _secureStorage.setAccessToken(accessToken);
      await _secureStorage.setRefreshToken(refreshToken);

      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
