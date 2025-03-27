import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/users/data/models/analysis_model.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/block_user_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/delete_user_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/get_all_users_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/send_notitifcation_use_cases.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit(
      this.getAllUsersUseCases,
      this.sendNotitifcationUseCases,
      this.blockUserUseCases,
      this.deleteUserUseCases
      ) : super(UserInitialState());

  GetAllUsersUseCases getAllUsersUseCases;
  SendNotitifcationUseCases sendNotitifcationUseCases;
  BlockUserUseCases blockUserUseCases;
  DeleteUserUseCases deleteUserUseCases;

  List<UserEntities> users = [];

  Future<void> getAllUsers({required bool desending})async{
    users = [];
    emit(GetUserLoadingState());
    var result = await getAllUsersUseCases.call(desending: desending);
    result.fold(
            (l) => emit(GetUserErrorState(l.message)),
            (r) {
              users = r;
              emit(GetUserSuccessState());
            }
    );
  }

  Future<void> sendNotification({
    required String message,
    required String userId
})async{
    emit(SendNotificationLoadingState());
    var result = await sendNotitifcationUseCases.call(userId:  userId, message: message);
    result.fold(
            (l) => emit(SendNotificationErrorState(l.message)),
            (r) {
          emit(SendNotificationSuccessState());
        }
    );
  }

  Future<void> launchWhatsApp({required String phoneNumber, required String message})
  async {
    final Uri whatsappUri = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  void filterName(String value, bool desending){
    if(value.isEmpty){
      getAllUsers(desending: desending);
    }else{
      Set<UserEntities> items = users.where((item)=> item.name.toLowerCase().
      contains(value.toLowerCase())).toSet();
      items.addAll(users.where((item)=> item.email.toLowerCase().
      contains(value.toLowerCase())).toList());
      items.addAll(users.where((item)=> item.phone.toLowerCase().
      contains(value.toLowerCase())).toList());
      users = items.toList();
    }
    emit(SendNotificationSuccessState());

  }

  Future<void> deleteUser({
    required String userId,
    required String message
  })async{
    emit(DeleteUserLoadingState());

    var result = await deleteUserUseCases.call(userId:  userId,message: message);
    result.fold(
            (l) => emit(DeleteUserErrorState(l.message)),
            (r) {
          emit(DeleteUserSuccessState());
        }
    );
  }

  Future<void> blockUser({
    required String userId,
    required String message
  })async{
    emit(BlockUserLoadingState());
    var result = await blockUserUseCases.call(userId:  userId,message: message);
    result.fold(
            (l) => emit(BlockUserErrorState(l.message)),
            (r) {
          emit(BlockUserSuccessState());
        }
    );
  }

  AnalysisModel ?analysisModel ;
  Future<void> getAnalysis()async{

    emit(GetAnalysisLoadingState());

    await FirebaseFirestore.instance.collection('analysis').doc('x6cWwImrRB3PIdVfcHnP').get().then((value) {
      analysisModel = AnalysisModel.fromMap(value.data()!);
      emit(GetAnalysisSuccessState());
    }).catchError((error){
      debugPrint("error in getting analysis: $error");
      emit(GetAnalysisErrorState());
    });

  }

}