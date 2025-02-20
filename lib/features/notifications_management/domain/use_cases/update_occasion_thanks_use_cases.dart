import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/repo/notification_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class UpdateOccasionThanksUseCases{

  NotificationRepo notificationRepo;

  UpdateOccasionThanksUseCases({required this.notificationRepo});

  Future<Either<Faliure, void>> call({
    required String description,
    required String title,
    required bool status,
  }) async {
    return await notificationRepo.updatePaymentThanks(description: description, title: title, status: status);
  }

}