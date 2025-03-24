import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/auth/data/model/emil_pass_model.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/email_pass_entity.dart';
import 'package:hadawi_dathboard/features/settings/presentation/controller/settings_states.dart';

class SettingCubit extends Cubit<SettingsStates> {

  SettingCubit() : super(SettingsInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> getAdminCredentials() async {
    try {
      emit(GetAdminCredentialsLoadingState());
      var response = await FirebaseFirestore.
      instance.collection('admin').
      doc('DQeGUv46lCTI3NjBnPhJ').get();

      EmailPassEntity emailPassEntity = EmailPassModel.fromJson(
          response.data()!);

      emailController.text = emailPassEntity.email;
      passwordController.text = emailPassEntity.password;
      emit(GetAdminCredentialsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetAdminCredentialsErrorState());
    }
  }


  Future<void> changeAdminCredentials({
    required String email,
    required String password,
}) async {
    try {
      emit(ChangeAdminCredentialsLoadingState());
       await FirebaseFirestore.
      instance.collection('admin').
      doc('DQeGUv46lCTI3NjBnPhJ').update({
        'email': email,
        'password': password,
      });

      await getAdminCredentials();
      emit(ChangeAdminCredentialsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(ChangeAdminCredentialsErrorState());
    }
  }

}