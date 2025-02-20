import 'package:get_it/get_it.dart';
import 'package:hadawi_dathboard/features/notifications_management/data/data_source/notifications_data_source.dart';
import 'package:hadawi_dathboard/features/notifications_management/data/repo_implement/notification_repo_implement.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/repo/notification_repo.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_complete_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_done_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_remember_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/get_occasion_thanks_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_complete_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_done_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_remember_use_cases.dart';
import 'package:hadawi_dathboard/features/notifications_management/domain/use_cases/update_occasion_thanks_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/data/data_source/payments_data_source.dart';
import 'package:hadawi_dathboard/features/payments/data/repo_implement/payments_repo_implemet.dart';
import 'package:hadawi_dathboard/features/payments/domain/repo/payments_repo.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/payments/domain/use_cases/update_taxs_use_cases.dart';
import 'package:hadawi_dathboard/features/users/data/data_source/users_data_source.dart';
import 'package:hadawi_dathboard/features/users/data/repo_implement/user_repo_implement.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/block_user_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/delete_user_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/get_all_users_use_cases.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/send_notitifcation_use_cases.dart';



final getIt = GetIt.instance;

class ServiceLocator {

  void init() {

    /// User Layer
    getIt.registerLazySingleton<UsersDataSource>(() => UsersDataSourceImpl());
    getIt.registerLazySingleton<UserRepo>(()=> UserRepoImplement(usersDataSource: getIt()));
    getIt.registerLazySingleton(()=> GetAllUsersUseCases(userRepo: getIt()));
    getIt.registerLazySingleton(()=> SendNotitifcationUseCases(userRepo: getIt()));
    getIt.registerLazySingleton(()=> BlockUserUseCases(userRepo: getIt()));
    getIt.registerLazySingleton(()=> DeleteUserUseCases(userRepo: getIt()));

    /// Payments Layer
    getIt.registerLazySingleton<PaymentsDataSource>(() => PaymentsDataSourceImplement());
    getIt.registerLazySingleton<PaymentsRepo>(()=> PaymentsRepoImplement(paymentsDataSource: getIt()));
    getIt.registerLazySingleton(()=> TaxUseCases(paymentsRepo: getIt()));
    getIt.registerLazySingleton(()=> UpdateTaxsUseCases(paymentsRepo: getIt()));

    /// Notifications Layer
    getIt.registerLazySingleton<NotificationsDataSource>(() => NotificationsDataSourceImpl());
    getIt.registerLazySingleton<NotificationRepo>(()=> NotificationRepoImplement(notificationsDataSource: getIt()));
    getIt.registerLazySingleton(()=> GetOccasionThanksUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> GetOccasionRememberUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> GetOccasionCompleteUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> GetOccasionDoneUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> UpdateOccasionRememberUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> UpdateOccasionDoneUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> UpdateOccasionThanksUseCases(notificationRepo: getIt()));
    getIt.registerLazySingleton(()=> UpdateOccasionCompleteUseCases(notificationRepo: getIt()));


  }

}