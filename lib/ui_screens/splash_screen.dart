import 'package:flutter/material.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/on_boarding/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigaton/bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
      checkUserLoggedIn().then((isLoggedIn) {
        if (isLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavScreen.route, (_) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, OnBoardingScreen.route, (_) => false);
        }
      });
    });
  }

  Future<bool> checkUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString("email");
    return email != null && email.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColours.colorOnPrimary),
      child: Image.asset(
        'assets/pinterest-logo.png',
        height: size.height / 3,
        width: size.width / 3,
      ),
    );
  }
}
