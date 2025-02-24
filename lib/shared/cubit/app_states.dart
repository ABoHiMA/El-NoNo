abstract class AppStates {}

class AppInitState extends AppStates {}

class AppChgPassState extends AppStates {}

class AppCreateDBSuccState extends AppStates {}

class AppInsertDataAdminSuccState extends AppStates {}

class AppInsertDataAdminErrState extends AppStates {
  final String err;
  AppInsertDataAdminErrState(this.err);
}

class AppInsertDataAppSuccState extends AppStates {}

class AppInsertDataAppErrState extends AppStates {
  final String err;
  AppInsertDataAppErrState(this.err);
}

class AppLoadingGetDataAdminState extends AppStates {}

class AppGetDataAdminSuccState extends AppStates {}

class AppGetAllElNoNoDataSuccState extends AppStates {}

class AppGetDataAdminErrState extends AppStates {
  final String error;
  AppGetDataAdminErrState(this.error);
}

class AppUpdateDataAdminSuccState extends AppStates {}

class AppUpdateDataUserSuccState extends AppStates {}

class AppEncryptNIDState extends AppStates {}

class AppDecryptNIDState extends AppStates {}

class AppLoadingDataState extends AppStates {}

class AppResetDataState extends AppStates {}

class AppActivationSuccState extends AppStates {}

class AppGetDeviceDataState extends AppStates {}

class AppChangeLanguageState extends AppStates {
  AppChangeLanguageState();
}