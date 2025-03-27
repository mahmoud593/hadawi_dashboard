import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/occasions/data/models/received_occasions_model.dart';
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
        'bankName': bankName,
        'city': city,
        'district': district,
        'giftCard': giftCard,
        'ibanNumber': ibanNumber,
        'receiverName': receiverName,
        'receiverPhone': receiverPhone,
        'receivingDate': receivingDate
      });

      return const Right(true);
    } catch (e) {
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

  Future<Either<Faliure, ReceivedOccasionsModel>> addReceivedOccasion({
    required String occasionId,
    required List<String> imagesUrl,
    required String finalPrice,
  }) async {
    try {
      if (occasionId.isEmpty || finalPrice.isEmpty || imagesUrl.isEmpty) {
        return Left(Faliure(message: 'Invalid input: Fields cannot be empty'));
      }
      final data = {
        'occasionId': occasionId,
        'imagesUrl': imagesUrl,
        'finalPrice': finalPrice,
        'timestamp': FieldValue.serverTimestamp(),
      };

      final docRef = fireStore
          .collection('Occasions')
          .doc(occasionId)
          .collection('receivedOccasions')
          .doc(occasionId);
      await docRef.set(data);
      final model = ReceivedOccasionsModel(
        id: occasionId,
        imageUrls: imagesUrl,
        finalPrice: finalPrice,
      );

      return Right(model);
    } catch (e) {
      return Left(Faliure(message: 'Failed to add received occasion: $e'));
    }
  }

  Future<Either<Faliure, bool>> editReceivedOccasions({
    required String occasionId,
    List<String>? imagesUrl,
    String? finalPrice,
  }) async {
    try {
      final docRef = fireStore
          .collection('Occasions')
          .doc(occasionId)
          .collection('receivedOccasions')
          .doc(occasionId);
      await docRef.update({
        'imagesUrl': imagesUrl,
        'finalPrice': finalPrice,
      });
      return const Right(true);
    } catch (e) {
      return Left(Faliure(message: 'Failed to update received occasion: $e'));
    }
  }

  Future<ReceivedOccasionsModel> getReceivedOccasions(
      {required String occasionId}) async {
    try {
      final querySnapshot = await  fireStore.collection('Occasions')
          .doc(occasionId)
          .collection('receivedOccasions')
          .doc(occasionId).get();

      final occasions = ReceivedOccasionsModel.fromJson(querySnapshot.data()!);

      return occasions;
    } catch (e) {
      throw Exception("Failed to fetch occasions: $e");
    }
  }
}
