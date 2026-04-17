import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';

Future<void> bootstrap(FirebaseOptions firebaseOptions) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Lock orientation to portrait
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Status bar style
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );

      // Initialize Firebase
      await Firebase.initializeApp(options: firebaseOptions);

      // Run app
      runApp(
        ProviderScope(
          observers: [
            if (AppConfig.isDev) _AppObserver(),
          ],
          child: const App(),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint('Unhandled error: $error');
      debugPrint('Stack trace: $stackTrace');
      // TODO: Add Crashlytics reporting for prod
    },
  );
}

class _AppObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('[Riverpod] ${provider.name ?? provider.runtimeType}: $newValue');
  }
}
