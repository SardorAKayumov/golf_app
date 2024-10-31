
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf_app/core/domain/entity/request/login_request_entity.dart';
import 'package:golf_app/core/domain/usecase/login_usecase.dart';
import 'package:golf_app/core/error/failures.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(event.loginRequestEntity);
    result.fold(
      (failure) => emit(LoginFailure(failure: failure)),
      (_) => emit(LoginSuccess()),
    );
  }
}
