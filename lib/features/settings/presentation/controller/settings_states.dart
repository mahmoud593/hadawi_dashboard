abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class GetAdminCredentialsLoadingState extends SettingsStates {}
class GetAdminCredentialsSuccessState extends SettingsStates {}
class GetAdminCredentialsErrorState extends SettingsStates {}

class ChangeAdminCredentialsLoadingState extends SettingsStates {}
class ChangeAdminCredentialsSuccessState extends SettingsStates {}
class ChangeAdminCredentialsErrorState extends SettingsStates {}