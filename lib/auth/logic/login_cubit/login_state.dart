part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginIdle extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String errorMessage;
  LoginError(this.errorMessage);
}

final class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);
}
