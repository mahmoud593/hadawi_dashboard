import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class UserRepo {
  Future<Either<Faliure, List<UserModel>>> getAllUsers();
}