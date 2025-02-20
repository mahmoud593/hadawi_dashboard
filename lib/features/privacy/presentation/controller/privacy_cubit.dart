import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_states.dart';

class PrivacyCubit extends Cubit<PrivacyState> {

  PrivacyCubit() : super(PrivacyInitialState());


  String privacy = '';

  Future<void> getPrivacy() async {
    emit(GetPrivacyLoadingState());
    try {
      FirebaseFirestore.instance.collection('privacy_policies').doc('K7RbFuigg80XvZPoh8sv').get().then((value) {

        privacy=value.data()!['text'];
        emit(GetPrivacySuccessState());
      });
    } catch (e) {
      emit(GetPrivacyErrorState(error: e.toString()));
    }
  }

  Future<void> updatePrivacy({required String text }) async {
    emit(UpdatePrivacyLoadingState());
    try {
      FirebaseFirestore.instance.collection('privacy_policies').doc('K7RbFuigg80XvZPoh8sv').update({
        'text': text,
      }).then((value) {
        emit(UpdatePrivacySuccessState());
      });
    } catch (e) {
      emit(UpdatePrivacyErrorState(error: e.toString()));
    }
  }
  

}