part of 'occasions_cubit.dart';

@immutable
sealed class OccasionsState {}

final class OccasionsInitial extends OccasionsState {}
final class GetOccasionsLoadingState extends OccasionsState {}
final class GetOccasionsErrorState extends OccasionsState {
  final String error;
  GetOccasionsErrorState({required this.error});
}
final class GetOccasionsSuccessState extends OccasionsState {
  final List<OccasionEntity> occasions;
  GetOccasionsSuccessState({required this.occasions});
}
final class DeleteOccasionsLoadingState extends OccasionsState {}
final class DeleteOccasionsErrorState extends OccasionsState {
  final String error;
  DeleteOccasionsErrorState({required this.error});
}
final class DeleteOccasionsSuccessState extends OccasionsState {
  final List<OccasionEntity> occasions;
  DeleteOccasionsSuccessState({required this.occasions});
}

final class UpdateOccasionsLoadingState extends OccasionsState {}
final class UpdateOccasionsErrorState extends OccasionsState {
  final String error;
  UpdateOccasionsErrorState({required this.error});
}
final class UpdateOccasionSuccess extends OccasionsState {
  final bool occasions;
  UpdateOccasionSuccess({required this.occasions});
}
final class PickGiftImageLoadingState extends OccasionsState {}
final class PickGiftImageSuccessState extends OccasionsState {}
final class PickGiftImageErrorState extends OccasionsState {}


final class UploadGiftImageLoadingState extends OccasionsState {}
final class UploadGiftImageSuccessState extends OccasionsState {}
final class UploadGiftImageErrorState extends OccasionsState {}

final class ClearImageState extends OccasionsState {}
final class AddReceivedOccasionsLoadingState extends OccasionsState {}
final class AddReceivedOccasionsSuccessState extends OccasionsState {}
final class AddReceivedOccasionsErrorState extends OccasionsState {
  final String error;
  AddReceivedOccasionsErrorState({required this.error});
}
final class GetReceivedOccasionsLoadingState extends OccasionsState {}
final class GetReceivedOccasionsSuccessState extends OccasionsState {
  final ReceivedOccasionsEntities receivedOccasionsEntities;
  GetReceivedOccasionsSuccessState({required this.receivedOccasionsEntities});
}
final class GetReceivedOccasionsErrorState extends OccasionsState {
  final String error;
  GetReceivedOccasionsErrorState({required this.error});
}