import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/promocode/domain/entities/code_entity.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class PromoCodeRepo {
  Future<Either<Faliure, CodeEntity>> addPromoCode({
    required String code,
    required double discount,
    required String expireDate,
    required int maxUsage,
    required int used,
    required List<String> occasions,
  });

  Future<Either<Faliure, List<CodeEntity>>> getPromoCodes();

  Future<Either<Faliure, bool>> deletePromoCode({required String promoCodeId});
}
