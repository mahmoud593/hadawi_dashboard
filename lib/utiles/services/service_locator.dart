import 'package:get_it/get_it.dart';



final getIt = GetIt.instance;

class ServiceLocator {

  void init() {

    // /// Auth Layer
    // getIt.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSourceImplement());
    // getIt.registerLazySingleton<AuthBaseRepository>(()=> AuthRepositoryImplement(baseAuthDataSource: getIt()));
    // getIt.registerLazySingleton(()=> LoginUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> RegisterUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> SaveDataUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> LogoutUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> GoogleAuthUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> LoginWithPhoneUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> VerifiyCodeUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> CheckUserLoginUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> GetUserInfoUseCases(authBaseRepository: getIt()));
    // getIt.registerLazySingleton(()=> DeleteUserUseCases(authBaseRepository: getIt()));
    //
    // /// Edit Profile Layer
    // getIt.registerLazySingleton(()=> EditProfileUseCases(editProfileRepo: getIt()));
    // getIt.registerLazySingleton<EditProfileDataSource>(()=> EditProfileDataSourceImplement(baseAuthDataSource: getIt()));
    // getIt.registerLazySingleton<EditProfileRepo>(()=> EditProfileRepoImplement(editProfileDataSource:  getIt()));
    //
    // /// Friends Layer
    // getIt.registerLazySingleton(()=> SendFollowRequestUseCases(visitorsRepo: getIt()));
    // getIt.registerLazySingleton(()=> AcceptFollowRequestUseCases(friendsRepo: getIt()));
    // getIt.registerLazySingleton(()=> RejectFollowRequestUseCases(friendsRepo: getIt()));
    // getIt.registerLazySingleton(()=> GetFollowersUseCases(friendsRepo: getIt()));
    // getIt.registerLazySingleton(()=> GetFollowingUseCases(friendsRepo: getIt()));
    // getIt.registerLazySingleton<FriendsDataSource>(()=> FriendsDataSourceImplement());
    // getIt.registerLazySingleton<FriendsRepo>(()=> FriendsRepoImplement(friendsDataSource:  getIt()));
    //
    //
    // /// Visitors Layer
    // getIt.registerLazySingleton<VisitorsDataSource>(()=> VisitorsDataSourceImplement());
    // getIt.registerLazySingleton<VisitorsRepo>(()=> VisitorsRepoImplement(visitorsDataSource:  getIt()));



  }

}