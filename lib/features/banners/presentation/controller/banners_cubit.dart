import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hadawi_dathboard/features/banners/data/banners_repo_imp/banners_repo_imp.dart';
import 'package:hadawi_dathboard/features/banners/domain/banners_entity/banners_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit() : super(BannersInitial());

  var picker = ImagePicker();

  File? imageFile; // For mobile
  Uint8List? webImageBytes; // For web

  Future<void> pickBannerImage() async {
    emit(PickImageLoadingState());

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        webImageBytes = await pickedImage.readAsBytes();
        emit(PickImageSuccessState());
      } else {
        imageFile = File(pickedImage.path);
        emit(PickImageSuccessState());
      }
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<String> uploadImage() async {
    emit(UploadImageLoadingState());

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Banners/${DateTime.now().millisecondsSinceEpoch}');

      firebase_storage.UploadTask uploadTask;

      if (kIsWeb) {
        // Web: Upload from Uint8List
        uploadTask = ref.putData(webImageBytes!);
      } else {
        // Mobile: Upload from File
        uploadTask = ref.putFile(imageFile!);
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      emit(UploadImageSuccessState());
      return downloadUrl;
    } catch (error) {
      emit(UploadImageErrorState());
      throw Exception("Failed to upload image: $error");
    }
  }

  Future<void> addBanner() async {
    emit(AddBannersLoadingState());
    try {
      final imageUrl = await uploadImage();
      final result = await BannersRepoImp().addBanner(image: imageUrl);
      result.fold(
        (failure) {
          emit(AddBannersErrorState(error: failure.message));
        },
        (banners) {
          emit(AddBannersSuccessState());
        },
      );
    } catch (e) {
      emit(AddBannersErrorState(error: e.toString()));
    }
  }

  List<BannersEntity> banners = [];

  Future<void> getBanners() async {
    emit(GetBannersLoadingState());
    try {
      final result = await BannersRepoImp().getBanners();
      result.fold(
        (l) {},
        (r) {
          banners = r;
          emit(GetBannersSuccessState());
        },
      );
    } catch (e) {
      emit(GetBannersErrorState());
    }
  }

  Future<void> deleteBanner({required String bannerId}) async {
    emit(DeleteBannerLoadingState());
    final result =
    await BannersRepoImp().deleteBanner(bannerId: bannerId);
    result.fold((failure) {
      emit(DeleteBannerErrorState(error: failure.message));
    }, (banner) {
      banners.removeWhere((element) => element.id == bannerId);
      emit(DeleteBannerSuccessState(banners: banners));
    });
  }

}
