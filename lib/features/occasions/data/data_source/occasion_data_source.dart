import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<OccasionModel>> filterOccasionsByType({required String occasionType}) async {
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

}
