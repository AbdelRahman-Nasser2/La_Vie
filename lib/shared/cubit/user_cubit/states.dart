
abstract class UserDataStates{}

class UserDataInitialState extends UserDataStates{}




class UserGetDataLoading extends UserDataStates {}

class UserGetDataSuccess extends UserDataStates {}

class UserGetDataError extends UserDataStates {
  final dynamic error;

  UserGetDataError(this.error);
}

class UpdateUserDataLoading extends UserDataStates {}

class UpdateUserDataSuccess extends UserDataStates {}

class UpdateUserDataError extends UserDataStates {
  final dynamic error;

  UpdateUserDataError(this.error);
}
