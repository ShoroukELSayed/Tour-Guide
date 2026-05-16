import 'result.dart';
import '../errors/failures.dart';

extension ResultX<T> on Result<T> {
  Future<R> UiHelpers<R>({
    required Future<R> Function(T data) success,
    required Future<R> Function(Failure error) failure,
  }) async {
    if (isSuccess) {
      return await success(data as T);
    } else {
      return await failure(error!);
    }
  }
}
