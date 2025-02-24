abstract class AdminStates {}

class AdminInitState extends AdminStates {}

class AdminRowSelectedState extends AdminStates {}

class AdminChangeState extends AdminStates {}

class AdminLoadingState extends AdminStates {}

class AdminCreateDBSuccState extends AdminStates {}

class AdminOpenDBSuccState extends AdminStates {}

class AdminCreateDBErrState extends AdminStates {
  final String error;
  AdminCreateDBErrState(this.error);
}

class AdminLoadingGetProductsState extends AdminStates {}

class AdminGetProductsSuccState extends AdminStates {}

class AdminGetProductsErrState extends AdminStates {
  final String error;
  AdminGetProductsErrState(this.error);
}

class AdminInsertProductsState extends AdminStates {
  final dynamic id;
  AdminInsertProductsState(this.id);
}

class AdminUptadeDBState extends AdminStates {}

class AdminDeleteDBState extends AdminStates {}
