import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class NotificationRepo {
  Future<Either<Faliure, NotificationsEntities>> getOccasionComplete();

  Future<Either<Faliure, NotificationsEntities>> getPaymentDone();

  Future<Either<Faliure, NotificationsEntities>> getPaymentRemember();

  Future<Either<Faliure, NotificationsEntities>> getPaymentThanks();

  Future<Either<Faliure, void>> updateOccasionComplete({
    required String description,
    required String title,
    required bool status,
  });

  Future<Either<Faliure, void>> updatePaymentDone({
    required String description,
    required String title,
    required bool status,
  });

  Future<Either<Faliure, void>> updatePaymentRemember({
    required String description,
    required String title,
    required bool status,
  });

  Future<Either<Faliure, void>> updatePaymentThanks({
    required String description,
    required String title,
    required bool status,
  });


}