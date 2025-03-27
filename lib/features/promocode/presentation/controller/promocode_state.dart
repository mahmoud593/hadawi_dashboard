part of 'promocode_cubit.dart';

@immutable
sealed class PromoCodeState {}

final class PromoCodeInitial extends PromoCodeState {}
final class ValidateCodeSuccessState extends PromoCodeState {}
final class ValidateCodeFailureState extends PromoCodeState {
  final String message;

  ValidateCodeFailureState(this.message);
}
final class GenerateCodeSuccessState extends PromoCodeState {}
final class SetExpirationDate extends PromoCodeState {}
final class GetPromoCodesLoadingState extends PromoCodeState {}
final class GetPromoCodesErrorState extends PromoCodeState {
  final String message;

  GetPromoCodesErrorState({required this.message});
}
final class GetPromoCodesSuccessState extends PromoCodeState {
  final List<CodeEntity> promoCodes;

  GetPromoCodesSuccessState({required this.promoCodes});
}
final class AddPromoCodeLoadingState extends PromoCodeState {}
final class AddPromoCodeSuccessState extends PromoCodeState {
  final CodeEntity codeEntity;

  AddPromoCodeSuccessState({required this.codeEntity});
}
final class AddPromoCodeErrorState extends PromoCodeState {
  final String message;

  AddPromoCodeErrorState({required this.message});
}

final class DeleteCodeLoadingState extends PromoCodeState {}
final class DeleteCodeSuccessState extends PromoCodeState {
  final List<CodeEntity> promoCodes;

  DeleteCodeSuccessState({required this.promoCodes});
}
final class DeleteCodeErrorState extends PromoCodeState {
  final String message;

  DeleteCodeErrorState({required this.message});
}

