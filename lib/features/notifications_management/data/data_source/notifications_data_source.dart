import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadawi_dathboard/features/notifications_management/data/models/notification_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';

abstract class NotificationsDataSource {

  Future<NotificationModel> getOccasionComplete();

  Future<NotificationModel> getPaymentDone();

  Future<NotificationModel> getPaymentRemember();

  Future<NotificationModel> getPaymentThanks();

  Future<void> updateOccasionComplete({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
});

  Future<void> updatePaymentDone({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  });

  Future<void> updatePaymentRemember({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  });

  Future<void> updatePaymentThanks({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  });
}

class NotificationsDataSourceImpl extends NotificationsDataSource {

  @override
  Future<NotificationModel> getOccasionComplete() async {
    try{
      var res = await FirebaseFirestore.instance.collection('notification_messages').doc('occasion_complete').get();
      return NotificationModel.fromJson(res.data()!);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }

}

  @override
  Future<NotificationModel> getPaymentDone() async{
    try{
      var res = await FirebaseFirestore.instance.collection('notification_messages').doc('payment_done').get();
      return NotificationModel.fromJson(res.data()!);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<NotificationModel> getPaymentRemember() async{
    try{
      var res = await FirebaseFirestore.instance.collection('notification_messages').doc('payment_remember').get();
      return NotificationModel.fromJson(res.data()!);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<NotificationModel> getPaymentThanks() async{
    try{
      var res = await FirebaseFirestore.instance.collection('notification_messages').doc('payment_thanks').get();
      return NotificationModel.fromJson(res.data()!);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> updateOccasionComplete({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  })async {
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc('occasion_complete').update(
        {
          'description': description,
          'title': title,
          'status': status,
          'remind12': remind12,
          'remind24': remind24,
          'remind48': remind48

        }
      );
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> updatePaymentDone({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  })async {
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc('payment_done').update(
          {
            'description': description,
            'title': title,
            'status': status,
            'remind12': remind12,
            'remind24': remind24,
            'remind48': remind48
          }
      );
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> updatePaymentRemember({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  })async {
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc('payment_remember').update(
          {
            'description': description,
            'title': title,
            'status': status,
            'remind12': remind12,
            'remind24': remind24,
            'remind48': remind48
          }
      );
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> updatePaymentThanks({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  }) async{
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc('payment_thanks').update(
          {
            'description': description,
            'title': title,
            'status': status,
            'remind12': remind12,
            'remind24': remind24,
            'remind48': remind48
          }
      );
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

}