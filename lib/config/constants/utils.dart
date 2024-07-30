import 'package:dio/dio.dart';
import 'package:test_app/config/constants/environment.dart';

class Utils{

  static Dio getDio(){
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        receiveDataWhenStatusError: true,
      )
    );
    return dio;
  }

}