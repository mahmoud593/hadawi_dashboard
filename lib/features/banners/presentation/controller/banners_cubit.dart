import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

    TextEditingController bannerNameController = TextEditingController();
    GlobalKey<FormState>bannerFormKey = GlobalKey<FormState>();

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

 void clearImage() {
    imageFile = null;
    webImageBytes = null;
    emit(ClearImageState());
  }

  Future<void> addBanner() async {
    emit(AddBannersLoadingState());
    try {
      final imageUrl = await uploadImage();
      final result = await BannersRepoImp().addBanner(image: imageUrl, bannerName: bannerNameController.text);
      result.fold(
        (failure) {
          emit(AddBannersErrorState(error: failure.message));
        },
        (banners) {
          bannersList.add(banners);
          emit(AddBannersSuccessState());
        },
      );
    } catch (e) {
      emit(AddBannersErrorState(error: e.toString()));
    }
  }

  List<BannersEntity> bannersList = [];

  Future<void> getBanners() async {
    emit(GetBannersLoadingState());
    try {
      final result = await BannersRepoImp().getBanners();
      result.fold(
        (l) {},
        (r) {
          bannersList = r;
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
      bannersList.removeWhere((element) => element.id == bannerId);
      emit(DeleteBannerSuccessState(banners: bannersList));
    });
  }

  Future<void> editBanner({required String bannerId,String? image}) async {
    emit(EditBannerLoadingState());
    final result = await BannersRepoImp().editBanner(
      bannerId: bannerId,
      bannerName: bannerNameController.text,
      bannerImage: webImageBytes != null ? await uploadImage() : image,
    );
    result.fold((failure) {
      emit(EditBannerErrorState(error: failure.message));
    }, (banner) {
      emit(EditBannerSuccess(banner: banner));
    });
  }

}
