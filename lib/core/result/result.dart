import 'package:city_tales/core/errors/failures.dart';

class Result<T> {
  final T? data;
  final Failure? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => data != null;
}