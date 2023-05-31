import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_screen.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/singup_screen.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import 'package:pinterest_clone/utils/app_strings.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_screen.dart';
import '../reusable_widgets/app_button.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String route = '/onboarding';

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.7,
              child: GridView.custom(
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  pattern: [
                    const WovenGridTile(1),
                    const WovenGridTile(
                      3 / 5,
                      crossAxisRatio: 1.0,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: imageUrls.length,
                  (context, index) => ImageBox(url: imageUrls[index]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/pinterest-logo.png',
                height: 100,
                width: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 10),
              child: Text(
                AppText.WELCOME,
                style:
                    TextStyle(fontFamily: AppFonts.helveticaBold, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 45,
              width: size.width / 1.2,
              child: AppButton(
                text: AppText.SIGN_UP,
                onClick: () {
                  Navigator.pushNamed(context, SignupScreen.route);
                },
                color: AppColours.colorPrimary,
                textColor: AppColours.colorOnPrimary,
                fontFamily: AppColours.helveticaBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.route);
              },
              child: const Text(
                AppText.LOGIN,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColours.onScaffoldColor,
                  fontFamily: AppColours.helveticaBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> imageUrls = [
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
  ];
}

class ImageBox extends StatelessWidget {
  final String url;
   Widget? widget;

  ImageBox({required this.url, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
