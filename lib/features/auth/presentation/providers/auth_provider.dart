import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inote_app/core/errors/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

// ─── Auth State Stream (for router redirect) ──────────────────────────────────

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

// ─── Current User Entity ──────────────────────────────────────────────────────

@riverpod
Future<UserEntity?> currentUser(CurrentUserRef ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final result = await repository.getCurrentUser();
  return result.fold((_) => null, (user) => user);
}

// ─── Auth Notifier State ──────────────────────────────────────────────────────

@freezed
class AuthNotifierState with _$AuthNotifierState {
  const factory AuthNotifierState.initial() = _Initial;
  const factory AuthNotifierState.loading() = _Loading;
  const factory AuthNotifierState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthNotifierState.unauthenticated() = _Unauthenticated;
  const factory AuthNotifierState.error(String message) = _Error;
}

// ─── Auth Notifier ────────────────────────────────────────────────────────────

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthNotifierState build() => const AuthNotifierState.initial();

  SignInUseCase get _signInUseCase =>
      SignInUseCase(ref.read(authRepositoryProvider));

  SignOutUseCase get _signOutUseCase =>
      SignOutUseCase(ref.read(authRepositoryProvider));

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthNotifierState.loading();

    final result = await _signInUseCase(
      SignInParams(email: email, password: password),
    );

    state = result.fold(
      (failure) => AuthNotifierState.error(failure.userMessage),
      (user) => AuthNotifierState.authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthNotifierState.loading();
    final result = await _signOutUseCase();
    state = result.fold(
      (failure) => AuthNotifierState.error(failure.userMessage),
      (_) => const AuthNotifierState.unauthenticated(),
    );
  }

  void clearError() {
    if (state is _Error) {
      state = const AuthNotifierState.initial();
    }
  }
}
