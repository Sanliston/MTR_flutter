import 'package:MTR_flutter/external/hsv_colorpicker.dart';
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
    HSVPickerPage(),
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
    return Scaffold(
      body: Center(
        child:
            _widgetOptions.elementAt(mainScreenState[mainScreen.selectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

class HSVPickerPage extends StatefulWidget {
  @override
  HSVPickerPageState createState() => new HSVPickerPageState();
}

class HSVPickerPageState extends State<HSVPickerPage> {
  HSVColor color = new HSVColor.fromColor(Colors.blue);
  void onChanged(HSVColor value) => this.color = value;

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            width: 260,
            child: new Card(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0))),
                elevation: 2.0,
                child: new Padding(
                    padding: const EdgeInsets.all(10),
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: this.color.toColor(),
                          ),
                          new Divider(),

                          ///---------------------------------
                          new HSVPicker(
                            color: this.color,
                            onChanged: (value) =>
                                super.setState(() => this.onChanged(value)),
                          )

                          ///---------------------------------
                        ])))));
  }
}
