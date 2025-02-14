import 'package:get_it/get_it.dart';
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


  }

}