import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hadawi_dathboard/features/payments/data/models/balance_model.dart';
import 'package:hadawi_dathboard/features/payments/data/models/payment_model.dart';
import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/update_taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
    required List<String> packageTax,
    required List<String> pakaging_image,
  })async{
    emit(UpdateTaxsLoadingState());
    var result = await updateTaxsUseCases.updateTaxs(
        deliveryTax: deliveryTax,
        serviceTax: serviceTax,
        pakaging_image: pakaging_image,
        packageTax: packageTax
    );
    result.fold(
            (l) => emit(UpdateTaxsErrorState(error:  l.message)),
            (r) {
          emit(UpdateTaxsSuccessState());
        }
    );
  }


  var picker = ImagePicker();

  File? imageFile;
  File? imageFile2;
  Uint8List? webImageBytes;
  Uint8List? webImageBytes2;

  Future<void> pickBannerImage() async {
    emit(PickImageLoadingState());

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        webImageBytes = await pickedImage.readAsBytes();
        emit(PickImageSuccessState());
      } else {
        imageFile = File(pickedImage.path);
        emit(PickImageSuccessState());
      }
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<void> pickBannerImage2() async {
    emit(PickImageLoadingState2());

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        webImageBytes2 = await pickedImage.readAsBytes();
        emit(PickImageSuccessState2());
      } else {
        imageFile2 = File(pickedImage.path);
        emit(PickImageSuccessState2());
      }
    } else {
      emit(PickImageErrorState2());
    }
  }

  String downloadUrl ='';

  Future<String> uploadImage() async {
    emit(UploadImageLoadingState());
    try {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'gifts/1//${Uri.dataFromBytes(webImageBytes!).pathSegments.last}')
          .putData(webImageBytes!).then((value) {
        value.ref.getDownloadURL().then((value) {
          debugPrint('Upload Success');
          downloadUrl = value;
          // if (kIsWeb) {
          //   // Web: Upload from Uint8List
          //   uploadTask = ref.putData(webImageBytes!);
          // } else {
          //   // Mobile: Upload from File
          //   uploadTask = ref.putFile(imageFile!);
          // }
        });
      });

      emit(UploadImageSuccessState());
      return downloadUrl;
    } catch (error) {
      emit(UploadImageErrorState());
      throw Exception("Failed to upload image: $error");
    }
  }


  String downloadUrl2 ='';
  Future<String> uploadImage2() async {
    emit(UploadImageLoadingState2());
    try {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'gifts/2//${Uri.dataFromBytes(webImageBytes2!).pathSegments.last}')
          .putData(webImageBytes2!).then((value) {
        value.ref.getDownloadURL().then((value) {
          debugPrint('Upload Success');
          downloadUrl2 = value;
        });
      });
      emit(UploadImageSuccessState2());
      return downloadUrl2;
    } catch (error) {
      emit(UploadImageErrorState2());
      throw Exception("Failed to upload image2: $error");
    }
  }

  List<PaymentModel> paymentsData = [];

  Future<void> getPayments()async{
    paymentsData=[];
    emit(GetPaymentsLoadingState());
    try{
      FirebaseFirestore.instance.collection('payments').get().then((value) {

        value.docs.forEach((element) {
          paymentsData.add(PaymentModel.fromJson(element.data()));
        });
        emit(GetPaymentsSuccessState());
      });
    }catch(e){

      print('Error in get payments ${e.toString()}');
      emit(GetPaymentsErrorState());
    }


    }

    TextEditingController searchPaymentsController = TextEditingController();
    void filterPayments({required String filter}) {
      if(filter.isEmpty){
        print('here');
        getPayments();
      }else{

        print('Filter ${filter}');
        Set<PaymentModel> items = paymentsData.where((item)=> item.occasionName!.toLowerCase().
        contains(filter.toLowerCase())).toSet();
        print(items);
        print(paymentsData[0].occasionName);

        paymentsData = items.toList();
        emit(FilterPaymentsSuccessState());
      }

    }

  TextEditingController searchBalanceController = TextEditingController();

  void filterBalance({required String filter}) {
    if(filter.isEmpty){
      getBalance();
    }else{

      Set<BalanceModel> items = balanceData.where((item)=> item.accountNumber!.toLowerCase().
      contains(filter.toLowerCase())).toSet();
      print(balanceData[0].accountNumber);

      balanceData = items.toList();
      emit(FilterPaymentsSuccessState());
    }

  }



  Future<void> createBalance({
    required String userName,
    required String phone,
    required String accountNumber,
    required String iban,
    required String paymentAccount,
    required String paymentDescription,
})async{
    emit(CreateBalanceLoadingState());
    BalanceModel balanceModel = BalanceModel(
        userName: userName, phone: phone,
        accountNumber: accountNumber, iban: iban,
        paymentAccount: paymentAccount, paymentDescription: paymentDescription,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        balanceId: ''
    );
    try{
      FirebaseFirestore.instance.collection('balance').add(balanceModel.toJson()).then((value) async{
         print('Balance Added');
         FirebaseFirestore.instance.collection('balance').doc(value.id).update({'balanceId': value.id});
        emit(CreateBalanceSuccessState());
      });
    }catch(e){

      print('Error in create balance ${e.toString()}');
      emit(CreateBalanceErrorState());
    }
  }


  List<BalanceModel> balanceData = [];

  Future<void> getBalance()async{
    balanceData=[];
    emit(GetBalanceLoadingState());

    try{
      final snapshot = await FirebaseFirestore.instance.collection('balance').get();

      // Convert documents to a list of BalanceModel
      final balances = snapshot.docs.map((doc) => BalanceModel.fromJson(doc.data())).toList();

      balanceData = balances; // Update the list
      print('Balance Data ${balanceData.length}');
     emit(GetBalanceSuccessState());

    }catch(e){

      print('Error in create balance ${e.toString()}');
      emit(GetBalanceErrorState());
    }
  }


  Future<void> deleteBalance({required String balanceId})async{
    emit(DeleteBalanceLoadingState());

    try{
      final snapshot = await FirebaseFirestore.instance.collection('balance').doc(balanceId).delete();

      await getBalance();
      print('Balance Data ${balanceData.length}');
      emit(DeleteBalanceSuccessState());

    }catch(e){

      print('Error in create balance ${e.toString()}');
      emit(DeleteBalanceErrorState());
    }
  }

  Future<void> deletePayment({required String paymentId})async{
    emit(DeletePaymentLoadingState());

    try{
      final snapshot = await FirebaseFirestore.instance.collection('payments').doc(paymentId).delete();

      await getPayments();
      print('Payment Data ${balanceData.length}');
      emit(DeletePaymentSuccessState());

    }catch(e){

      print('Error in create balance ${e.toString()}');
      emit(DeletePaymentErrorState());
    }
  }



}