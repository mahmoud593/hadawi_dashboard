abstract class UserStates{}

class UserInitialState extends UserStates{}

class GetUserLoadingState extends UserStates{}
class GetUserSuccessState extends UserStates{}
class GetUserErrorState extends UserStates{
  String message;
  GetUserErrorState(this.message);
}

class SendNotificationLoadingState extends UserStates{}
class SendNotificationSuccessState extends UserStates{}
class SendNotificationErrorState extends UserStates{
  String message;
  SendNotificationErrorState(this.message);
}

class DeleteUserLoadingState extends UserStates{}
class DeleteUserSuccessState extends UserStates{}
class DeleteUserErrorState extends UserStates{
  String message;
  DeleteUserErrorState(this.message);
}

class BlockUserLoadingState extends UserStates{}
class BlockUserSuccessState extends UserStates{}
class BlockUserErrorState extends UserStates{
  String message;
  BlockUserErrorState(this.message);
}

class GetAnalysisLoadingState extends UserStates{}
class GetAnalysisSuccessState extends UserStates{}
class GetAnalysisErrorState extends UserStates{}


