import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/auth/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/email_pass_entity.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/user_entity.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

import '../data_source/auth_data_source.dart';

class UserRepoImp extends UserRepo {
  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Future<Either<Faliure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _authDataSource.login(email: email, password: password);
      return const Right(null);
    } on FireStoreException catch (e) {
      return Left(
          Faliure(message: e.firebaseException.message ?? "Login failed"));
    } catch (e) {
      return Left(Faliure(message: "Unexpected error occurred."));
    }
  }

  @override
  Future<Either<Faliure, void>> logout() async {
    try {
      await _authDataSource.logout();
      return const Right(null);
    } on FireStoreException catch (e) {
      return Left(
          Faliure(message: e.firebaseException.message ?? "Logout failed"));
    } catch (e) {
      return Left(Faliure(message: "Unexpected error occurred during logout."));
    }
  }

  @override
  Future<Either<Faliure, void>> saveUserData({
    required String email,
    required String name,
    required String uId,
  }) async {
    try {
      await _authDataSource.saveUserData(
          email: email, name: name, uId: uId);
      return const Right(null);
    } on FireStoreException catch (e) {
      return Left(Faliure(
          message: e.firebaseException.message ?? "Failed to save user data"));
    } catch (e) {
      return Left(Faliure(
          message: "Unexpected error occurred while saving user data."));
    }
  }

  @override
  Future<Either<Faliure, UserEntity>> getUserData({required String uId}) async {
    try {
      final userData = await _authDataSource.getUserData(uId: uId);
      return Right(userData);
    } on FireStoreException catch (e) {
      return Left(Faliure(
          message: e.firebaseException.message ?? "Failed to fetch user data"));
    } catch (e) {
      return Left(Faliure(
          message: "Unexpected error occurred while fetching user data."));
    }
  }

  @override
  Future<Either<Faliure, EmailPassEntity>> loginWithEmailPass(
      {required String email, required String password}) async{
    try {
      final response = await _authDataSource.loginWithEmailPass(
          email: email, password: password);
      return Right(response!);
    } catch (e) {
      return Left(Faliure(
          message: "Invalid email or password"));
    }
  }
}
