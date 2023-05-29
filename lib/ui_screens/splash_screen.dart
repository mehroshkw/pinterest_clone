import 'package:flutter/material.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/on_boarding/on_boarding_screen.dart';


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
    const route = OnBoardingScreen.route;
    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
      Navigator.pushNamedAndRemoveUntil(context, OnBoardingScreen.route, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColours.colorOnPrimary),
      child:  Image.asset('assets/pinterest-logo.png', height: size.height/3, width:  size.width/3,),
    );
  }
}
