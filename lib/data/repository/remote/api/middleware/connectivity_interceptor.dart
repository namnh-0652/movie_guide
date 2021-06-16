import 'package:dio/dio.dart';
import 'package:movieguide/core/platform/network_info.dart';

class ConnectivityInterceptor extends InterceptorsWrapper {
  final NetworkInfo networkInfo;
  ConnectivityInterceptor({required this.networkInfo});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!(await networkInfo.isConnected)) {
      return handler.reject(DioError(
        requestOptions: options,
        type: DioErrorType.sendTimeout,
      ));
    }
    return super.onRequest(options, handler);
  }
}
