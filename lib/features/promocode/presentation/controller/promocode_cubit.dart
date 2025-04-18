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
  GlobalKey<FormState> editBottomSheetFormKey = GlobalKey<FormState>();

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

  bool validateCode({required String value}) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      emit(ValidateCodeFailureState('الكود لا يمكن أن يكون فارغًا'));
      return false;
    }
    emit(ValidateCodeSuccessState());
    return true;
  }

  void setCodeExpirationDate({required DateTime expirationDate}) {
    expirationDateController.text =
        DateFormat('yyyy-MM-dd').format(expirationDate);
    emit(SetExpirationDate());
  }
  String? validateExpirationDate() {
    if (expirationDateController.text == null || expirationDateController.text.isEmpty) {
      return 'يرجى اختيار تاريخ انتهاء الكود';
    }
    try {
      final selectedDate = DateTime.parse(expirationDateController.text);
      final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

      if (selectedDate.isBefore(today)) {
        return 'لا يمكن أن يكون تاريخ انتهاء الكود قبل اليوم الحالي';
      }
      return null;
    } catch (e) {
      return 'تاريخ غير صالح';
    }
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

  Future<void> editPromoCode({
    required String codeId,
    String? code,
    double? discount,
    String? expireDate,
    int? maxUsage,
  }) async {
    emit(EditCodeLoadingState());
    final result = await PromoCodeRepoImp().editPromoCodeData(
      promoCodeId: codeId,
      code: codeController.text,
      discount: double.parse(discountController.text),
      expireDate: expirationDateController.text,
      maxUsage: int.parse(maxUseController.text),
    );
    result.fold((failure) {
      emit(EditCodeErrorState(message: failure.message));
    }, (occasion) {
      emit(EditCodeSuccessState());
    });
  }

  void clearControllers() {
    codeController.clear();
    discountController.clear();
    maxUseController.clear();
    expirationDateController.clear();
  }
}
