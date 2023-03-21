import 'package:e_commerce/ui/pages/intro_page.dart';
import 'package:e_commerce/ui/pages/splash_creen.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashPage(),
          MyRoutes.splashRoute: (context) => const SplashPage(),
          MyRoutes.introRoute: (context) => const IntroPage(),
        });
  }
}
