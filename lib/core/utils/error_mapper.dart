import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../constants/app_strings.dart';

class ErrorMapper {
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is NetworkException) {
      String userMessage;
      if (exception.isNoInternet) {
        userMessage = AppStrings.errorNoInternet;
      } else if (exception.message.contains('timeout')) {
        userMessage = AppStrings.errorConnectionTimeout;
      } else {
        userMessage = AppStrings.errorNetwork;
      }
      return NetworkFailure(
        exception.message,
        userMessage: userMessage,
        isNoInternet: exception.isNoInternet,
      );
    } else if (exception is ServerException) {
      String userMessage = _getServerErrorMessage(exception.statusCode);
      return ServerFailure(
        exception.message,
        userMessage: userMessage,
        statusCode: exception.statusCode,
      );
    } else if (exception is CacheException) {
      return CacheFailure(
        exception.message,
        userMessage: AppStrings.errorCacheFailure,
      );
    } else {
      return UnknownFailure(
        exception.toString(),
        userMessage: AppStrings.errorUnknown,
      );
    }
  }

  static String _getServerErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 304:
        return AppStrings.errorLoadingData;
      case 400:
        return AppStrings.errorBadRequest;
      case 401:
        return AppStrings.errorUnauthorized;
      case 403:
        return AppStrings.errorForbidden;
      case 404:
        return AppStrings.errorNotFound;
      case 500:
        return AppStrings.errorInternalServer;
      case 503:
        return AppStrings.errorServiceUnavailable;
      default:
        if (statusCode != null && statusCode >= 500) {
          return AppStrings.errorServerError;
        } else if (statusCode != null && statusCode >= 400) {
          return AppStrings.errorBadRequest;
        } else {
          return AppStrings.errorServerError;
        }
    }
  }
}
