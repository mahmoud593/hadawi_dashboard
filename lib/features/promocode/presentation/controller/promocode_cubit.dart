import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hadawi_dathboard/features/promocode/data/repo_imp/promo_code_repo_imp.dart';
import 'package:hadawi_dathboard/features/promocode/domain/entities/code_entity.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'promocode_state.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  PromoCodeCubit() : super(PromoCodeInitial());
  TextEditingController codeController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController maxUseController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  GlobalKey<FormState> bottomSheetFormKey = GlobalKey<FormState>();

  String generateRandomCode({int length = 6}) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    final String code =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();
    codeController.text = code;
    debugPrint("Generated Code: $code");
    emit(GenerateCodeSuccessState());
    return code;
  }

  void setCodeExpirationDate({required DateTime expirationDate}) {
    expirationDateController.text =
        DateFormat('yyyy-MM-dd').format(expirationDate);
    emit(SetExpirationDate());
  }

  Future<void> addPromoCode() async {
    emit(AddPromoCodeLoadingState());
    final result = await PromoCodeRepoImp().addPromoCode(
      code: codeController.text,
      discount: double.parse(discountController.text),
      expireDate: expirationDateController.text,
      maxUsage: int.parse(maxUseController.text),
      used: 0,
      occasions: [],
    );
    result.fold((failure) {
      emit(AddPromoCodeErrorState(message: failure.message));
    }, (promoCode) {
      emit(AddPromoCodeSuccessState(codeEntity: promoCode));
    });
  }

  List<CodeEntity> promoCodes = [];
  Future<void> getPromoCodes() async {
    emit(GetPromoCodesLoadingState());
    final result = await PromoCodeRepoImp().getPromoCodes();
    result.fold((failure) {
      emit(GetPromoCodesErrorState(message: failure.message));
    }, (promoCodesList) {
      promoCodes = promoCodesList;
      emit(GetPromoCodesSuccessState(promoCodes: promoCodesList));
    });
  }

  Future<void> deletePromoCode({required String codeId}) async {
    emit(DeleteCodeLoadingState());
    final result =
    await PromoCodeRepoImp().deletePromoCode(promoCodeId: codeId);
    result.fold((failure) {
      emit(DeleteCodeErrorState(message: failure.message));
    }, (occasion) {
      promoCodes.removeWhere((element) => element.id == codeId);
      emit(DeleteCodeSuccessState(promoCodes: promoCodes));
    });
  }


  void clearControllers() {
    codeController.clear();
    discountController.clear();
    maxUseController.clear();
    expirationDateController.clear();
  }
}
