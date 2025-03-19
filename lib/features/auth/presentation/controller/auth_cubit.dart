import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/auth/data/repo_imp/user_repo_imp.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepoImp _userRepoImp;

  AuthCubit(this._userRepoImp) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final Either<Faliure, void> result =
    await _userRepoImp.login(email: email, password: password);

    result.fold(
          (failure) => emit(UserLoginErrorState(message: failure.message)),
          (_) => emit(UserLoginSuccessState()),
    );
  }

  Future<void> loginWithEmailPass({required String email, required String password}) async {
    emit(LoginLoading());
    final Either<Faliure, void> result =
    await _userRepoImp.loginWithEmailPass(email: email, password: password);
    result.fold(
          (failure) => emit(UserLoginErrorState(message: failure.message)),
          (_) => emit(UserLoginSuccessState()),
    );
  }
  Future<void> saveUserData({
    required String email,
    required String name,
    required String uId,
  }) async {
    emit(SaveUserDataLoading());
    final result =
    await _userRepoImp.saveUserData(email: email, name: name, uId: uId);

    result.fold(
          (failure) => emit(SaveUserDataErrorState(message: failure.message)),
          (_) => emit(SaveUserDataSuccessState()),
    );
  }

  Future<void> getUserData({required String uId}) async {
    emit(GetUserDataLoading());
    final result = await _userRepoImp.getUserData(uId: uId);

    result.fold(
          (failure) => emit(GetUserDataErrorState(message: failure.message)),
          (_) => emit(GetUserDataSuccessState()),
    );
  }

  Future<void> logout() async {
    emit(LogOutLoading());
    final result = await _userRepoImp.logout();

    result.fold(
          (failure) => emit(LogOutErrorState(message: failure.message)),
          (_) => emit(LogOutSuccessState()),
    );
  }
}
