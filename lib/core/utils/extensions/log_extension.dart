import 'dart:developer' as developer;

extension LogExtension on Object {
  void log([String? tag]) {
    developer.log(
      toString(),
      name: tag ?? runtimeType.toString(),
    );
  }
}
