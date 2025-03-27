import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

import '../banners_entity/banners_entity.dart';

abstract class BannersRepo{

  Future<Either<Faliure, BannersEntity>> addBanner({required String image, required String bannerName});
  Future<Either<Faliure, List<BannersEntity>>> getBanners();
  Future<Either<Faliure, bool>> deleteBanner({required String bannerId});
  Future<Either<Faliure, bool>> editBanner({required String bannerId, String? bannerImage, String? bannerName});

}