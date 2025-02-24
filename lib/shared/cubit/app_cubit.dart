// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:el_nono/models/data_admin.dart';
import 'package:el_nono/models/products_admin.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  String? encryptTxt;
  String? decryptTxt;
  bool isClick = false;
  bool isSure = false;
  bool isCheck = true;
  bool pass = true;
  IconData passIc = Icons.visibility_off_outlined;
  bool rePass = true;
  IconData rePassIc = Icons.visibility_off_outlined;
  bool userPass = true;
  IconData userPassIc = Icons.visibility_off_outlined;
  bool userRePass = true;
  IconData userRePassIc = Icons.visibility_off_outlined;
  bool resetPass = true;
  IconData resetPassIc = Icons.visibility_off_outlined;
  bool resetRePass = true;
  IconData resetRePassIc = Icons.visibility_off_outlined;
  List<DataAdmin> listOfDataAdmin = [];

  void chgClick() {
    isClick = !isClick;
    emit(AppChgPassState());
  }

  void chgSure() {
    isSure = !isSure;
    emit(AppChgPassState());
  }

  void chgCheck() {
    isCheck = !isCheck;
    emit(AppChgPassState());
  }

  void chgPass() {
    pass = !pass;
    if (pass) {
      passIc = Icons.visibility_off_outlined;
    } else {
      passIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  void chgRePass() {
    rePass = !rePass;
    if (rePass) {
      rePassIc = Icons.visibility_off_outlined;
    } else {
      rePassIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  void chgUserPass() {
    userPass = !userPass;
    if (userPass) {
      userPassIc = Icons.visibility_off_outlined;
    } else {
      userPassIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  void chgUserRePass() {
    userRePass = !userRePass;
    if (userRePass) {
      userRePassIc = Icons.visibility_off_outlined;
    } else {
      userRePassIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  void chgResetPass() {
    resetPass = !resetPass;
    if (resetPass) {
      resetPassIc = Icons.visibility_off_outlined;
    } else {
      resetPassIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  void chgResetRePass() {
    resetRePass = !resetRePass;
    if (resetRePass) {
      resetRePassIc = Icons.visibility_off_outlined;
    } else {
      resetRePassIc = Icons.visibility_outlined;
    }
    emit(AppChgPassState());
  }

  Future<void> deleteDatabaseIfExists() async {
    // Not Used but Helpful
    final directory =
        await getDatabasesPath(); // Get the path where databases are stored
    final path = '$directory/elnono.db'; // Path to the existing database file

    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete(); // Delete the file if it exists
        print('Existing database deleted');
      } else {
        print('No Existing database');
      }
    } catch (e) {
      print('Error deleting database: ${e.toString()}');
    }
  }

  Future<void> createTables() async {
    // Not Used but Helpful
    await db
        .execute(
      'CREATE TABLE NoNoDataAdmin (id INTEGER PRIMARY KEY, nID INTEGER, name TEXT, username TEXT, pass TEXT, userUsername TEXT, userPass TEXT, isReg INTEGER, isActivate INTEGER, deviceID TEXT, activateKey TEXT)',
    )
        .then((value) {
      print("Create Table NoNoDataAdmin Succ ");
    }).catchError((error) {
      print("err create NoNoDataAdmin${error.toString()}");
    });

    await db
        .execute(
      'CREATE TABLE NoNoAdmin (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, price REAL, desc TEXT, date TEXT)',
    )
        .then((value) {
      print("Create Table NoNoAdmin Succ ");
    }).catchError((error) {
      print("err create ${error.toString()}");
    });

    await db
        .execute(
      'CREATE TABLE NoNoUser (id INTEGER PRIMARY KEY, pID INTEGER, name TEXT, quantity INTEGER, total REAL, note TEXT, date TEXT)',
    )
        .then((value) {
      print("Create Table NoNoUser Succ ");
    }).catchError((error) {
      print("err create ${error.toString()}");
    });
  }

  Future<void> getDeviceId() async {
    // Not Used but Helpful
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    deviceID = windowsInfo.deviceId;

    print('Device ID: $deviceID');

    emit(AppGetDeviceDataState());
  }

  Future<void> createNoNoData() async {
    openDatabase(
      'elnono.db',
      version: 1,
      onCreate: (db, version) async {
        print("DB Created");

        await db
            .execute(
          'CREATE TABLE NoNoDataAdmin (id INTEGER PRIMARY KEY, nID INTEGER, name TEXT, username TEXT, pass TEXT, userUsername TEXT, userPass TEXT, isReg INTEGER, isActivate INTEGER, deviceID TEXT, activateKey TEXT)',
        )
            .then((value) {
          print("Create Table NoNoDataAdmin Succ ");
        }).catchError((error) {
          print("err create NoNoDataAdmin${error.toString()}");
        });

        await db
            .execute(
          'CREATE TABLE NoNoAdmin (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, price REAL, desc TEXT, date TEXT)',
        )
            .then((value) {
          print("Create Table NoNoAdmin Succ ");
        }).catchError((error) {
          print("err create ${error.toString()}");
        });

        await db
            .execute(
          'CREATE TABLE NoNoUser (id INTEGER PRIMARY KEY, pID INTEGER, name TEXT, quantity INTEGER, total REAL, note TEXT, date TEXT)',
        )
            .then((value) {
          print("Create Table NoNoUser Succ ");
        }).catchError((error) {
          print("err create ${error.toString()}");
        });
      },
      onOpen: (db) async {
        print("DB Opened");
      },
    ).then((value) {
      db = value;
      getDataAdmin(db);
      // dropTables();
      emit(AppCreateDBSuccState());
    });
  }

  void getDataAdmin(db) {
    emit(AppLoadingGetDataAdminState());
    listOfDataAdmin = [];
    listOfNewProducts = [];
    db
        .rawQuery('SELECT * FROM NoNoDataAdmin ORDER BY id DESC LIMIT 1')
        .then((value) {
      print('Last added raw data from DB NoNoDataAdmin: $value');

      if (value.isNotEmpty) {
        var element = value.first;

        listOfDataAdmin.add(DataAdmin.fromMap(element));

        nIDData = element['nID'];
        nameData = element['name'];
        usernameData = element['username'];
        passData = element['pass'];
        userUsernameData = element['userUsername'];
        userPassData = element['userPass'];
        isRegData = element['isReg'];
        isActivateData = element['isActivate'];
        deviceIdData = element['deviceID'];
        activateKey = element['activateKey'];

        print("Retrieved last added data: $element");
      } else {
        print("No data found");
      }

      db.rawQuery('SELECT * FROM NoNoAdmin').then(
        (value) {
          value.forEach((element) {
            listOfNewProducts.add(AdminProduct.fromMap(element));
          });

          print(value);
          emit(AppGetAllElNoNoDataSuccState());
        },
      );

      emit(AppGetDataAdminSuccState());
    }).catchError((error) {
      print('Error retrieving data from the database: $error');
      emit(AppGetDataAdminErrState(error.toString()));
    });
  }

  void insertDataAdmin({
    required int nID,
    required String name,
    required String username,
    required String pass,
    required String userUsername,
    required String userPass,
    required bool isReg,
    required bool isActivate,
    required String deviceID,
    required String activateKey,
  }) {
    db
        .transaction((txn) => txn.rawInsert(
              'INSERT INTO NoNoDataAdmin(nID, name, username, pass, userUsername, userPass, isReg, isActivate, deviceID, activateKey) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [
                nID,
                name,
                username,
                pass,
                userUsername,
                userPass,
                isReg ? 1 : 0,
                isActivate ? 1 : 0,
                deviceID,
                activateKey
              ],
            ))
        .then((value) {
      print(
          "Inserting: nID: $nID,\n name: $name,\n username: $username,\n pass: $pass,\n userUsername: $userUsername,\n userPass: $userPass,\n device: $deviceID, \n activateCode: $activateKey \n");

      print("NoNoDataAdmin Inserted Succ");
      isUser = true;
      getDataAdmin(db);
      emit(AppInsertDataAdminSuccState());
    }).catchError(
      (error) {
        print("Error inserting: ${error.toString()}");
        emit(AppInsertDataAdminErrState(error.toString()));
      },
    );
  }

  Future<void> updateDataAdmin({
    required String username,
    required String pass,
  }) async {
    db.rawUpdate(
        'UPDATE NoNoDataAdmin SET username = ?, pass = ? WHERE nID = ?', [
      username,
      pass,
      nIDData,
    ]).then((value) {
      getDataAdmin(db);
      emit(AppUpdateDataAdminSuccState());
      getDataAdmin(db);
    });
  }

  Future<void> updateDataUser({
    required String username,
    required String pass,
  }) async {
    db.rawUpdate(
        'UPDATE NoNoDataAdmin SET userUsername = ?, userPass = ? WHERE nID = ?',
        [
          username,
          pass,
          nIDData,
        ]).then((value) {
      getDataAdmin(db);
      emit(AppUpdateDataUserSuccState());
    });
  }

  String encryption(String txtToEncrypt) {
    final key = encrypt.Key.fromUtf8("a5f6b3de4g7h8ij9k2lm3nopqr0stuv1");
    final iv = encrypt.IV.fromUtf8("3xy8zw6v1n0pqrs2");
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(txtToEncrypt, iv: iv);
    String encryptedTxt = encrypted.base64;
    encryptTxt = encryptedTxt;
    emit(AppEncryptNIDState());

    print(encryptTxt);
    return encryptedTxt;
  }

  String decryption(String txtToDecrypt) {
    // Not Used but Helpful
    final key = encrypt.Key.fromUtf8("a5f6b3de4g7h8ij9k2lm3nopqr0stuv1");
    final iv = encrypt.IV.fromUtf8("3xy8zw6v1n0pqrs2");
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(txtToDecrypt, iv: iv);
    String decryptedTxt = decrypted;
    decryptTxt = decryptedTxt;
    emit(AppDecryptNIDState());

    print(decryptTxt);
    return decryptedTxt;
  }

  void activation() {
    db.rawUpdate('UPDATE NoNoDataAdmin SET isActivate = ? WHERE nID = ?', [
      1,
      nIDData,
    ]).then((value) {
      isActive = true;
      getDataAdmin(db);
      emit(AppActivationSuccState());
      getDataAdmin(db);
    });
  }

  Future<void> dropTables() async {
    // Not Used but Helpful
    emit(AppLoadingDataState());

    await db
        .delete('NoNoDataAdmin')
        .then((value) => print('NoNoDataAdmin dropped'));
    await db.delete('NoNoAdmin').then((value) => print('NoNoAdmin dropped'));
    await db.delete('NoNoUser').then((value) => print('NoNoUser dropped'));
  }

  Future<void> dropDataFromTables() async {
    emit(AppLoadingDataState());

    await db
        .execute('DELETE FROM NoNoDataAdmin')
        .then((value) => print('NoNoDataAdmin dropped'));

    await db
        .execute('DELETE FROM NoNoAdmin')
        .then((value) => print('NoNoAdmin dropped'));

    await db
        .execute('DELETE FROM NoNoUser')
        .then((value) => print('NoNoUser dropped'));
  }

  Future<void> reset() async {
    nIDData = null;
    nameData = null;
    usernameData = null;
    passData = null;
    userUsernameData = null;
    userPassData = null;
    isRegData = null;
    isActivateData = null;
    activateKey = null;
    isActive = false;
    isUser = false;
    emit(AppResetDataState());
  }

  void changeLanguage(BuildContext context) async {
    final currentLocale = Localizations.localeOf(context);
    appLocale = currentLocale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');

    prefs?.setString('language', appLocale.languageCode);

    emit(AppChangeLanguageState());
  }
}
