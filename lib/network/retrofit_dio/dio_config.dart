
import 'package:dio/dio.dart';

final dio = Dio();

void configure() {
  dio.options.sendTimeout = const Duration(seconds: 5);
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.responseType = ResponseType.json;
  dio.options.headers = {
    'Authentication': 'Bearer jwt-token',
  };
  dio.options.extra = {
    'extra': 'extra'
  };
  final interceptor = InterceptorsWrapper(
    onRequest: (options, handler) {
      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (dioException, handler) {
      return handler.next(dioException);
    }
  );
  dio.interceptors.add(interceptor);
}



