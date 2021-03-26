import 'dart:ui';

import 'package:MTR_flutter/components/nav_bars.dart';
import 'package:MTR_flutter/external/hsv_colorpicker.dart';
import 'package:MTR_flutter/screens/templates/template_config.dart';
import 'package:MTR_flutter/state_management/root_template_state.dart';
import 'package:MTR_flutter/screens/templates/basic_screen_template.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/screens/tabs/home_tab_screen.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    HomeTabScreen(),
    BasicScreenTemplate(
      key: GlobalKey(),
      basicScreenTemplateConfig: BasicScreenTemplateConfig(),
    ),
    BasicScreenTemplate(
      key: GlobalKey(),
      basicScreenTemplateConfig: BasicScreenTemplateConfig(
          headerOptions: HeaderOptions(
              topLeftBar: false,
              topRightBar: false,
              titleText: "Search Page ?",
              backgroundStyle: backgroundStyles.solid)),
    ),
    BasicScreenTemplate(
      key: GlobalKey(),
      basicScreenTemplateConfig: BasicScreenTemplateConfig(
          headerOptions: HeaderOptions(
              topLeftBar: false,
              topRightBar: false,
              blurredAppBar: false,
              logoRadius: 100,
              titleText: "Proile Page",
              backgroundStyle: backgroundStyles.gradient)),
    ),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.homeOutline),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.comment),
      title: Text('Inbox'),
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.personOutline),
      title: Text('Personal'),
    ),
  ];

  static List bottomIcons = [
    {"normal": EvaIcons.homeOutline, "selected": EvaIcons.home},
    {
      "normal": EvaIcons.messageCircleOutline,
      "selected": EvaIcons.messageCircle
    },
    {"normal": EvaIcons.personOutline, "selected": EvaIcons.person}
  ];

  IconData homeIcon = bottomIcons[0]["normal"];
  IconData inboxIcon = bottomIcons[1]["normal"];
  IconData personalIcon = bottomIcons[2]["normal"];

  List indexedPageIcons = [
    bottomIcons[0]["normal"],
    bottomIcons[1]["normal"],
    bottomIcons[2]["normal"]
  ];

  bool navBarVisible = !headerSettings[headerOptions.landingPageMode]
              [landingPageMode.active] ||
          persistentNavBar
      ? true
      : false;

  navBar({bool visible, int index}) {
    index = null != index ? index : 0;

    if (persistentNavBar || (1 == index || 2 == index || 3 == index)) {
      return;
    }

    visible = null != visible ? visible : !navBarVisible;

    if (visible == navBarVisible) {
      return;
    }

    setState(() {
      navBarVisible = visible;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      mainScreenState[mainScreen.selectedIndex] = index;

      //uncomment the below to enable icons to be solid when page is selected

      indexedPageIcons = [
        bottomIcons[0]["normal"],
        bottomIcons[1]["normal"],
        bottomIcons[2]["normal"],
      ];

      indexedPageIcons[index] = bottomIcons[index]["selected"];
    });

    toggleNavBar(
        visible: !headerSettings[headerOptions.landingPageMode]
                    [landingPageMode.active] ||
                persistentNavBar
            ? true
            : false,
        index: index);
  }

  void _onNavItemTapped(int index) {
    setState(() {
      mainScreenState[mainScreen.selectedIndex] = index;
    });

    toggleNavBar(
        visible: !headerSettings[headerOptions.landingPageMode]
                    [landingPageMode.active] ||
                persistentNavBar
            ? true
            : false,
        index: index);
  }

  @override
  void initState() {
    super.initState();

//uncomment the below to enable icons to be solid when page is selected
    indexedPageIcons[0] = bottomIcons[0]["selected"];

    //stateCallback declaration
    stateCallback[screen.main] = setState;

    mainScreenState = {mainScreen.selectedIndex: 0};

    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    toggleNavBar = navBar;

    return Stack(children: [
      Center(
        child:
            _widgetOptions.elementAt(mainScreenState[mainScreen.selectedIndex]),
      ),
      Positioned.fill(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedCrossFade(
          firstChild: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 0.0,
            color: secondaryColor,
          ),
          secondChild: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 0.0,
            color: Colors.transparent,
          ),
          duration: Duration(milliseconds: 200),
          crossFadeState: navBarVisible
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      )),
      Positioned(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: navBarVisible
                ? buildBottomNavBar(
                    version: 2,
                    screenHeight: MediaQuery.of(context).size.height)
                : null
            // child: AnimatedCrossFade(
            //   firstChild: Container(
            //     decoration: BoxDecoration(
            //         border: Border(
            //             top: BorderSide(
            //                 color: secondaryColor.withOpacity(0.0), width: 0.5))),
            //     child: SimpleNavBar(onItemTapped: _onItemTapped),
            //   ),
            //   secondChild:
            //       Container(height: 0.0, width: 0.0, color: Colors.transparent),
            //   duration: Duration(milliseconds: 0),
            //   crossFadeState: navBarVisible
            //       ? CrossFadeState.showFirst
            //       : CrossFadeState.showSecond,
            // ),
            ),
      ),
    ]);
  }

  Widget buildBottomNavBar({int version = 0, double screenHeight}) {
    if (version == 1) {
      return SimpleNavBar(onItemTapped: _onItemTapped);
    } else if (version == 2) {
      return LeanNavBar(
        onItemTapped: _onNavItemTapped,
        baseheight: screenHeight * 0.06,
      );
    }

    return ClipRect(
      child: new BackdropFilter(
        filter: new ImageFilter.blur(
            sigmaX: bottomNavSigma, sigmaY: bottomNavSigma),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor:
              darkMode ? Colors.black38 : Colors.grey[300].withOpacity(0.4),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(indexedPageIcons[0]),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(indexedPageIcons[1]),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(indexedPageIcons[2]),
              label: 'Personal',
            ),
          ],
          currentIndex: mainScreenState[mainScreen.selectedIndex],
          selectedItemColor: primaryColor,
          unselectedItemColor: darkMode ? Colors.grey[400] : Colors.black38,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
