part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class UserLoginSuccessState extends AuthState {}

final class UserLoginErrorState extends AuthState {
  final String message;

  UserLoginErrorState({required this.message});
}

final class SaveUserDataLoading extends AuthState {}

final class SaveUserDataSuccessState extends AuthState {}

final class SaveUserDataErrorState extends AuthState {
  final String message;

  SaveUserDataErrorState({required this.message});
}

final class GetUserDataLoading extends AuthState {}

final class GetUserDataSuccessState extends AuthState {}

final class GetUserDataErrorState extends AuthState {
  final String message;

  GetUserDataErrorState({required this.message});
}

final class LogOutLoading extends AuthState {}

final class LogOutSuccessState extends AuthState {}

final class LogOutErrorState extends AuthState {
  final String message;

  LogOutErrorState({required this.message});
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}

class AuthSavedState extends AuthState {}
