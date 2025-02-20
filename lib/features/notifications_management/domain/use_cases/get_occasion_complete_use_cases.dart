import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/repo/notification_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class GetOccasionCompleteUseCases{

  NotificationRepo notificationRepo;

  GetOccasionCompleteUseCases({required this.notificationRepo});

  Future<Either<Faliure, NotificationsEntities>> call() async {
    return await notificationRepo.getOccasionComplete();
  }

}