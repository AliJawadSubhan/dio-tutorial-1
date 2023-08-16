import 'package:dio/dio.dart';
import 'package:dio_course/client/Logging/dio_logger.dart';

import '../model/user_model.dart';

class DioClient {
  final _baseUrl = 'https://reqres.in/api';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  )..interceptors.add(Logging());
  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get('$_baseUrl/users/$id');
      print('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }
}
