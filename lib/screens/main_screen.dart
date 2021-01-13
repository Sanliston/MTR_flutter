import 'package:MTR_flutter/external/hsv_colorpicker.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
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
    Text(
      'Index 2: Personal',
      style: optionStyle,
    ),
    Text(
      'Index 2: Personal',
      style: optionStyle,
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

  bool navBarVisible = persistentNavBar;

  navBar({bool visible, int index}) {
    index = null != index ? index : 0;

    if (persistentNavBar || (1 == index || 2 == index)) {
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
        bottomIcons[2]["normal"]
      ];

      indexedPageIcons[index] = bottomIcons[index]["selected"];
    });

    toggleNavBar(visible: false, index: index);
  }

  @override
  void initState() {
    super.initState();

//uncomment the below to enable icons to be solid when page is selected
    indexedPageIcons[0] = bottomIcons[0]["selected"];

    //stateCallback declaration
    stateCallback[screen.main] = setState;

    mainScreenState = {mainScreen.selectedIndex: 0};
  }

  @override
  Widget build(BuildContext context) {
    toggleNavBar = navBar;

    return Scaffold(
      body: Center(
        child:
            _widgetOptions.elementAt(mainScreenState[mainScreen.selectedIndex]),
      ),
      bottomNavigationBar: AnimatedCrossFade(
        firstChild: BottomNavigationBar(
          backgroundColor: Colors.white,
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
          onTap: _onItemTapped,
        ),
        secondChild:
            Container(height: 0.0, width: 0.0, color: Colors.transparent),
        duration: Duration(milliseconds: 200),
        crossFadeState: navBarVisible
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}
