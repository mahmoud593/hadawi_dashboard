import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/banners/data/data_source/banners_data_source.dart';
import 'package:hadawi_dathboard/features/banners/domain/banners_entity/banners_entity.dart';
import 'package:hadawi_dathboard/features/banners/domain/banners_repo/banners_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class BannersRepoImp extends BannersRepo {
  @override
  Future<Either<Faliure, BannersEntity>> addBanner({required String image, required String bannerName}) async{

final result = await BannersDataSource().addBanners(image: image, bannerName: bannerName);
try{
  return Right(result);
}catch(e){
  return Left(Faliure(message: e.toString()));
}
  }

  @override
  Future<Either<Faliure, List<BannersEntity>>> getBanners() async{
   final result=await BannersDataSource().getAllBanners();
    try{
      return Right(result);
    }catch(e){
      return Left(Faliure(message: e.toString()));
  }}

  @override
  Future<Either<Faliure, bool>> deleteBanner({required String bannerId}) async{
 final result =await BannersDataSource().deleteBanner(bannerId: bannerId);
    try{
      return result;
    }catch(e){
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, bool>> editBanner({required String bannerId, String? bannerImage, String? bannerName}) async{
    try {
      final result = await BannersDataSource().editBanner(bannerId: bannerId,bannerName: bannerName,bannerImage: bannerImage);
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

}
