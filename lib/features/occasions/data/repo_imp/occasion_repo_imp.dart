import 'package:dartz/dartz.dart';

import '../../../../utiles/error_handling/faliure/faliure.dart';
import '../../domain/entities/occastion_entity.dart';
import '../../domain/repo/occasion_repo.dart';
import '../data_source/occasion_data_source.dart';

class OccasionRepoImp extends OccasionRepo {
  final OccasionDataSource _dataSource = OccasionDataSource();

  @override
  Future<Either<Faliure, List<OccasionEntity>>> getOccasions() async {
    final result = await _dataSource.getAllOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>>
      filterCompletedOccasions() async {
    final result = await _dataSource.filterCompletedOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>>
      filterNotCompletedOccasions() async {
    final result = await _dataSource.filterNotCompletedOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>> filterOccasionsByType(
      {required String occasionType}) async {
    final result =
        await _dataSource.filterOccasionsByType(occasionType: occasionType);
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
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
     String? giftType,}
  ) async {
    try {
      final result = await _dataSource.updateOccasion(
        occasionId: occasionId,
        occasionName: occasionName,
        occasionDate: occasionDate,
        occasionType: occasionType,
        moneyGiftAmount: moneyGiftAmount,
        personName: personName,
        personPhone: personPhone,
        personEmail: personEmail,
        giftName: giftName,
        giftLink: giftLink,
        giftPrice: giftPrice,
        giftType: giftType,
      );
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, bool>> deleteOccasion({required String occasionId}) async{
    try {
      final result = await _dataSource.deleteOccasion(occasionId: occasionId);
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

}
