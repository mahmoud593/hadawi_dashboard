import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/banners/data/banners_model/banners_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

import '../../../../utiles/error_handling/exceptions/exceptions.dart';

class BannersDataSource {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<BannersModel> addBanners({
    required String image,
  }) async {
    final docRef = fireStore.collection('Banners').doc();
    final bannerId = docRef.id;

    BannersModel bannersModel = BannersModel(
      image: image,
      id: bannerId,
    );

    try {
      await docRef.set(bannersModel.toJson());
      return bannersModel;
    } on FireStoreException catch (e) {
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future<List<BannersModel>> getAllBanners() async {
    try {
      final querySnapshot = await fireStore.collection('Banners').get();
      final banners = querySnapshot.docs
          .map((doc) => BannersModel.fromJson(doc.data()))
          .toList();
      return banners;
    } on FireStoreException catch (e) {
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future<Either<Faliure, bool>> deleteBanner(
      {required String bannerId}) async {
    try {
      await fireStore.collection('Banners').doc(bannerId).delete();
      return const Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
