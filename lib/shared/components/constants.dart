import 'package:el_nono/models/products_admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const Color bg = Colors.deepPurpleAccent;
SharedPreferences? prefs;
Locale appLocale = const Locale('en');
String? thmMode;
late Database db;
String? deviceID;
List<AdminProduct> listOfNewProducts = [];
int? nIDData;
String? nameData;
String? usernameData;
String? passData;
String? userUsernameData;
String? userPassData;
int? isRegData;
int? isActivateData;
String? deviceIdData;
String? activateKey;
bool isActive = isActivateData == 1
    ? deviceID == deviceIdData
        ? true
        : false
    : false;
bool isUser = isRegData == 1 ? true : false;
const String elNoNoMail = "ahmedebrahim1806@gmail.com";
