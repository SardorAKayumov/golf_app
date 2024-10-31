import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../usecase/usecase.dart';
import '../repository/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  RefreshTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.refreshToken();
  }
}