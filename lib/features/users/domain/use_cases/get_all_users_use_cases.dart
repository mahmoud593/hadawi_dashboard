import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class GetAllUsersUseCases{

  UserRepo userRepo;

  GetAllUsersUseCases({required this.userRepo});

  Future<Either<Faliure, List<UserModel>>> call() async {
    return await userRepo.getAllUsers();
  }

}