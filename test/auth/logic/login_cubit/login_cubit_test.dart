import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather/auth/data/providers/auth_provider.dart';
import 'package:simple_weather/auth/logic/login_cubit/login_cubit.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([AuthProvider])
void main() {
  late MockAuthProvider mockAuthProvider;
  late LoginCubit loginCubit;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    loginCubit = LoginCubit(authProvider: mockAuthProvider);
  });

  group('LoginCubit success cases', () {
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () {
        when(
          mockAuthProvider.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => true);

        return loginCubit;
      },
      act: (cubit) => cubit.login(
        email: 'test@example.com',
        password: 'password',
      ),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginSuccess>().having(
          (p0) => p0.token,
          "Auth token from cubit",
          "test@example.com",
        ),
      ],
    );
  });

  group('LoginCubit error cases', () {
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginError] when login fails with ProviderException',
      build: () {
        when(
          mockAuthProvider.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenThrow(
          ProviderException('Provider error'),
        );
        return loginCubit;
      },
      act: (cubit) => cubit.login(
        email: 'test@example.com',
        password: 'password',
      ),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having(
          (p0) => p0.errorMessage,
          "Error message from cubit",
          "Provider error",
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginError] when login fails with a generic error',
      build: () {
        when(
          mockAuthProvider.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenThrow(
          Exception('Generic error'),
        );
        return loginCubit;
      },
      act: (cubit) => cubit.login(
        email: 'test@example.com',
        password: 'password',
      ),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having(
          (p0) => p0.errorMessage,
          "Error message from cubit",
          "Exception: Generic error",
        ),
      ],
    );
  });
}
