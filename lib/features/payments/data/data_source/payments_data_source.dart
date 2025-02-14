import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadawi_dathboard/features/payments/data/models/tax_models.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';

abstract class PaymentsDataSource{
  
  Future<TaxModels> getTaxs();
  Future<void> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required String packageTax,
  });

} 

class PaymentsDataSourceImplement extends PaymentsDataSource{
  
  
  @override
  Future<TaxModels> getTaxs()async{
    
    try{
      var res = await FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K').get();
      return TaxModels.fromJson(res.data()!);
    }on FirebaseException catch(e){
      throw FireStoreException(firebaseException:  e);
    }

  }

  @override
  Future<void> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required String packageTax,
  })async {
    try{

      await FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K').update({
        'delivery_tax': deliveryTax,
        'packaging_tax': packageTax,
        'service_tax': serviceTax,
      });

    }on FirebaseException catch(e){
      throw FireStoreException(firebaseException:  e);
    }
  }

}