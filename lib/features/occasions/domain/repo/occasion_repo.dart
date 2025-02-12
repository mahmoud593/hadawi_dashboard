import 'package:dartz/dartz.dart';

import '../../../../utiles/error_handling/faliure/faliure.dart';
import '../entities/occastion_entity.dart';

abstract class OccasionRepo {
  Future<Either<Faliure, List<OccasionEntity>>> getOccasions();

  Future<Either<Faliure, List<OccasionEntity>>> filterOccasionsByType(
      {required String occasionType});

  Future<Either<Faliure, List<OccasionEntity>>> filterCompletedOccasions();

  Future<Either<Faliure, List<OccasionEntity>>> filterNotCompletedOccasions();

  Future<Either<Faliure, bool>> editOccasion({
  required  String occasionId,
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
  });

  Future<Either<Faliure, bool>> deleteOccasion({required String occasionId});
}
