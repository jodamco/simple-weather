import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/auth/data/providers/auth_provider.dart';

void main() {
  group('AuthProvider', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('login returns true for valid credentials', () async {
      const email = 'test@example.com';
      const password = 'password';

      final response = await authProvider.login(
        email: email,
        password: password,
      );

      expect(response, true);
    });
  });
}
