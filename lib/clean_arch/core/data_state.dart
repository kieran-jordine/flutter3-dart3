import 'package:dio/dio.dart';

// TODO: look at dart-3 class types
abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

// TODO: look at calling parent constructors
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data): super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(DioException error): super(error: error);
}