import 'dart:async';
import 'package:e_commerce/ui/pages/auth.dart';
import 'package:e_commerce/ui/pages/main_page.dart';
import 'package:e_commerce/ui/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Splashpage();
  }
}

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  bool? isViewed;
  bool? isLogin;

  checkIs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isViewed = pref.getBool("isIntroViewed") ?? false;
    isLogin = pref.getBool("isLogin") ?? false;
  }

  @override
  void initState() {
    checkIs();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => isViewed == true
                ? isLogin == true
                    ? MainPage(pagePosition: 0)
                    : AuthPage(authType: 0)
                : const IntroPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Splash Screen"),
            CircularProgressIndicator(
              color: Colors.red,
            )
          ],
        ),
      ),
    ));
  }
}
