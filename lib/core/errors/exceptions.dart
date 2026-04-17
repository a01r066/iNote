/// Thrown when the server returns an error response.
class ServerException implements Exception {
  const ServerException({this.message = 'Server error occurred', this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Thrown when there is no internet connection.
class NetworkException implements Exception {
  const NetworkException({this.message = 'No internet connection'});

  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when authentication fails.
class AuthException implements Exception {
  const AuthException({this.message = 'Authentication failed'});

  final String message;

  @override
  String toString() => 'AuthException: $message';
}

/// Thrown when local cache read/write fails.
class CacheException implements Exception {
  const CacheException({this.message = 'Cache error occurred'});

  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when a requested resource is not found.
class NotFoundException implements Exception {
  const NotFoundException({this.message = 'Resource not found'});

  final String message;

  @override
  String toString() => 'NotFoundException: $message';
}
