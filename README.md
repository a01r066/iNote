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
1. Configure Firebase: `flutterfire configure` for dev and prod projects
2. Run flavorizr: `dart run flutter_flavorizr -p <processors>`
3. Run code gen: `dart run build_runner build --delete-conflicting-outputs`
4. Implement Orders and Customers data/repository layers
5. Add the `Inter` font to pubspec if desired