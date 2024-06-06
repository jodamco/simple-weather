import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather/core/data/repositories/token_repository.dart';
import 'package:simple_weather/core/logic/session/session_cubit.dart';

import 'session_cubit_test.mocks.dart';

@GenerateMocks([TokenRepository])
void main() {
  late SessionCubit sessionCubit;
  late MockTokenRepository mockTokenRepository;

  setUp(() {
    mockTokenRepository = MockTokenRepository();
    sessionCubit = SessionCubit(tokenRepository: mockTokenRepository);
  });

  group('SessionCubit', () {
    const testToken = 'test_token';

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedIn] when initState finds a token',
      build: () {
        when(mockTokenRepository.getToken()).thenAnswer((_) async => testToken);
        return sessionCubit;
      },
      act: (cubit) => cubit.initState(),
      expect: () => [
        isA<SessionLoggedIn>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedOut] when initState does not find a token',
      build: () {
        when(mockTokenRepository.getToken()).thenAnswer((_) async => null);
        return sessionCubit;
      },
      act: (cubit) => cubit.initState(),
      expect: () => [
        isA<SessionLoggedOut>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedOut] when initState encounters an error',
      build: () {
        when(mockTokenRepository.getToken()).thenThrow(Exception('error'));
        return sessionCubit;
      },
      act: (cubit) => cubit.initState(),
      expect: () => [
        isA<SessionLoggedOut>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedIn] when login is successful',
      build: () {
        when(mockTokenRepository.persistToken(testToken))
            .thenAnswer((_) async {});
        return sessionCubit;
      },
      act: (cubit) => cubit.login(authToken: testToken),
      expect: () => [
        isA<SessionLoggedIn>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedOut] when login encounters an error',
      build: () {
        when(mockTokenRepository.persistToken(testToken))
            .thenThrow(Exception('error'));
        return sessionCubit;
      },
      act: (cubit) => cubit.login(authToken: testToken),
      expect: () => [
        isA<SessionLoggedOut>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedOut] when logout is successful',
      build: () {
        when(mockTokenRepository.deleteToken()).thenAnswer((_) async {});
        return sessionCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<SessionLoggedOut>(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits [SessionLoggedOut] when logout encounters an error',
      build: () {
        when(mockTokenRepository.deleteToken()).thenThrow(Exception('error'));
        return sessionCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<SessionLoggedOut>(),
      ],
    );
  });
}
