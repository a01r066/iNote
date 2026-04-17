class AppConstants {
  AppConstants._();

  // App
  static const String appName = 'Sales App';

  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Pagination
  static const int defaultPageSize = 20;

  // Secure Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';

  // Shared Preferences Keys
  static const String themeKey = 'app_theme';
  static const String onboardingKey = 'onboarding_completed';
}
