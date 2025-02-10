import 'package:dartz/dartz.dart';

import '../../../../utiles/error_handling/faliure/faliure.dart';
import '../../domain/entities/occastion_entity.dart';
import '../../domain/repo/occasion_repo.dart';
import '../data_source/occasion_data_source.dart';

class OccasionRepoImp extends OccasionRepo {
  @override
  Future<Either<Faliure, List<OccasionEntity>>> getOccasions() async {
    final result = await OccasionDataSource().getAllOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>> filterCompletedOccasions(
      ) async {
    final result = await OccasionDataSource()
        .filterCompletedOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>>
      filterNotCompletedOccasions() async {
    final result = await OccasionDataSource().filterNotCompletedOccasions();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, List<OccasionEntity>>> filterOccasionsByType(
      {required String occasionType}) async {
    final result = await OccasionDataSource()
        .filterOccasionsByType(occasionType: occasionType);
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
