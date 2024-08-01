import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:test_app/config/constants/environment.dart';

class Utils{

  static Dio getDio(){
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.plain
      )
    );
    return dio;
  }

  static String intToPrice(int price){
    final formatCurrency = NumberFormat.simpleCurrency();

    return formatCurrency.format(price);
  }

}