import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/features/payments/domain/repo/payments_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class TaxUseCases {

  PaymentsRepo paymentsRepo;

  TaxUseCases({required this.paymentsRepo});

  Future<Either<Faliure, TaxEntities>> getTaxs() async{
    return paymentsRepo.getTaxs();
  }

}