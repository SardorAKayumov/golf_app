import 'package:dartz/dartz.dart';
import 'package:golf_app/core/domain/entity/request/signup_request_entity.dart';

import '../../error/failures.dart';
import '../../usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignupUseCase implements UseCase<void, SignupRequestEntity> {
  final AuthRepository repository;

  SignupUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignupRequestEntity request) async {
    return await repository.signup(request);
  }
}
