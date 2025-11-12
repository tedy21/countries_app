class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, [this.statusCode]);
}

class NetworkException implements Exception {
  final String message;
  final bool isNoInternet;

  NetworkException(this.message, {this.isNoInternet = false});
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}
