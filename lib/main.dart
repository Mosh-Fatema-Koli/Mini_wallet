import 'package:boilerplate_of_cubit/view/Splash/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/services.dart';

import 'data/repositories/theme_change/theme_change_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeRepository = ThemeRepository();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 830),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          home: SplashPage(),
          title: 'Tasks',
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


//stable