
abstract class UserDataStates{}

class UserDataInitialState extends UserDataStates{}




class UserGetDataLoading extends UserDataStates {}

class UserGetDataSuccess extends UserDataStates {}

class UserGetDataError extends UserDataStates {
  final dynamic error;

  UserGetDataError(this.error);
}

class UpdateUserNameLoading extends UserDataStates {}

class UpdateUserNameSuccess extends UserDataStates {}

class UpdateUserNameError extends UserDataStates {
  final dynamic error;

  UpdateUserNameError(this.error);
}
class UpdateUserEmailLoading extends UserDataStates {}

class UpdateUserEmailSuccess extends UserDataStates {}

class UpdateUserEmailError extends UserDataStates {
  final dynamic error;

  UpdateUserEmailError(this.error);
}
