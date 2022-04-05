import 'package:dio/dio.dart';
import '../api/entities/common.dart';
import '../core/logging.dart';

extension FutureHelpers<T> on Future<T> {
  Future<T> logError() => catchError((error) async {
        log(error: error);
        throw error;
      });
}
