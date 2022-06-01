import 'error.dart';

abstract class Resource<T> {
  void whenWithResult({
    Function(T data)? success,
    Function(Error)? error,
  }) {
    if (this is Success<T>) {
      if (success != null) success((this as Success<T>).data);
    } else if (this is Error) {
      if (error != null) error(this as Error<T>);
    }
  }

  static Success<T> success<T>({required T data}) {
    return Success(data: data);
  }

  static Error<T> error<T>({required BaseException exception}) {
    return Error<T>(exception: exception);
  }
}

class Success<T> extends Resource<T> {
  final T data;

  Success({required this.data});
}

class Error<T> extends Resource<T> {
  final BaseException exception;

  Error({required this.exception});
}
