import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../usecase/usecase.dart';
import '../entity/request/login_request_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<void, LoginRequestEntity> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoginRequestEntity request) async {
    return await repository.login(request);
  }
}
