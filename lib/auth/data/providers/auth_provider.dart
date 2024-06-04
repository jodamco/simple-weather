import 'package:dio/dio.dart';

class AuthProvider {
  Future<Response<dynamic>> login({
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => Response(
        data: true,
        requestOptions: RequestOptions(),
      ),
    );
  }
}
