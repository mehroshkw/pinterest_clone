import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'bottom_nav_bloc.dart';
import 'bottom_nav_state.dart';
import 'nav_items/add_screen.dart';
import 'nav_items/home_screen.dart';
import 'nav_items/notifications_screen.dart';
import 'nav_items/search_screen.dart';
import 'nav_items/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const String route = '/main_screen_route';

  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  static const _homeScreenNavigationKey = PageStorageKey(HomeScreen.key_title);
  static const _searchScreenNavigationKey =
      PageStorageKey(SearchScreen.key_title);
  static const _addNavigationKey = PageStorageKey(AddScreen.key_title);
  static const _notificationsKeyNavigationKey =
      PageStorageKey(NotificationScreen.key_title);
  static const _profileKeyNavigationKey =
      PageStorageKey(ProfileScreen.key_title);
  final _bottomMap = <PageStorageKey<String>, Widget>{};

  @override
  void initState() {
    _bottomMap[_homeScreenNavigationKey] =
        HomeScreen(key: _homeScreenNavigationKey);
    _bottomMap[_searchScreenNavigationKey] =
        const SearchScreen(key: _searchScreenNavigationKey);
    _bottomMap[_addNavigationKey] = const AddScreen(key: _addNavigationKey);
    _bottomMap[_notificationsKeyNavigationKey] =
        const NotificationScreen(key: _notificationsKeyNavigationKey);
    _bottomMap[_profileKeyNavigationKey] =
        const ProfileScreen(key: _profileKeyNavigationKey);
    super.initState();
  }

  final _bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Image(
            image: AssetImage('assets/home.png'),
            width: 23,
            height: 26,
            color: AppColours.colorSecondary),
        label: '',
        activeIcon: Image(
            image: AssetImage('assets/home.png'),
            width: 23,
            height: 26,
            color: AppColours.onScaffoldColor)),
    const BottomNavigationBarItem(
        icon: Image(
            image: AssetImage('assets/search.png'),
            width: 26,
            height: 26,
            color: AppColours.colorSecondary),
        label: '',
        activeIcon: Image(
          image: AssetImage('assets/search.png'),
          width: 26,
          height: 26,
          color: AppColours.onScaffoldColor,
        )),
    const BottomNavigationBarItem(
        icon: Image(
            image: AssetImage('assets/add.png'),
            width: 28,
            height: 26,
            color: AppColours.colorSecondary),
        label: '',
        activeIcon: Image(
          image: AssetImage('assets/add.png'),
          width: 28,
          height: 26,
          color: AppColours.onScaffoldColor,
        )),
    const BottomNavigationBarItem(
        icon: Image(
            image: AssetImage('assets/notification.png'),
            width: 28,
            height: 26,
            color: AppColours.colorSecondary),
        label: '',
        activeIcon: Image(
          image: AssetImage('assets/notification.png'),
          width: 28,
          height: 26,
          color: AppColours.onScaffoldColor,
        )),
    const BottomNavigationBarItem(
        icon: Image(
            image: AssetImage('assets/profile_nav.png'),
            width: 26,
            height: 26,
            color: AppColours.colorSecondary),
        label: '',
        activeIcon: Image(
            image: AssetImage('assets/profile_nav.png'),
            width: 26,
            height: 26,
            color: AppColours.onScaffoldColor)),
  ];

  @override
  Widget build(BuildContext context) {
    final sized = context.screenSize;
    final bloc = context.read<BottomNavBloc>();

    return Scaffold(
        key: bloc.scaffoldKey,
        bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (_, state) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  height: 50,
                  color: AppColours.colorOnPrimary,
                  child: BottomNavigationBar(
                      key: bloc.globalKey,
                      onTap: (int newIndex) {
                        if (state.index == newIndex && newIndex != 3) return;
                        final pageStorageKey =
                            _bottomMap.keys.elementAt(newIndex);
                        final bottomItem = _bottomMap[pageStorageKey];
                        if (bottomItem == null || bottomItem is SizedBox) {
                          final newBottomWidget =
                              _getNavigationWidget(newIndex);
                          _bottomMap[pageStorageKey] = newBottomWidget;
                        }
                        bloc.updateIndex(newIndex);
                      },
                      items: _bottomNavItems,
                      currentIndex: state.index,
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: AppColours.scaffoldColor,
                      iconSize: 28,
                      selectedFontSize: 11,
                      unselectedLabelStyle:
                          const TextStyle(color: AppColours.colorSecondary),
                      selectedLabelStyle:
                          const TextStyle(color: AppColours.onScaffoldColor),
                      unselectedFontSize: 11,
                      selectedItemColor: AppColours.onScaffoldColor,
                      unselectedItemColor: AppColours.colorSecondary,
                      showSelectedLabels: true,
                      showUnselectedLabels: true),
                )),
        body: BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (_, state) => IndexedStack(
                index: state.index, children: _bottomMap.values.toList())));
  }

  Widget _getNavigationWidget(int index) {
    switch (index) {
      case 0:
        return HomeScreen(key: _homeScreenNavigationKey);
      case 1:
        return const SearchScreen(key: _searchScreenNavigationKey);
      case 2:
        return const AddScreen(key: _addNavigationKey);
      case 3:
        return const NotificationScreen(key: _notificationsKeyNavigationKey);
      case 4:
        return const ProfileScreen(key: _profileKeyNavigationKey);
      default:
        return const SizedBox();
    }
  }
}
