import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/promocode/data/data_source/promo_code_data_source.dart';
import 'package:hadawi_dathboard/features/promocode/domain/entities/code_entity.dart';
import 'package:hadawi_dathboard/features/promocode/domain/repo/promocode_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class PromoCodeRepoImp extends PromoCodeRepo {
  final PromoCodeDataSource _promoCodeDataSource = PromoCodeDataSource();

  @override
  Future<Either<Faliure, List<CodeEntity>>> getPromoCodes() async {
    final result = await _promoCodeDataSource.getPromoCodes();
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, bool>> deletePromoCode(
      {required String promoCodeId}) async {
    try {
      final result =
          await _promoCodeDataSource.deletePromoCode(promoCodeId: promoCodeId);
      return Right(true);
    } catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, CodeEntity>> addPromoCode(
      {required String code,
      required int discount,
      required String expireDate,
      required int maxUsage,
      required int used,
        required List<String> occasions,
      }) async {
    final result = await _promoCodeDataSource.addPromoCode(
        code: code,
        discount: discount,
        expireDate: expireDate,
        maxUsage: maxUsage,
        used: used,
        occasions: occasions);
    try {
      return Right(result);
    } on Exception catch (e) {
      return Left(Faliure(message: e.toString()));
    }
  }
}
