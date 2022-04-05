import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';
import '../../localizations/base_localization.dart';

enum ErrorResultType {
  connectTimeout,
  sendTimeout,
  receiveTimeout,
  cancel,
  response,
  noInternetConnection,
  other
}

class ErrorResult {
  String errorMessage;
  ErrorResultType type;
  ErrorResult({required this.errorMessage, required this.type});
}

class CustomErrorHandler {
  const CustomErrorHandler();

  ErrorResult getErrorMessage(dynamic exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.cancel:
          return ErrorResult(
              errorMessage:
                  BaseLocalization.currentLocalization().cancelApiRequestError,
              type: ErrorResultType.cancel);

        case DioErrorType.connectTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .connectionTimeoutApiRequestError,
              type: ErrorResultType.connectTimeout);

        case DioErrorType.other:
          return ErrorResult(
              errorMessage:
                  BaseLocalization.currentLocalization().noInternetConnection,
              type: ErrorResultType.noInternetConnection);

        case DioErrorType.receiveTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .receiveTimeoutApiRequestError,
              type: ErrorResultType.receiveTimeout);
        case DioErrorType.response:
          return ErrorResult(
              errorMessage: sprintf(
                  BaseLocalization.currentLocalization()
                      .invalidStatusApiRequestError,
                  [exception.response!.statusCode]),
              type: ErrorResultType.response);
        case DioErrorType.sendTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .connectionTimeoutApiRequestError,
              type: ErrorResultType.sendTimeout);
      }
    } else {
      return ErrorResult(
          errorMessage: exception.toString(), type: ErrorResultType.other);
    }
  }
}
