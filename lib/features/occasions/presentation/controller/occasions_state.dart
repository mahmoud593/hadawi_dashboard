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
