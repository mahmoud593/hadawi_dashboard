import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/data/models/notification_model.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_complete_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_done_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_remember_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_thanks_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_complete_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_done_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_remember_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_thanks_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this.getOccasionCompleteUseCases,
      this.getOccasionRememberUseCases,
      this.getOccasionDoneUseCases,
      this.getOccasionThanksUseCases,
      this.updateOccasionCompleteUseCases,
      this.updateOccasionRememberUseCases,
      this.updateOccasionDoneUseCases,
      this.updateOccasionThanksUseCases) : super(NotificationInitial());

  GetOccasionCompleteUseCases getOccasionCompleteUseCases;
  GetOccasionRememberUseCases getOccasionRememberUseCases;
  GetOccasionDoneUseCases getOccasionDoneUseCases;
  GetOccasionThanksUseCases getOccasionThanksUseCases;

  UpdateOccasionCompleteUseCases updateOccasionCompleteUseCases;
  UpdateOccasionRememberUseCases updateOccasionRememberUseCases;
  UpdateOccasionDoneUseCases updateOccasionDoneUseCases;
  UpdateOccasionThanksUseCases updateOccasionThanksUseCases;

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationsEntities ?notificationCompleteEntities;
  Future<void> getNotificationComplete() async {
    emit(GetOccasionsCompleteLoadingState());
    final result = await getOccasionCompleteUseCases.call();
    result.fold(
            (l) => emit(GetOccasionsCompleteErrorState(l.message)),
            (r) {
              notificationCompleteEntities = r;
              emit(GetOccasionsCompleteSuccessState());
              }
    );
  }

  NotificationsEntities ?notificationThanksEntities;
  Future<void> getNotificationThanks() async {
    emit(GetOccasionsThanksLoadingState());
    final result = await getOccasionThanksUseCases.call();
    result.fold(
            (l) => emit(GetOccasionsThanksErrorState(l.message)),
            (r) {
          notificationThanksEntities = r;
          emit(GetOccasionsThanksSuccessState());
        }
    );
  }

  NotificationsEntities ?notificationDoneEntities;
  Future<void> getNotificationDone() async {
    emit(GetOccasionsDoneLoadingState());
    final result = await getOccasionDoneUseCases.call();
    result.fold(
            (l) => emit(GetOccasionsDoneErrorState(l.message)),
            (r) {
          notificationDoneEntities = r;
          emit(GetOccasionsDoneSuccessState());
        }
    );
  }

  NotificationsEntities ?notificationRememberEntities;
  Future<void> getNotificationRemember() async {
    emit(GetOccasionsRememberLoadingState());
    final result = await getOccasionRememberUseCases.call();
    result.fold(
            (l) => emit(GetOccasionsRememberErrorState(l.message)),
            (r) {
          notificationRememberEntities = r;
          emit(GetOccasionsRememberSuccessState());
        }
    );
  }


  Future<void> updateNotificationRemember({
    required String title,
    required String description,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
}) async {
    emit(UpdateOccasionsRememberLoadingState());
    final result = await updateOccasionRememberUseCases.call(
      title:title ,
      description: description,
      status: status,
      remind12: remind12,
        remind24: remind24,
        remind48: remind48
    );
    result.fold(
            (l) => emit(UpdateOccasionsRememberErrorState(l.message)),
            (r) async{
          await getNotificationRemember();
          emit(UpdateOccasionsRememberSuccessState());
        }
    );
  }

  Future<void> updateNotificationThanks({
    required String title,
    required String description,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  }) async {
    emit(UpdateOccasionsThanksLoadingState());
    final result = await updateOccasionThanksUseCases.call(
      title:title ,
      description: description,
      status: status,
      remind12: remind12,
        remind24: remind24,
        remind48: remind48
    );
    result.fold(
            (l) => emit(UpdateOccasionsThanksErrorState(l.message)),
            (r) async {
           await getNotificationThanks();
          emit(UpdateOccasionsThanksSuccessState());
        }
    );
  }

  Future<void> updateNotificationDone({
    required String title,
    required String description,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  }) async {
    emit(UpdateOccasionsDoneLoadingState());
    final result = await updateOccasionDoneUseCases.call(
      title:title ,
      description: description,
      status: status,
      remind12: remind12,
        remind24: remind24,
        remind48: remind48

    );
    result.fold(
            (l) => emit(UpdateOccasionsDoneErrorState(l.message)),
            (r)async {
            await getNotificationDone();
          emit(UpdateOccasionsDoneSuccessState());
        }
    );
  }

  Future<void> updateNotificationComplete({
    required String title,
    required String description,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  }) async {
    emit(UpdateOccasionsCompleteLoadingState());
    final result = await updateOccasionCompleteUseCases.call(
      title:title ,
      description: description,
      status: status,
      remind12: remind12,
        remind24: remind24,
        remind48: remind48
    );
    result.fold(
            (l) => emit(UpdateOccasionsCompleteErrorState(l.message)),
            (r)async {
            await  getNotificationComplete();
          emit(UpdateOccasionsCompleteSuccessState());
        }
    );
  }

  List<NotificationModel> notificationList=[];

  Future<void> getNotification()async {
    notificationList=[];
    emit(AddNewNotificationLoadingState());
    try{

      var result = await FirebaseFirestore.instance.collection('notification_messages').get();

      notificationList = result.docs.map((e) => NotificationModel.fromJson(e.data())).toList();

      print('Notification Data ${notificationList.length}');
      emit(AddNewNotificationSuccessState());
    }on FireStoreException catch(e){
      emit(AddNewNotificationErrorState());
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }


  Future<void> addNewNotification({
    required String description,
    required String title,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  })async {
    emit(AddNewNotificationLoadingState());
    try{
      await FirebaseFirestore.instance.collection('notification_messages').add(
          {
            'description': description,
            'title': title,
            'status': status,
            'remind12': remind12,
            'remind24': remind24,
            'remind48': remind48,
            'uId':''
          }
      ).then((value)async{
        await FirebaseFirestore.instance.collection('notification_messages').doc(value.id).update({'uId':value.id});});

      emit(AddNewNotificationSuccessState());
    }on FireStoreException catch(e){
      emit(AddNewNotificationErrorState());
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future<void> updateNotification({
    required String description,
    required String title,
    required String uId,
    required bool status,
    required bool remind12,
    required bool remind24,
    required bool remind48,
  })async {
    emit(UpdateNewNotificationLoadingState());
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc(uId).update(
          {
            'description': description,
            'title': title,
            'status': status,
            'remind12': remind12,
            'remind24': remind24,
            'remind48': remind48
          }
      );
      emit(UpdateNewNotificationSuccessState());
    }on FireStoreException catch(e){
      emit(UpdateNewNotificationErrorState());
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }

  Future<void> deleteNotification({
    required String uId,
  })async {
    emit(DeleteNewNotificationLoadingState());
    try{
      await FirebaseFirestore.instance.collection('notification_messages').doc(uId).delete();
      emit(DeleteNewNotificationSuccessState());
    }on FireStoreException catch(e){
      emit(DeleteNewNotificationErrorState());
      throw FireStoreException(firebaseException: e.firebaseException);
    }
  }



}