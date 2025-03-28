import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/auth/data/repo_imp/user_repo_imp.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepoImp _userRepoImp;

  AuthCubit(this._userRepoImp) : super(AuthInitial());

  TextEditingController  emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool rememberMe = false;
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

  Future<void> loadSavedCredentials() async {
    emit(AuthLoadingState());
    try {
      final isRemembered = UserDataFromStorage.rememberMe;
      if (isRemembered) {
        rememberMe = true;
        emailController.text = UserDataFromStorage.emailFromStorage;
        passwordController.text = UserDataFromStorage.password;
      }
      else {
        rememberMe = false;
        emailController.text = '';
        passwordController.text = '';
      }
      emit(AuthLoadedState());
    } catch (e) {
      emit(AuthErrorState('فشل تحميل بيانات المستخدم'));
    }
  }

  Future<void> saveCredentials(String email, String password) async {
    try {
      if (rememberMe) {
        await UserDataFromStorage.setRememberMe(true);
        await UserDataFromStorage.setEmail(email);
        await UserDataFromStorage.setPassword(password);
      } else {
        await UserDataFromStorage.setRememberMe(false);
        await UserDataFromStorage.setEmail('');
        await UserDataFromStorage.setPassword('');
      }
      emit(AuthSavedState());
    } catch (e) {
      emit(AuthErrorState('فشل حفظ بيانات المستخدم'));
    }
  }
}
