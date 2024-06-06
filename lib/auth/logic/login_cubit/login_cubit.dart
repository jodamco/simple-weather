import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather/auth/data/providers/auth_provider.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;

  LoginCubit({required this.authProvider}) : super(LoginIdle());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      final _ = await authProvider.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(email));
    } on ProviderException catch (error) {
      emit(LoginError(error.message));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
