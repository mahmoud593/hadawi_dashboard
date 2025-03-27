import 'dart:io';
import 'package:flutter/foundation.dart' as Uint8List;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/recieved_occastions_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../data/repo_imp/occasion_repo_imp.dart';
import '../../domain/entities/occastion_entity.dart';

part 'occasions_state.dart';

class OccasionsCubit extends Cubit<OccasionsState> {
  OccasionsCubit() : super(OccasionsInitial());

  static OccasionsCubit get(context) => BlocProvider.of(context);


  TextEditingController occasionNameController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController occasionDateController = TextEditingController();
  TextEditingController giftTypeController = TextEditingController();
  TextEditingController giftLinkController = TextEditingController();
  TextEditingController moneyAmountController = TextEditingController();
  TextEditingController giftPriceController = TextEditingController();
  TextEditingController occasionTypeController = TextEditingController();
  TextEditingController giftNameController = TextEditingController();
  TextEditingController personEmailController = TextEditingController();
  TextEditingController personPhoneController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController giftCardController = TextEditingController();
  TextEditingController receivingDateController = TextEditingController();

  TextEditingController finalPriceController = TextEditingController();
String? selectedValue;
  List<OccasionEntity> occasions = [];

  int occasionCountClose = 0;
  int occasionCountOpen = 0;
  Future<void> getOccasions() async {
    occasionCountClose=0;
    occasionCountOpen=0;
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().getOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);

      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> filterNotCompletedOccasions() async {
    occasions.clear();

    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().filterNotCompletedOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint("${occasions.first.moneyGiftAmount}");

      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> filterCompletedOccasions() async {
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().filterCompletedOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint("${occasions.first.moneyGiftAmount}");

      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> filterOccasionsByType({required String occasionType}) async {
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp()
        .filterOccasionsByType(occasionType: occasionType);
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint(occasions.first.giftType);
      debugPrint("{moneyOccasions[0].occasionId}");
      debugPrint(occasions.first.occasionId);
      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> editOccasion({required String occasionId}) async {
    emit(UpdateOccasionsLoadingState());
    final result = await OccasionRepoImp().editOccasion(
      giftType: giftTypeController.text,
      occasionId: occasionId,
      occasionName: occasionNameController.text,
      occasionDate: occasionDateController.text,
      occasionType: occasionTypeController.text,
      moneyGiftAmount: moneyAmountController.text,
      personName: personNameController.text,
      personPhone: personPhoneController.text,
      personEmail: personEmailController.text,
      giftName: giftNameController.text,
      giftLink: giftLinkController.text,
      giftPrice:  giftPriceController.text,
      bankName: bankNameController.text,
      city: cityController.text,
      district: districtController.text,
      ibanNumber: ibanController.text,
      receiverName: receiverNameController.text,
      receiverPhone: receiverPhoneController.text,
      giftCard: giftCardController.text,
      receivingDate: receivingDateController.text,
    );
    result.fold((failure) {
      emit(UpdateOccasionsErrorState(error: failure.message));
    }, (occasion) {
      emit(UpdateOccasionSuccess(occasions: occasion));
    });
  }

  Future<void> deleteOccasion({required String occasionId}) async {
    emit(DeleteOccasionsLoadingState());
    final result =
        await OccasionRepoImp().deleteOccasion(occasionId: occasionId);
    result.fold((failure) {
      emit(DeleteOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.removeWhere((element) => element.occasionId == occasionId);
      emit(DeleteOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> openExerciseLink(String url) async {
    try {
      final Uri uri = Uri.parse(Uri.encodeFull(url)); // Ensure proper encoding

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Open in external browser
        );
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching $url: $e');
    }
  }
  var picker = ImagePicker();

  List<File> imageFiles = []; // For mobile (changed to List)
  List<Uint8List.Uint8List> webImageBytes = []; // For web (changed to List)

  Future<void> pickGiftImage() async {
    emit(PickGiftImageLoadingState());

    // Use pickMultiImage to allow selecting multiple images
    final List<XFile> pickedImages = await picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      if (kIsWeb) {
        // Web: Read bytes for each image
        webImageBytes = [];
        for (var image in pickedImages) {
          final bytes = await image.readAsBytes();
          webImageBytes.add(bytes);
        }
        emit(PickGiftImageSuccessState());
      } else {
        // Mobile: Convert paths to File objects
        imageFiles = pickedImages.map((image) => File(image.path)).toList();
        emit(PickGiftImageSuccessState());
      }
    } else {
      emit(PickGiftImageErrorState());
    }
  }

  Future<List<String>> uploadImage() async {
    emit(UploadGiftImageLoadingState());

    try {
      List<String> downloadUrls = [];

      if (kIsWeb) {
        // Web: Upload each Uint8List
        for (var bytes in webImageBytes) {
          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
              .ref()
              .child('doneOccasions/${DateTime.now().millisecondsSinceEpoch}');
          firebase_storage.UploadTask uploadTask = ref.putData(bytes);
          final snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      } else {
        for (var file in imageFiles) {
          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
              .ref()
              .child('doneOccasions/${DateTime.now().millisecondsSinceEpoch}');
          firebase_storage.UploadTask uploadTask = ref.putFile(file);
          final snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      }

      emit(UploadGiftImageSuccessState());
      return downloadUrls;
    } catch (error) {
      emit(UploadGiftImageErrorState());
      throw Exception("Failed to upload images: $error");
    }
  }

  void clearImage() {
    imageFiles = [];
    webImageBytes = [];
    emit(ClearImageState());
  }

Future<void> addReceivedOccasions({required String occasionId}) async {
     emit(AddReceivedOccasionsLoadingState());
    try {
      final List<String> imageUrls = await uploadImage();
      final result = await OccasionRepoImp().addReceivedOccasions(
        occasionId: occasionId,
        images: imageUrls,
        finalPrice: finalPriceController.text,
      );
      result.fold(
            (failure){
              debugPrint("cubit errorrrrrrrrrrrrrrr ${failure.message}");
              return emit(AddReceivedOccasionsErrorState( error: failure.message));
            },
            (entity) => emit(AddReceivedOccasionsSuccessState()),
      );
    } catch (e) {
      emit(AddReceivedOccasionsErrorState(error:e.toString()));
    }
}

ReceivedOccasionsEntities? receivedOccasions;

Future<void> getReceivedOccasions({ required String occasionId}) async {
    emit(GetReceivedOccasionsLoadingState());
    final result = await OccasionRepoImp().getReceivedOccasions(occasionId: occasionId);
    result.fold((failure) {
      emit(GetReceivedOccasionsErrorState(error: failure.message));
    }, (entity) {
      receivedOccasions = entity;
      emit(GetReceivedOccasionsSuccessState(receivedOccasionsEntities: receivedOccasions!));
    });
}

}
