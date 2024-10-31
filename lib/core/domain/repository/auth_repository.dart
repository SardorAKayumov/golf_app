import 'package:dartz/dartz.dart';
import 'package:golf_app/core/domain/entity/request/signup_request_entity.dart';

import '../../error/failures.dart';
import '../entity/request/login_request_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signup(SignupRequestEntity request);
  Future<Either<Failure, void>> login(LoginRequestEntity request);
  Future<Either<Failure, void>> refreshToken();
}