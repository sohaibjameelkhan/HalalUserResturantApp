import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halal_food_user_app/Ui/Screens/favourite_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/home_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/profile_screen.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({Key? key}) : super(key: key);

  get menuScreenContext => null;

  @override
  _BottomnavigationState createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      FavouritesScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      ProfileScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        //change bottom naviagtion  icon here if you want
        icon: ImageIcon(AssetImage(Res.homeicon)),
        title: ("Home"),
        activeColorPrimary: MyAppColors.redcolor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(Res.haerticon)),
        title: ("Favorite"),
        activeColorPrimary: MyAppColors.redcolor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => LoginPage(),
            // '/second': (context) => LoginPage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(Res.personicon)),
        title: ("Account"),
        activeColorPrimary: MyAppColors.redcolor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => MainScreen2(),
            // '/second': (context) => MainScreen3(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return Stack(
      children: [
        PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),

            // boxShadow: Colors.black,
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            colorBehindNavBar: Colors.black,
          ),
          popAllScreensOnTapOfSelectedTab: true,

          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style12, //
        ),
      ],
    );
  }
}
