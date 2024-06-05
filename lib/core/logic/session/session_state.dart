part of 'session_cubit.dart';

@immutable
sealed class SessionState {}

final class SessionIdle extends SessionState {}

final class SessionLoggedIn extends SessionState {}

final class SessionLoggedOut extends SessionState {}
