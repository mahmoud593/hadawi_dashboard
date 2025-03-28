import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class SendNotitifcationUseCases{

  UserRepo userRepo;

  SendNotitifcationUseCases({required this.userRepo});

  Future<Either<Faliure, void>> call({required String message, required String userId}) async {
    return await userRepo.sendNotification(message: message, userId: userId);
  }

}