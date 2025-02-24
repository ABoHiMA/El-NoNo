import 'package:device_info_plus/device_info_plus.dart';
import 'package:el_nono/admin/cubit/admin_cubit.dart';
import 'package:el_nono/shared/bloc/bloc-observer.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:el_nono/shared/ui/layout/welcome.dart';
import 'package:el_nono/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await windowManager.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  appLocale = Locale(prefs?.getString('language') ?? 'en');

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1450, 730),
    size: Size(1450, 730),
    // center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
  deviceID = windowsInfo.deviceId;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..createNoNoData(),
        ),
        BlocProvider(
          create: (context) => AdminCubit()..getNewProducts(db),
        ),
        BlocProvider(
          create: (context) => UserCubit()..getProducts(db),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            restorationScopeId: "El NoNo",
            title: 'El NoNo',
            locale: appLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const WelcomeNoNo(),
          );
        },
      ),
    );
  }
}
