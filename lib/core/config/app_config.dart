enum Flavor { dev, prod }

class AppConfig {
  AppConfig._({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableCrashlytics,
  });

  final Flavor flavor;
  final String appName;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableCrashlytics;

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static bool get isDev => _instance.flavor == Flavor.dev;
  static bool get isProd => _instance.flavor == Flavor.prod;

  static void initialize(Flavor flavor) {
    _instance = switch (flavor) {
      Flavor.dev => AppConfig._(
          flavor: Flavor.dev,
          appName: 'Sales App DEV',
          apiBaseUrl: 'https://api-dev.yourcompany.com',
          enableLogging: true,
          enableCrashlytics: false,
        ),
      Flavor.prod => AppConfig._(
          flavor: Flavor.prod,
          appName: 'Sales App',
          apiBaseUrl: 'https://api.yourcompany.com',
          enableLogging: false,
          enableCrashlytics: true,
        ),
    };
  }
}
