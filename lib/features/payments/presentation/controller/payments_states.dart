abstract class PaymentsStates {}

class InitialPaymentsState extends PaymentsStates {}

class GetTaxsLoadingState extends PaymentsStates {}
class GetTaxsSuccessState extends PaymentsStates {}
class GetTaxsErrorState extends PaymentsStates {
  String error;
  GetTaxsErrorState({required this.error});
}

class UpdateTaxsLoadingState extends PaymentsStates {}
class UpdateTaxsSuccessState extends PaymentsStates {}
class UpdateTaxsErrorState extends PaymentsStates {
  String error;
  UpdateTaxsErrorState({required this.error});
}

class PickImageLoadingState extends PaymentsStates {}
class PickImageSuccessState extends PaymentsStates {}
class PickImageErrorState extends PaymentsStates {
}

class PickImageLoadingState2 extends PaymentsStates {}
class PickImageSuccessState2 extends PaymentsStates {}
class PickImageErrorState2 extends PaymentsStates {}

class UploadImageLoadingState2 extends PaymentsStates {}
class UploadImageSuccessState2 extends PaymentsStates {}
class UploadImageErrorState2 extends PaymentsStates {}

class UploadImageLoadingState extends PaymentsStates {}
class UploadImageSuccessState extends PaymentsStates {}
class UploadImageErrorState extends PaymentsStates {}

class GetPaymentsLoadingState extends PaymentsStates {}
class GetPaymentsSuccessState extends PaymentsStates {}
class GetPaymentsErrorState extends PaymentsStates {}

class FilterPaymentsLoadingState extends PaymentsStates {}
class FilterPaymentsSuccessState extends PaymentsStates {}
class FilterPaymentsErrorState extends PaymentsStates {}


class GetBalanceLoadingState extends PaymentsStates {}
class GetBalanceSuccessState extends PaymentsStates {}
class GetBalanceErrorState extends PaymentsStates {}


class CreateBalanceLoadingState extends PaymentsStates {}
class CreateBalanceSuccessState extends PaymentsStates {}
class CreateBalanceErrorState extends PaymentsStates {}

class DeleteBalanceLoadingState extends PaymentsStates {}
class DeleteBalanceSuccessState extends PaymentsStates {}
class DeleteBalanceErrorState extends PaymentsStates {}

class DeletePaymentLoadingState extends PaymentsStates {}
class DeletePaymentSuccessState extends PaymentsStates {}
class DeletePaymentErrorState extends PaymentsStates {}

class FilterBalanceLoadingState extends PaymentsStates {}
class FilterBalanceSuccessState extends PaymentsStates {}
class FilterBalanceErrorState extends PaymentsStates {}