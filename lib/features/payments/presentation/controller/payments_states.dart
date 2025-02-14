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