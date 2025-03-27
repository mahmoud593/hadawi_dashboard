import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/recieved_occastions_entity.dart';

import '../../../../utiles/error_handling/faliure/faliure.dart';
import '../entities/occastion_entity.dart';

abstract class OccasionRepo {
  Future<Either<Faliure, List<OccasionEntity>>> getOccasions();

  Future<Either<Faliure, List<OccasionEntity>>> filterOccasionsByType(
      {required String occasionType});

  Future<Either<Faliure, List<OccasionEntity>>> filterCompletedOccasions();

  Future<Either<Faliure, List<OccasionEntity>>> filterNotCompletedOccasions();

  Future<Either<Faliure, bool>> editOccasion({
    required String occasionId,
    String? occasionName,
    String? occasionDate,
    String? occasionType,
    dynamic moneyGiftAmount,
    String? personName,
    String? personPhone,
    String? personEmail,
    String? giftName,
    String? giftLink,
    dynamic giftPrice,
    String? giftType,
    String bankName,
    String city,
    String district,
    String giftCard,
    String ibanNumber,
    String receiverName,
    String receiverPhone,
    String receivingDate,
  });

  Future<Either<Faliure, bool>> deleteOccasion({required String occasionId});

  Future<Either<Faliure, ReceivedOccasionsEntities>> addReceivedOccasions(
      {required String occasionId,
      required List<String> images,
      required String finalPrice});
  Future<Either<Faliure, ReceivedOccasionsEntities>> getReceivedOccasions({required String occasionId});

  Future<Either<Faliure, bool>> editReceivedOccasions(
      {required String occasionId,
        List<String>? images,
        String? finalPrice});
}
