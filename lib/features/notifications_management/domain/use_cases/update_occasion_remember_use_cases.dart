import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/repo/notification_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class UpdateOccasionRememberUseCases{

  NotificationRepo notificationRepo;

  UpdateOccasionRememberUseCases({required this.notificationRepo});

  Future<Either<Faliure, void>> call({
    required String description,
    required String title,
    required bool status,
  }) async {
    return await notificationRepo.updatePaymentRemember(description: description, title: title, status: status);
  }

}