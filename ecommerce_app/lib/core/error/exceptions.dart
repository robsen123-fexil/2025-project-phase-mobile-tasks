class ServerExceptions implements Exception {
  final String message;
  ServerExceptions([this.message = 'An error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheExceptions implements Exception {
  final String message;
  CacheExceptions([this.message = 'Cache error']);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);

  @override
  String toString() => 'NetworkException: $message';
}
