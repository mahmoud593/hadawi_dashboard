import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class BlockUserUseCases{

  UserRepo userRepo;

  BlockUserUseCases({required this.userRepo});

  Future<Either<Faliure, void>> call({ required String userId,required String message}) async {
    return await userRepo.blockUser(userId: userId,message: message);
  }

}