import 'package:flutter/services.dart';

import 'bootstrap.dart';
import 'core/config/app_config.dart' as app_config;

// TODO: Replace with your actual Firebase PROD project options
// Generated via: flutterfire configure --project=your-prod-project
import 'firebase_options_prod.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
  );
  app_config.AppConfig.initialize(app_config.Flavor.prod);
  bootstrap(DefaultFirebaseOptions.currentPlatform);

  // Temporary: Remove when firebase_options_prod.dart is configured
  // throw UnimplementedError(
  //   'Configure Firebase PROD project:\n'
  //   '1. Create a Firebase project for PROD\n'
  //   '2. Run: flutterfire configure --project=YOUR_PROD_PROJECT_ID\n'
  //   '3. Rename the generated firebase_options.dart to firebase_options_prod.dart\n'
  //   '4. Uncomment the import and bootstrap call above',
  // );
}
