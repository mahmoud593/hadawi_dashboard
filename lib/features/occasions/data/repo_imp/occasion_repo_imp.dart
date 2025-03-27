import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/recieved_occastions_entity.dart';

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
    String? giftType,
    String? bankName,
    String? city,
    String? district,
    String? giftCard,
    String? ibanNumber,
    String? receiverName,
    String? receiverPhone,
    String? receivingDate,
  }) async {
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
        bankName: bankName,
        city: city,
        district: district,
        giftCard: giftCard,
        ibanNumber: ibanNumber,
        receiverName: receiverName,
        receiverPhone: receiverPhone,
        receivingDate: receivingDate,
      );
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, bool>> deleteOccasion(
      {required String occasionId}) async {
    try {
      final result = await _dataSource.deleteOccasion(occasionId: occasionId);
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, ReceivedOccasionsEntities>> addReceivedOccasions({
    required String occasionId,
    required List<String> images,
    required String finalPrice,
  }) async {
    final result = await _dataSource.addReceivedOccasion(
      occasionId: occasionId,
      imagesUrl: images,
      finalPrice: finalPrice,
    );

    return result.fold((failure) {
      debugPrint("errorrrrrrrrrrrrrrr ${failure.message}");
      return Left(failure);
    }, (right) {
      return Right(right);
    });
  }

  @override
  Future<Either<Faliure, bool>> editReceivedOccasions(
      {required String occasionId, List<String>? images, String? finalPrice}) async {
    try {
      final result = await _dataSource.editReceivedOccasions(
        occasionId: occasionId,
        imagesUrl: images,
        finalPrice: finalPrice,
      );
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, ReceivedOccasionsEntities>> getReceivedOccasions({required String occasionId})async {
    final result = await _dataSource.getReceivedOccasions(occasionId: occasionId);
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
