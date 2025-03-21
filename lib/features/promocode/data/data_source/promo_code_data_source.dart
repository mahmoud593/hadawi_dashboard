import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/promocode/data/model/code_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

import '../../../../utiles/error_handling/exceptions/exceptions.dart';

class PromoCodeDataSource {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<CodeModel> addPromoCode({
    required String code,
    required double discount,
    required String expireDate,
    required int maxUsage,
    required int used,
    required List<String> occasions,
  }) async {
    try {
      final docRef = fireStore.collection('PromoCodes').doc();
      final promoCodeId = docRef.id;

      CodeModel codeModel = CodeModel(
        code: code,
        discount: discount,
        used: used,
        expiryDate: expireDate,
        maxUsage: maxUsage,
        id: promoCodeId,
        occasions: occasions,
      );
      await docRef.set(codeModel.toJson());
      return codeModel;
    } on FireStoreException catch (e) {
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future<List<CodeModel>> getPromoCodes() async {
    try {
      final querySnapshot = await fireStore.collection('PromoCodes').get();
      final codes = querySnapshot.docs
          .map((doc) => CodeModel.fromJson(doc.data()))
          .toList();
      return codes;
    } on FireStoreException catch (e) {
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future< bool> deletePromoCode(
      {required String promoCodeId}) async {
    try {
      await fireStore.collection('PromoCodes').doc(promoCodeId).delete();
      return true;
    } on FireStoreException catch (e) {
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }
}
