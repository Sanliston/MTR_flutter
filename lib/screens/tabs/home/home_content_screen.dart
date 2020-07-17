import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/tabs/home_tab_screen.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

class HomeContentScreen extends StatefulWidget {

  HomeContentScreen({Key key}) : super(key:key);

  @override
  _HomeContentScreenState createState() => _HomeContentScreenState();
  
}

class _HomeContentScreenState extends State<HomeContentScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),

                SizedBox(
                  height: 150.0,
                  child: Placeholder()
                ),
              ],

            ),
          ),


          Positioned.fill( //This will be the pop up screen
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.3,
                widthFactor: 0.8,
                child: Placeholder()
              ),
            ),
          ),


        ]
      )
    );
  }
}