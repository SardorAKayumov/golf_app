part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final Failure failure;
  LoginFailure({required this.failure});
}