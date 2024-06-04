import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather/auth/data/providers/auth_provider.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;

  LoginCubit({required this.authProvider}) : super(LoginIdle());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final _ = await authProvider.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on DioException catch (error) {
      emit(LoginError(error.message ?? error.toString()));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
