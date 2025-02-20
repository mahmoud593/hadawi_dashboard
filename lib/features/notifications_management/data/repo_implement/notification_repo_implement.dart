import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/notifications_management/data/data_source/notifications_data_source.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/repo/notification_repo.dart';
import 'package:hadawi_dathboard/features/users/data/data_source/users_data_source.dart';
import 'package:hadawi_dathboard/features/users/data/models/user_model.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

class NotificationRepoImplement extends NotificationRepo{

  NotificationsDataSource notificationsDataSource ;

  NotificationRepoImplement({required this.notificationsDataSource});

  @override
  Future<Either<Faliure, NotificationsEntities>> getOccasionComplete() async{
    try{
      return Right(await notificationsDataSource.getOccasionComplete());
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, NotificationsEntities>> getPaymentDone() async{
    try{
      return Right(await notificationsDataSource.getPaymentDone());
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, NotificationsEntities>> getPaymentRemember() async{
    try{
      return Right(await notificationsDataSource.getPaymentRemember());
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, NotificationsEntities>> getPaymentThanks()async {
    try{
      return Right(await notificationsDataSource.getPaymentThanks());
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, void>> updateOccasionComplete({required String description, required String title, required bool status})async {
    try{
      return Right(await notificationsDataSource.updateOccasionComplete(
          description: description,
          title: title,
          status: status
      ));
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, void>> updatePaymentDone({required String description, required String title, required bool status})async {
    try{
      return Right(await notificationsDataSource.updatePaymentDone(description: description, title: title, status: status));
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, void>> updatePaymentRemember({required String description, required String title, required bool status})async {
    try{
      return Right(await notificationsDataSource.updatePaymentRemember(description: description, title: title, status: status));
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }

  @override
  Future<Either<Faliure, void>> updatePaymentThanks({required String description, required String title, required bool status}) async{
    try{
      return Right(await notificationsDataSource.updatePaymentThanks(description: description, title: title, status: status));
    }on FireStoreException catch(e){
    throw FireStoreFaliure.fromMessage(e);
    }
  }


}