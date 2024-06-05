import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather/core/data/repositories/token_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final TokenRepository tokenRepository;
  SessionCubit({required this.tokenRepository}) : super(SessionIdle());

  Future<void> initState() async {
    try {
      final authToken = await tokenRepository.getToken();
      if (authToken != null) {
        emit(SessionLoggedIn());
      } else {
        emit(SessionLoggedOut());
      }
    } catch (error) {
      emit(SessionLoggedOut());
    }
  }

  Future<void> login({
    required String authToken,
  }) async {
    try {
      await tokenRepository.persistToken(authToken);
      emit(SessionLoggedIn());
    } catch (error) {
      emit(SessionLoggedOut());
    }
  }

  Future<void> logout() async {
    try {
      await tokenRepository.deleteAll();
      emit(SessionLoggedOut());
    } catch (error) {
      emit(SessionLoggedOut());
    }
  }
}
