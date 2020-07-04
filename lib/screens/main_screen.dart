import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/tabs/home_tab_screen.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

class MainScreen extends StatefulWidget {

  MainScreen({Key key}) : super(key:key);

  @override
  _MainScreenState createState() => _MainScreenState();
  
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30, 
    fontWeight: FontWeight.bold
  );
  
  static List<Widget> _widgetOptions = <Widget> [
    HomeTabScreen(),
    Text(
      'Index 1: Inbox',
      style: optionStyle,
    ),
    Text(
      'Index 2: Personal',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Inbox'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Personal'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}