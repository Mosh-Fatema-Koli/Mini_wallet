import 'package:boilerplate_of_cubit/view/Splash/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/services.dart';
import 'core/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DI
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 830),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          home:  SplashPage(),
          title: 'MiniPay Wallet',
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
