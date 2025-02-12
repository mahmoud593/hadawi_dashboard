import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../utiles/error_handling/faliure/faliure.dart';
import '../models/occasion_model.dart';

class OccasionDataSource {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<List<OccasionModel>> getAllOccasions() async {
    try {
      final querySnapshot = await fireStore.collection('Occasions').get();

      final occasions = querySnapshot.docs
          .map((doc) => OccasionModel.fromJson(doc.data()))
          .toList();

      return occasions;
    } catch (e) {
      throw Exception("Failed to fetch occasions: $e");
    }
  }

  Future<List<OccasionModel>> filterOccasionsByType(
      {required String occasionType}) async {
    try {
      final querySnapshot = await fireStore
          .collection('Occasions')
          .where('giftType', isEqualTo: occasionType)
          .get();

      final occasions = querySnapshot.docs
          .map((doc) => OccasionModel.fromJson(doc.data()))
          .toList();

      return occasions;
    } catch (e) {
      throw Exception("Failed to fetch occasions: $e");
    }
  }

  Future<List<OccasionModel>> filterCompletedOccasions() async {
    try {
      final querySnapshot = await fireStore
          .collection('Occasions')
          .where('moneyGiftAmount', isEqualTo: 0)
          .get();

      final occasions = querySnapshot.docs
          .map((doc) => OccasionModel.fromJson(doc.data()))
          .toList();

      return occasions;
    } catch (e) {
      throw Exception("Failed to fetch occasions: $e");
    }
  }

  Future<List<OccasionModel>> filterNotCompletedOccasions() async {
    try {
      final querySnapshot = await fireStore
          .collection('Occasions')
          .where('moneyGiftAmount', isNotEqualTo: 0)
          .get();

      final occasions = querySnapshot.docs
          .map((doc) => OccasionModel.fromJson(doc.data()))
          .toList();

      return occasions;
    } catch (e) {
      throw Exception("Failed to fetch occasions: $e");
    }
  }

  Future<Either<Faliure, bool>> updateOccasion({
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
  }) async {
    try {
      await fireStore.collection('Occasions').doc(occasionId).update({
        'occasionName': occasionName,
        'occasionDate': occasionDate,
        'occasionType': occasionType,
        'moneyGiftAmount': moneyGiftAmount,
        'personName': personName,
        'personPhone': personPhone,
        'personEmail': personEmail,
        'giftName': giftName,
        'giftLink': giftLink,
        'giftPrice': giftPrice,
        'giftType': giftType,
      });

      return const Right(true);
    } catch (e) {
      // throw Exception("Failed to update occasion: $e");
      return Left(Faliure(message: e.toString()));
    }
  }

  Future<Either<Faliure, bool>> deleteOccasion(
      {required String occasionId}) async {
    try {
      await fireStore.collection('Occasions').doc(occasionId).delete();
      return const Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
