import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

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
      occasions.forEach((element) {
        if(element.giftPrice<=element.moneyGiftAmount){
          occasionCountClose++;
        }else{
          occasionCountOpen++;
        }
      });
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

}
