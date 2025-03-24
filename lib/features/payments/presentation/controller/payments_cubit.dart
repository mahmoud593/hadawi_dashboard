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
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
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
            (l) {
              print('hhjfhd ${l.message}');
              emit(GetTaxsErrorState(error:  l.message));
            },
            (r) {
              print('hhjfhd ${r}');
              taxEntities = r;
              emit(GetTaxsSuccessState());
            }
    );
  }

  Future<void> updateTaxs({
    required String deliveryTax,
    required String serviceTax,
    required List<String> packageTax,
    required List<Uint8List> pakaging_image,
    required List<String> occasionType,
  })async{
    emit(UpdateTaxsLoadingState());
    String image1 = '';
    String image2 = '';
    if(pakaging_image != []){
      if(webImageBytes1 != null){
        image1 = await uploadPackagingImage1();
      }else{
        image1 = taxEntities!.pakaging_image[0];
      }
      if(webImageBytes2 != null){
        image2 = await uploadPackagingImage2();
      }else{
        image2 = taxEntities!.pakaging_image[1];
      }
    }

    var result = await updateTaxsUseCases.updateTaxs(
        deliveryTax: deliveryTax,
        occasionType: occasionType,
        serviceTax: serviceTax,
        pakaging_image: [image1,image2],
        packageTax: packageTax
    );
    result.fold(
            (l) => emit(UpdateTaxsErrorState(error:  l.message)),
            (r) {
          emit(UpdateTaxsSuccessState());
        }
    );
  }

  /// upload packaging image

  var picker1 = ImagePicker();

  File? imageFile1; // For mobile
  Uint8List? webImageBytes1; // For web

  Future<void> pickPackagingImage1() async {
    emit(PickImageLoadingState());

    final pickedImage = await picker1.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        webImageBytes1 = await pickedImage.readAsBytes();
        emit(PickImageLoadingState());
      } else {
        imageFile1 = File(pickedImage.path);
        emit(PickImageSuccessState());
      }
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<String> uploadPackagingImage1() async {
    emit(UploadImageLoadingState());

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('packaging/1/${DateTime.now().millisecondsSinceEpoch}');

      firebase_storage.UploadTask uploadTask;

      if (kIsWeb) {
        // Web: Upload from Uint8List
        uploadTask = ref.putData(webImageBytes1!);
      } else {
        // Mobile: Upload from File
        uploadTask = ref.putFile(imageFile1!);
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      DocumentReference docRef = FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K');

      DocumentSnapshot docSnapshot = await docRef.get();

      List<dynamic> packagingTax = docSnapshot.get('packaging_tax');

      packagingTax[0] = downloadUrl;
      try{

          await FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K').update({
            'pakaging_image': [],
          });

        }on FirebaseException catch(e){
          throw FireStoreException(firebaseException:  e);
        }

      emit(UploadImageSuccessState());
      return downloadUrl;
    } catch (error) {
      emit(UploadImageErrorState());
      throw Exception("Failed to upload image: $error");
    }
  }

  /// upload image 2

  /// upload packaging image

  var picker2 = ImagePicker();

  File? imageFile2; // For mobile
  Uint8List? webImageBytes2; // For web

  Future<void> pickPackagingImage2() async {
    emit(PickImageLoadingState2());

    final pickedImage = await picker2.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        webImageBytes2 = await pickedImage.readAsBytes();
        emit(PickImageLoadingState2());
      } else {
        imageFile2 = File(pickedImage.path);
        emit(PickImageSuccessState2());
      }
    } else {
      emit(PickImageErrorState2());
    }
  }

  Future<String> uploadPackagingImage2() async {
    emit(UploadImageLoadingState2());

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('packaging/2/${DateTime.now().millisecondsSinceEpoch}');

      firebase_storage.UploadTask uploadTask;

      if (kIsWeb) {
        // Web: Upload from Uint8List
        uploadTask = ref.putData(webImageBytes2!);
      } else {
        // Mobile: Upload from File
        uploadTask = ref.putFile(imageFile2!);
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      DocumentReference docRef = FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K');

      DocumentSnapshot docSnapshot = await docRef.get();

      List<dynamic> packagingTax = docSnapshot.get('packaging_tax');

      packagingTax[1] = downloadUrl;
      try{

        await FirebaseFirestore.instance.collection('taxs').doc('7Nk2W2zeMTlX4djL1C3K').update({
          'pakaging_image': packagingTax[1],
        });

      }on FirebaseException catch(e){
        throw FireStoreException(firebaseException:  e);
      }

      emit(UploadImageSuccessState2());
      return downloadUrl;
    } catch (error) {
      emit(UploadImageErrorState());
      throw Exception("Failed to upload image: $error");
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