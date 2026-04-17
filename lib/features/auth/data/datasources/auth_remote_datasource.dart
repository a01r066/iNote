import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

part 'auth_remote_datasource.g.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get authStateChanges;
  Future<UserModel> signInWithEmail({required String email, required String password});
  Future<void> signOut();
  Future<void> sendPasswordResetEmail({required String email});
  Future<UserModel?> getCurrentUser();
  Future<UserModel> updateProfile({String? fullName, String? phone, String? photoUrl});
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  CollectionReference get _usersCollection =>
      firestore.collection(ApiConstants.usersCollection);

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) throw const AuthException(message: 'Sign in failed');

      // Update last login
      await _usersCollection.doc(user.uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      final doc = await _usersCollection.doc(user.uid).get();
      if (!doc.exists) {
        // Create user document if it doesn't exist
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? email,
          fullName: user.displayName ?? '',
          photoUrl: user.photoURL,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        );
        await _usersCollection.doc(user.uid).set(newUser.toFirestore());
        return newUser;
      }

      return UserModel.fromFirestore(doc);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Authentication failed');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw const AuthException(message: 'Sign out failed');
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Failed to send reset email');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _usersCollection.doc(user.uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw const CacheException(message: 'Failed to get user data');
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? fullName,
    String? phone,
    String? photoUrl,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw const AuthException(message: 'No authenticated user');

    final updates = <String, dynamic>{};
    if (fullName != null) updates['fullName'] = fullName;
    if (phone != null) updates['phone'] = phone;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;

    try {
      await _usersCollection.doc(user.uid).update(updates);
      if (fullName != null) await user.updateDisplayName(fullName);
      if (photoUrl != null) await user.updatePhotoURL(photoUrl);

      final doc = await _usersCollection.doc(user.uid).get();
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw const ServerException(message: 'Failed to update profile');
    }
  }
}
