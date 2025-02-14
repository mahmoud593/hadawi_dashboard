import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class PaymentsRepo {

  Future<Either<Faliure, TaxEntities>> getTaxs();
  Future<Either<Faliure, void>> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required String packageTax,
  });

}