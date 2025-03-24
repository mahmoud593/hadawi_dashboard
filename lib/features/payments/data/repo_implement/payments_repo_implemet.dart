import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/payments/data/data_source/payments_data_source.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/features/payments/domain/repo/payments_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class PaymentsRepoImplement extends PaymentsRepo{

  PaymentsDataSource paymentsDataSource;

  PaymentsRepoImplement({required this.paymentsDataSource});

  @override
  Future<Either<Faliure, TaxEntities>> getTaxs() async {

    try{
      return Right(await paymentsDataSource.getTaxs());
    }on FireStoreException catch(e){
      return Left(FireStoreFaliure.fromMessage(e));
    }


  }

  @override
  Future<Either<Faliure, void>> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required List<String> packageTax,
    required List<String> occasionType,
    required List<String> pakaging_image
  }) async{
    try{
      return Right(await paymentsDataSource.updateTaxs(
          deliveryTax: deliveryTax,
          serviceTax: serviceTax,
          pakaging_image: pakaging_image,
          occasionType: occasionType,
          packageTax: packageTax
      ));
    }on FireStoreException catch(e){
    return Left(FireStoreFaliure.fromMessage(e));
    }
  }

}