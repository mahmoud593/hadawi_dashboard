import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';

abstract class UsersDataSource {

  Future<List<UserModel>> getAllUsers();

}

class UsersDataSourceImpl extends UsersDataSource {

  @override
  Future<List<UserModel>> getAllUsers()async {
    try{
      List<UserModel> users = [];

      var res = await FirebaseFirestore.instance.collection('users').get();

      res.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });

      return users;
    }on FireStoreException catch(e){
      throw FireStoreException(firebaseException: e.firebaseException);
    }

}



}