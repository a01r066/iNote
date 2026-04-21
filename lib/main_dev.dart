import 'bootstrap.dart';
import 'core/config/app_config.dart' as app_config;
import 'package:flutter/services.dart';

// TODO: Replace with your actual Firebase DEV project options
// Generated via: flutterfire configure --project=your-dev-project
import 'firebase_options_dev.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
  );

  app_config.AppConfig.initialize(app_config.Flavor.dev);
  bootstrap(DefaultFirebaseOptions.currentPlatform);

  // Temporary: Remove when firebase_options_dev.dart is configured
  // throw UnimplementedError(
  //   'Configure Firebase DEV project:\n'
  //   '1. Create a Firebase project for DEV\n'
  //   '2. Run: flutterfire configure --project=YOUR_DEV_PROJECT_ID\n'
  //   '3. Rename the generated firebase_options.dart to firebase_options_dev.dart\n'
  //   '4. Uncomment the import and bootstrap call above',
  // );
}
