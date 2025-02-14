import 'package:bloc/bloc.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/update_taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';

class PaymentsCubit extends Cubit<PaymentsStates>{

  PaymentsCubit(this.taxUseCases,this.updateTaxsUseCases) : super(InitialPaymentsState());

  TaxUseCases taxUseCases;
  UpdateTaxsUseCases updateTaxsUseCases;

  TaxEntities ?taxEntities;

  Future<void> getTaxs()async{
    emit(GetTaxsLoadingState());
    var result = await taxUseCases.getTaxs();
    result.fold(
            (l) => emit(GetTaxsErrorState(error:  l.message)),
            (r) {
              taxEntities = r;
              emit(GetTaxsSuccessState());
            }
    );
  }

  Future<void> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required String packageTax,
  })async{
    emit(UpdateTaxsLoadingState());
    var result = await updateTaxsUseCases.updateTaxs(
        deliveryTax: deliveryTax,
        serviceTax: serviceTax,
        packageTax: packageTax
    );
    result.fold(
            (l) => emit(UpdateTaxsErrorState(error:  l.message)),
            (r) {
          emit(UpdateTaxsSuccessState());
        }
    );
  }


}