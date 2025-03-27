part of 'banners_cubit.dart';

@immutable
sealed class BannersState {}

final class BannersInitial extends BannersState {}
final class PickImageLoadingState extends BannersState {}
final class PickImageSuccessState extends BannersState {}
final class PickImageErrorState extends BannersState {}
final class ClearImageState extends BannersState {}
final class UploadImageLoadingState extends BannersState {}
final class UploadImageSuccessState extends BannersState {}
final class UploadImageErrorState extends BannersState {}
final class AddBannersLoadingState extends BannersState {}
final class AddBannersSuccessState extends BannersState {}
final class AddBannersErrorState extends BannersState {
  final String error;
  AddBannersErrorState({required this.error});
}
final class GetBannersLoadingState extends BannersState {}
final class GetBannersSuccessState extends BannersState {}
final class GetBannersErrorState extends BannersState {}
final class DeleteBannerLoadingState extends BannersState {}
final class DeleteBannerErrorState extends BannersState {
  final String error;
  DeleteBannerErrorState({required this.error});
}
final class DeleteBannerSuccessState extends BannersState {
  final List<BannersEntity> banners;
  DeleteBannerSuccessState({required this.banners});

}

final class EditBannerLoadingState extends BannersState {}
final class EditBannerErrorState extends BannersState {
  final String error;
  EditBannerErrorState({required this.error});
}
final class EditBannerSuccess extends BannersState {
  final bool banner;
  EditBannerSuccess({required this.banner});

}
