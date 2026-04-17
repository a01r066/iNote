import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  @override
  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _dataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _dataSource.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final model = await _dataSource.getCurrentUser();
      return Right(model?.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    String? fullName,
    String? phone,
    String? photoUrl,
  }) async {
    try {
      final model = await _dataSource.updateProfile(
        fullName: fullName,
        phone: phone,
        photoUrl: photoUrl,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
