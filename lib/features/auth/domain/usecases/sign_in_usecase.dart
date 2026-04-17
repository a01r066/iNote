import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

part 'sign_in_usecase.freezed.dart';

@freezed
class SignInParams with _$SignInParams {
  const factory SignInParams({
    required String email,
    required String password,
  }) = _SignInParams;
}

class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return _repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
