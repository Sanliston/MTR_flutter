import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/tabs/home_tab_screen.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

class HomeContentScreen extends StatefulWidget {
 
  final Function scrollCallback;
  final ScrollController passedController;
  HomeContentScreen({Key key, this.scrollCallback, this.passedController}) : super(key:key);

  @override
  _HomeContentScreenState createState() => _HomeContentScreenState(scrollCallback: scrollCallback, scrollController: passedController);
  
}

class _HomeContentScreenState extends State<HomeContentScreen> {

  final Function scrollCallback;
  final ScrollController scrollController;

  

  _HomeContentScreenState({this.scrollCallback, this.scrollController});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new NotificationListener(
              child: new ListView(
                // padding: EdgeInsets.all(15.0),
                // physics: const NeverScrollableScrollPhysics(), //only up until tab bar is shrunk
                controller: scrollController,
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

              onNotification: (scrollNotification){

                if(scrollNotification is OverscrollNotification){
                  scrollCallback(scrollNotification);
                }
                
                
              },
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