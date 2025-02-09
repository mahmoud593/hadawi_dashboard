abstract class UserStates{}

class UserInitialState extends UserStates{}

class GetUserLoadingState extends UserStates{}
class GetUserSuccessState extends UserStates{}
class GetUserErrorState extends UserStates{
  String message;
  GetUserErrorState(this.message);
}

