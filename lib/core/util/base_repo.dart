import 'package:dio/dio.dart';

import 'error.dart';
import 'resource.dart';

abstract class BaseRepository {
  Future<Resource<T>> networkOnlyCall<T>(
      {required Future<Resource<T>> Function() networkCall,
      Resource<T>? Function(dynamic E)? specificErrorHandler}) async {
    try {
      return await networkCall();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      if (e is DioError) {
        print(e.message);
        if (e.response != null) {
          print(e.response!.toString());
          return Resource.error(
              exception: BaseException(message: e.response!.toString()));
        }
      }
      return _errorHandler(e, specificErrorHandler);
    }
  }

  Future<Resource<T>> cacheOnlyCall<T>(
      {required Future<Resource<T>> Function() cacheCall,
      Resource<T>? Function(dynamic E)? specificErrorHandler}) async {
    try {
      return await cacheCall();
    } catch (e) {
      return _errorHandler(e, specificErrorHandler);
    }
  }

  Resource<T> _errorHandler<T>(
      dynamic e, Resource<T>? Function(dynamic E)? specificErrorHandler) {
    if (specificErrorHandler != null) {
      final spesficError = specificErrorHandler.call(e);
      if (spesficError != null) return spesficError;
    }
    if (e is BaseException) {
      return Resource.error(exception: e);
    }
    return Resource.error<T>(
        exception: BaseException(message: "Unknown Error"));
  }
}
