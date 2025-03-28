abstract class NotificationStates {}

class NotificationInitial extends NotificationStates {}

class GetOccasionsThanksLoadingState extends NotificationStates {}
class GetOccasionsThanksSuccessState extends NotificationStates {}
class GetOccasionsThanksErrorState extends NotificationStates {
  final String error;
  GetOccasionsThanksErrorState(this.error);
}

class GetOccasionsCompleteLoadingState extends NotificationStates {}
class GetOccasionsCompleteSuccessState extends NotificationStates {}
class GetOccasionsCompleteErrorState extends NotificationStates {
  final String error;
  GetOccasionsCompleteErrorState(this.error);
}

class GetOccasionsRememberLoadingState extends NotificationStates {}
class GetOccasionsRememberSuccessState extends NotificationStates {}
class GetOccasionsRememberErrorState extends NotificationStates {
  final String error;
  GetOccasionsRememberErrorState(this.error);
}

class GetOccasionsDoneLoadingState extends NotificationStates {}
class GetOccasionsDoneSuccessState extends NotificationStates {}
class GetOccasionsDoneErrorState extends NotificationStates {
  final String error;
  GetOccasionsDoneErrorState(this.error);
}

class UpdateOccasionsThanksLoadingState extends NotificationStates {}
class UpdateOccasionsThanksSuccessState extends NotificationStates {}
class UpdateOccasionsThanksErrorState extends NotificationStates {
   String error;
  UpdateOccasionsThanksErrorState(this.error);
}

class UpdateOccasionsCompleteLoadingState extends NotificationStates {}
class UpdateOccasionsCompleteSuccessState extends NotificationStates {}
class UpdateOccasionsCompleteErrorState extends NotificationStates {
   String error;
  UpdateOccasionsCompleteErrorState(this.error);
}

class UpdateOccasionsRememberLoadingState extends NotificationStates {}
class UpdateOccasionsRememberSuccessState extends NotificationStates {}
class UpdateOccasionsRememberErrorState extends NotificationStates {
   String error;
  UpdateOccasionsRememberErrorState(this.error);
}

class UpdateOccasionsDoneLoadingState extends NotificationStates {}
class UpdateOccasionsDoneSuccessState extends NotificationStates {}
class UpdateOccasionsDoneErrorState extends NotificationStates {
   String error;
  UpdateOccasionsDoneErrorState(this.error);
}

class AddNewNotificationLoadingState extends NotificationStates {}
class AddNewNotificationSuccessState extends NotificationStates {}
class AddNewNotificationErrorState extends NotificationStates {}

class UpdateNewNotificationLoadingState extends NotificationStates {}
class UpdateNewNotificationSuccessState extends NotificationStates {}
class UpdateNewNotificationErrorState extends NotificationStates {}

class DeleteNewNotificationLoadingState extends NotificationStates {}
class DeleteNewNotificationSuccessState extends NotificationStates {}
class DeleteNewNotificationErrorState extends NotificationStates {}

class GetNewNotificationLoadingState extends NotificationStates {}
class GetNewNotificationSuccessState extends NotificationStates {}
class GetNewNotificationErrorState extends NotificationStates {}