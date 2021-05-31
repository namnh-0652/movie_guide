import 'package:dio/dio.dart';

class ServiceGenerator {
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static Dio generate(String baseUrl, List<Interceptor>? inteceptors) {
    final dio = Dio();
    dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = CONNECT_TIMEOUT
      ..receiveTimeout = RECEIVE_TIMEOUT;
    if (inteceptors != null) {
      dio.interceptors..addAll(inteceptors);
    }
    dio.interceptors..add(LogInterceptor());
    return dio;
  }
}
