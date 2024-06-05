import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRepository {
  static TokenRepository? _instance;

  factory TokenRepository() =>
      _instance ??= TokenRepository._(const FlutterSecureStorage());

  TokenRepository._(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAll() async {
    await _storage.delete(key: _tokenKey);
  }
}
