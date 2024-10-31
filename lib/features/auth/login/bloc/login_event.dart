part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final LoginRequestEntity loginRequestEntity;

  LoginSubmitted({required this.loginRequestEntity});
}