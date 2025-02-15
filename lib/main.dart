import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'apis/app_write.dart';
import 'helper/global.dart';
import 'helper/pref.dart';
import 'screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.initialize();
  AppWrite.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      themeMode: Pref.defaultTheme,

      //dark
      darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            titleTextStyle:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )),
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.purpleAccent,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),

        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.purpleAccent),
      )),
      home: SplashScreen(),
    );
  }
}
extension AppTheme on ThemeData {
  //light text color
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  //button color
  Color get buttonColor =>
      brightness == Brightness.dark ? Colors.purple.withOpacity(.5) : Colors.purpleAccent;
}

