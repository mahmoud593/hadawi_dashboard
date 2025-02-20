abstract class PrivacyState {}

class PrivacyInitialState extends PrivacyState {}

class GetPrivacyLoadingState extends PrivacyState {}
class GetPrivacySuccessState extends PrivacyState {}
class GetPrivacyErrorState extends PrivacyState {
  String error;
  GetPrivacyErrorState({required this.error});
}

class UpdatePrivacyLoadingState extends PrivacyState {}
class UpdatePrivacySuccessState extends PrivacyState {}
class UpdatePrivacyErrorState extends PrivacyState {
  String error;
  UpdatePrivacyErrorState({required this.error});
}