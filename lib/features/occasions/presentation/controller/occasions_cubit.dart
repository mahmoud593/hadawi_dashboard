import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/repo_imp/occasion_repo_imp.dart';
import '../../domain/entities/occastion_entity.dart';

part 'occasions_state.dart';

class OccasionsCubit extends Cubit<OccasionsState> {
  OccasionsCubit() : super(OccasionsInitial());
  List<OccasionEntity> occasions = [];
  Future<void> getOccasions() async {
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().getOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void> filterNotCompletedOccasions()async{
    occasions.clear();

    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().filterNotCompletedOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint( "${occasions.first.moneyGiftAmount}");

      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

  Future<void>filterCompletedOccasions()async{
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().filterCompletedOccasions();
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint( "${occasions.first.moneyGiftAmount}");

      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }



  Future<void> filterOccasionsByType ( {required String occasionType})async {
    occasions.clear();
    emit(GetOccasionsLoadingState());
    final result = await OccasionRepoImp().filterOccasionsByType(occasionType: occasionType);
    result.fold((failure) {
      emit(GetOccasionsErrorState(error: failure.message));
    }, (occasion) {
      occasions.addAll(occasion);
      debugPrint(occasions.first.giftType);
      debugPrint("{moneyOccasions[0].occasionId}");
      debugPrint(occasions.first.occasionId);
      emit(GetOccasionsSuccessState(occasions: occasions));
    });
  }

}
