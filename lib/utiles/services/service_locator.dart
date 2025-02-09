import 'package:get_it/get_it.dart';
import 'package:hadawi_dathboard/features/users/data/data_source/users_data_source.dart';
import 'package:hadawi_dathboard/features/users/data/repo_implement/user_repo_implement.dart';
import 'package:hadawi_dathboard/features/users/domain/repo/user_repo.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/get_all_users_use_cases.dart';



final getIt = GetIt.instance;

class ServiceLocator {

  void init() {

    /// User Layer
    getIt.registerLazySingleton<UsersDataSource>(() => UsersDataSourceImpl());
    getIt.registerLazySingleton<UserRepo>(()=> UserRepoImplement(usersDataSource: getIt()));
    getIt.registerLazySingleton(()=> GetAllUsersUseCases(userRepo: getIt()));

  }

}