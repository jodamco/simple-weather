import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather/core/data/repositories/token_repository.dart';

import 'token_repository_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late TokenRepository tokenRepository;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    tokenRepository = TokenRepository(
      storageStrategy: mockFlutterSecureStorage,
    );
  });

  tearDown(() {
    TokenRepository.instance = null;
  });

  const testToken = 'test_token';

  test('hasToken returns true when token is present', () async {
    when(mockFlutterSecureStorage.read(
      key: anyNamed('key'),
    )).thenAnswer((_) async => testToken);

    final result = await tokenRepository.hasToken();

    expect(result, true);
    verify(mockFlutterSecureStorage.read(key: anyNamed('key'))).called(1);
  });

  test('hasToken returns false when token is absent', () async {
    when(mockFlutterSecureStorage.read(key: anyNamed('key')))
        .thenAnswer((_) async => null);

    final result = await tokenRepository.hasToken();

    expect(result, false);
    verify(mockFlutterSecureStorage.read(key: anyNamed('key'))).called(1);
  });

  test('deleteToken calls SecureStorage delete', () async {
    when(mockFlutterSecureStorage.delete(key: anyNamed('key')))
        .thenAnswer((_) async => {});

    await tokenRepository.deleteToken();

    verify(mockFlutterSecureStorage.delete(key: anyNamed('key'))).called(1);
  });

  test('getToken returns token when token is present', () async {
    when(mockFlutterSecureStorage.read(key: anyNamed('key')))
        .thenAnswer((_) async => testToken);

    final result = await tokenRepository.getToken();

    expect(result, testToken);
    verify(mockFlutterSecureStorage.read(key: anyNamed('key'))).called(1);
  });

  test('getToken returns null when token is absent', () async {
    when(mockFlutterSecureStorage.read(key: anyNamed('key')))
        .thenAnswer((_) async => null);

    final result = await tokenRepository.getToken();

    expect(result, null);
    verify(mockFlutterSecureStorage.read(key: anyNamed('key'))).called(1);
  });

  test('persistToken saves the token', () async {
    when(mockFlutterSecureStorage.write(
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenAnswer((_) async => {});

    await tokenRepository.persistToken(testToken);

    verify(
      mockFlutterSecureStorage.write(
        key: anyNamed('key'),
        value: testToken,
      ),
    ).called(1);
  });
}
