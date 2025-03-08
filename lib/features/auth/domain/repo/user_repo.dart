import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/email_pass_entity.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/user_entity.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class UserRepo {
  Future<Either<Faliure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Faliure, void>> saveUserData({
    required String email,
    required String name,
    required String uId,
  });

  Future<Either<Faliure, void>> logout();

  Future<Either<Faliure, UserEntity>> getUserData({required String uId});

  Future<Either<Faliure,EmailPassEntity>> loginWithEmailPass({required String email, required String password});
}
