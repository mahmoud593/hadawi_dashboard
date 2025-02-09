import 'package:bloc/bloc.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/domain/use_cases/get_all_users_use_cases.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit(this.getAllUsersUseCases) : super(UserInitialState());

  GetAllUsersUseCases getAllUsersUseCases;

  List<UserEntities> users = [];

  Future<void> getAllUsers()async{
    users = [];
    emit(GetUserLoadingState());
    var result = await getAllUsersUseCases.call();
    result.fold(
            (l) => emit(GetUserErrorState(l.message)),
            (r) {
              users = r;
              emit(GetUserSuccessState());
            }
    );
  }



}