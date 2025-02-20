import 'package:flutter_bloc/flutter_bloc.dart';
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
}) async {
    emit(UpdateOccasionsRememberLoadingState());
    final result = await updateOccasionRememberUseCases.call(
      title:title ,
      description: description,
      status: status,
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
  }) async {
    emit(UpdateOccasionsThanksLoadingState());
    final result = await updateOccasionThanksUseCases.call(
      title:title ,
      description: description,
      status: status,
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
  }) async {
    emit(UpdateOccasionsDoneLoadingState());
    final result = await updateOccasionDoneUseCases.call(
      title:title ,
      description: description,
      status: status,
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
  }) async {
    emit(UpdateOccasionsCompleteLoadingState());
    final result = await updateOccasionCompleteUseCases.call(
      title:title ,
      description: description,
      status: status,
    );
    result.fold(
            (l) => emit(UpdateOccasionsCompleteErrorState(l.message)),
            (r)async {
            await  getNotificationComplete();
          emit(UpdateOccasionsCompleteSuccessState());
        }
    );
  }

}