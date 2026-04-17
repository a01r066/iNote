import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base class for all domain-layer failures.
/// Used with [dartz.Either] as the Left type.
@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.network({
    @Default('No internet connection') String message,
  }) = NetworkFailure;

  const factory Failure.auth({
    @Default('Authentication failed') String message,
  }) = AuthFailure;

  const factory Failure.cache({
    @Default('Cache error occurred') String message,
  }) = CacheFailure;

  const factory Failure.notFound({
    @Default('Resource not found') String message,
  }) = NotFoundFailure;

  const factory Failure.unknown({
    @Default('An unexpected error occurred') String message,
  }) = UnknownFailure;
}

extension FailureMessage on Failure {
  String get userMessage => when(
        server: (message, _) => message,
        network: (message) => message,
        auth: (message) => message,
        cache: (message) => message,
        notFound: (message) => message,
        unknown: (message) => message,
      );
}
