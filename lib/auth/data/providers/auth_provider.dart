class AuthProvider {
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    return Future.delayed(const Duration(seconds: 3), () => true);
  }
}
