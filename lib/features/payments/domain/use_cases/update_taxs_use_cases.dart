import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/features/payments/domain/repo/payments_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class UpdateTaxsUseCases {

  PaymentsRepo paymentsRepo;

  UpdateTaxsUseCases({required this.paymentsRepo});

  Future<Either<Faliure, void>> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required List<String> pakaging_image,
    required List<String> occasionType,
    required List<String> packageTax,
  }) async{
    return paymentsRepo.updateTaxs(
        deliveryTax: deliveryTax,
        serviceTax: serviceTax,
        occasionType: occasionType,
        pakaging_image: pakaging_image,
        packageTax: packageTax
    );
  }

}