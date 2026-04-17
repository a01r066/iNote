import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Returns the current Firebase [User] stream.
  Stream<User?> get authStateChanges;

  /// Signs in with email and password.
  /// Returns [UserEntity] on success or [Failure] on error.
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<Either<Failure, Unit>> signOut();

  /// Sends a password reset email.
  Future<Either<Failure, Unit>> sendPasswordResetEmail({required String email});

  /// Returns the currently authenticated [UserEntity] or null.
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Updates the user's profile.
  Future<Either<Failure, UserEntity>> updateProfile({
    String? fullName,
    String? phone,
    String? photoUrl,
  });
}
