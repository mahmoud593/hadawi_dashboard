import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class UserRepo {
  Future<Either<Faliure, List<UserModel>>> getAllUsers({required bool desending});

  Future<Either<Faliure, void>> sendNotification({
    required String message,
    required String userId,
  });

  Future<Either<Faliure, void>> deleteUser({
    required String userId,
    required String message
  });

  Future<Either<Faliure, void>> blockUser({
    required String userId,
    required String message
  });

}