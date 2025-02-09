import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/users/data/data_source/users_data_source.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class UserRepoImplement extends UserRepo{

  UsersDataSource usersDataSource ;

  UserRepoImplement({required this.usersDataSource});

  @override
  Future<Either<Faliure, List<UserModel>>> getAllUsers() async{
   try{
     return Right(await usersDataSource.getAllUsers());

   }on FireStoreException catch(e){
     throw FireStoreFaliure.fromMessage(e);
   }

  }


}