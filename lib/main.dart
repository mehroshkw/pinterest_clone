import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/network_provider/photos_model.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_screen.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/singup_screen.dart';
import 'package:pinterest_clone/ui_screens/category/category_bloc.dart';
import 'package:pinterest_clone/ui_screens/category/category_screen.dart';
import 'package:pinterest_clone/ui_screens/category/category_state.dart';
import 'package:pinterest_clone/ui_screens/image_view/image_view_bloc.dart';
import 'package:pinterest_clone/ui_screens/image_view/image_view_screen.dart';
import 'package:pinterest_clone/ui_screens/image_view/myImages.dart';
import 'package:pinterest_clone/ui_screens/img_full_screen_view/img_full_screen_view.dart';
import 'package:pinterest_clone/ui_screens/img_full_screen_view/img_full_view_bloc.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_bloc.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_screen.dart';
import 'package:pinterest_clone/ui_screens/on_boarding/on_boarding_screen.dart';
import 'package:pinterest_clone/ui_screens/splash_screen.dart';
import '/utils/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const _colorScheme = ColorScheme(
    primary: AppColours.colorPrimary,
    primaryContainer: AppColours.colorPrimaryVariant,
    secondary: AppColours.colorSecondary,
    secondaryContainer: AppColours.colorSecondaryVariant,
    surface: AppColours.colorSurface,
    background: AppColours.colorBackground,
    error: AppColours.colorError,
    onPrimary: AppColours.colorOnPrimary,
    onSecondary: AppColours.colorOnSecondary,
    onSurface: AppColours.colorOnSecondary,
    onBackground: AppColours.colorOnBackground,
    onError: AppColours.colorOnError,
    brightness: Brightness.light);

ThemeData _buildAppThemeData() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: AppColours.colorPrimary,
      unselectedWidgetColor: AppColours.colorOnIcon,
      scaffoldBackgroundColor: AppColours.scaffoldColor,
      colorScheme: _colorScheme.copyWith(error: AppColours.colorError));
}

class _AppRouter {
  Route _getPageRoute(Widget screen) => Platform.isIOS
      ? CupertinoPageRoute(builder: (_) => screen)
      : MaterialPageRoute(builder: (_) => screen);

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        {
          const screen = SplashScreen();
          return _getPageRoute(screen);
        }
      case OnBoardingScreen.route:
        {
          final screen = OnBoardingScreen();
          return _getPageRoute(screen);
        }
      case BottomNavScreen.route:
        {
          const screen = BottomNavScreen();
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => BottomNavBloc(), child: screen));
        }
      case ImageViewScreen.route:
        {
          final imgPath = settings.arguments as Photo;
          final screen = ImageViewScreen(
            photo: imgPath,
          );
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => ImageViewBloc(), child: screen));
        }
      case ImageFullViewScreen.route:
        {
          final imgPath = settings.arguments as String;
          final screen = ImageFullViewScreen(
            imgPath: imgPath,
          );
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => ImageFullViewBloc(), child: screen));
        }
      case CategoryScreen.route:
        {
          final category = settings.arguments as String;
          final screen = CategoryScreen(
            category: category,
          );
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => CategoryBloc(), child: screen));
        }
      case SignupScreen.route:
        {
          const screen = SignupScreen();
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => SignupBloc(), child: screen));
        }
        case LoginScreen.route:
        {
          const screen = LoginScreen();
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => LoginBloc(), child: screen));
        }  case MyImageViewScreen.route:
        {
          final  photo = settings.arguments as String;
          final screen = MyImageViewScreen(photo: photo,);
          return MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(create: (_) => ImageViewBloc(), child: screen));
        }
    }
    return null;
  }

  void dispose() {}
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _AppRouter __appRouter = _AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppText.APP_NAME,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: __appRouter.onGenerateRoute,
        theme: _buildAppThemeData());
  }

  @override
  void dispose() {
    __appRouter.dispose();
    super.dispose();
  }
}

//https://github.com/Tukhtamurodov-Sardorbek/27.Pinterest_Clone_App?ref=flutterawesome.com ==> pinterest clone github link
// https://flutterawesome.com/pinterest-clone-app-built-with-flutter/  ==> website link
// https://www.figma.com/file/H6izImjxBxLiM8cZbjHZoI/Pinterest-site-(Community)?type=design&node-id=15-55&t=J0Uto5maOdKguGwh-0  ==> ui
