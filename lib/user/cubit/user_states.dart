abstract class UserStates {}

class UserInitState extends UserStates {}

class UserRowSelectedState extends UserStates {}

class UserProductStateUpdated extends UserStates {}

class UserCreateDBSuccState extends UserStates {}

class UserOpenDBSuccState extends UserStates {}

class UserCreateDBErrState extends UserStates {
  final String error;
  UserCreateDBErrState(this.error);
}

class UserLoadingState extends UserStates {}

class UserLoadingGetProductsState extends UserStates {}

class UserGetProductsSuccState extends UserStates {}

class UserGetProductsErrState extends UserStates {
  final String error;
  UserGetProductsErrState(this.error);
}

class UserInsertProductsState extends UserStates {
  final dynamic id;
  UserInsertProductsState(this.id);
}

class UserUptadeDBState extends UserStates {}
