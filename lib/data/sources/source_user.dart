import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';
import 'package:distro66_app/config/api.dart';
import 'package:distro66_app/config/session.dart';

class SourceUser {
  static final Dio dio = Dio();

  // login
  static Future<bool> login(
    String username,
    String password,
  ) async {
    try {
      final Response response = await dio.post(
        Api.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;
        final token = responseBody['token'];

        if (token != null && token is String && token.isNotEmpty) {
          // Token valid, lakukan tindakan yang sesuai di sini
          Session.saveToken(token);
          DMethod.printTitle(
              'success login - ${Api.login}', response.toString());
          return true;
        }
      }
      // Penanganan kasus lain jika respons tidak sesuai dengan yang diharapkan
      DMethod.printTitle('Failed login or invalid response - ${Api.login}',
          response.toString());
      return false;
    } catch (e) {
      throw Exception('Error Login: $e');
    }
  }
}
