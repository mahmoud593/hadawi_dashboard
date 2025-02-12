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
