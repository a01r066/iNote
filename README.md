# inote_app

---
name: iNote
description: Flutter sales management app scaffold — stack, architecture, and module details
type: project
---

**Stack:**
- State: `hooks_riverpod` + `riverpod_annotation` + `freezed`
- Backend: Firebase (Firestore, Auth, Storage) — separate DEV and PROD projects
- Networking: Dio + PrettyDioLogger + AuthInterceptor
- Storage: `flutter_secure_storage` (tokens), `shared_preferences`
- Routing: `go_router` with ShellRoute + bottom nav
- Connectivity: `connectivity_plus`
- Charts: `fl_chart`
- Flavors: `flutter_flavorizr` (dev/prod)
- Error handling: `dartz` Either + Failure sealed classes (freezed)

**Why:** User is a Flutter mobile developer building a production-grade sales management app.

**How to apply:** Follow the same clean architecture pattern (domain/data/presentation) when adding new features. Use Riverpod providers instead of get_it for DI.

**Modules scaffolded:** Auth (full), Products (full), Orders (entity + page), Customers (entity + page), Dashboard (KPI cards + chart)

**Next steps needed:**
# Install FlutterFire CLI if needed: `dart pub global activate flutterfire_cli`
1. Configure Firebase: `flutterfire configure` for dev and prod projects
   - Dev: `flutterfire configure --project=inotedev-29330 --out=lib/firebase_options_dev.dart --android-app-id=store.inoteapp.inoteapp.dev --ios-bundle-id=store.inoteapp.inoteapp.dev`
   - Prod: `flutterfire configure --project=inoteprod --out=lib/firebase_options_prod.dart --android-app-id=store.inoteapp.inoteapp --ios-bundle-id=store.inoteapp.inoteapp`
2. Run flavorizr: `dart run flutter_flavorizr -p android:buildGradle,android:androidManifest,ios:xcconfig,flutter:flavors,flutter:app`
3. Run code gen: `dart run build_runner build --delete-conflicting-outputs`
4. Implement Orders and Customers data/repository layers
5. Add the `Inter` font to pubspec if desired

**Steps to Get Running:**
1. Install dependencies
   `flutter pub get`
2. Configure Firebase (both projects)
   # Install FlutterFire CLI if needed
   `dart pub global activate flutterfire_cli`

# DEV project
`flutterfire configure --project=YOUR_DEV_PROJECT_ID --out=lib/firebase_options_dev.dart`

# PROD project
`flutterfire configure --project=YOUR_PROD_PROJECT_ID --out=lib/firebase_options_prod.dart`
3. Run flavorizr to wire up native flavor configs
   `dart run flutter_flavorizr -p android:buildGradle,android:androidManifest,ios:xcconfig,flutter:flavors,flutter:app`
4. Run code generation
   `dart run build_runner build --delete-conflicting-outputs`
5. Run the app
   `flutter run -t lib/main_dev.dart --flavor dev`
   `flutter run -t lib/main_prod.dart --flavor prod`