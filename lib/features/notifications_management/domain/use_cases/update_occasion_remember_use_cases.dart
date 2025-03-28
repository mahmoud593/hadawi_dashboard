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
    required bool remind12,
    required bool remind24,
    required bool remind48,
  }) async {
    return await notificationRepo.updatePaymentRemember(description: description, title: title, status: status, remind12: remind12, remind24: remind24, remind48: remind48);
  }

}