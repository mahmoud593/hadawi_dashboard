import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';

abstract class UsersDataSource {

  Future<List<UserModel>> getAllUsers({required bool desending});

  Future<void> sendNotification({
    required String message,
    required String userId,
});

  Future<void> deleteUser({
    required String userId,
    required String message
  });

  Future<void>  blockUser({
    required String userId,
    required String message
  });
}

class UsersDataSourceImpl extends UsersDataSource {

  @override
  Future<List<UserModel>> getAllUsers({required bool desending})async {
    try{
      List<UserModel> users = [];

      var res = await FirebaseFirestore.instance.collection('users').get();

      for (var element in res.docs) {
        users.add(UserModel.fromJson(element.data()));
      }

      if(desending){
        users.sort((UserModel a, UserModel b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
      }else{
        users.sort((UserModel a, UserModel b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      }

      return users;
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }

}

  @override
  Future<void> sendNotification({
    required String message,
    required String userId,
  }) async{
    try{

       await FirebaseFirestore.instance.collection('notifications').add({
         'date': DateTime.now().toString(),
         'message': message,
         'id': '',
         'userId': userId,
       }).then((value) => value.update({'id': value.id}));

    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> blockUser({required String userId,required String message})async {
    try{
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'block': true});
      sendNotification(message: message, userId: userId);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  @override
  Future<void> deleteUser({required String userId,required String message})async {
    try{
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      sendNotification(message: message, userId: userId);
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }



}