import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';

/*This screen will have several tabs:
  Home
  Forum
  Groups
  Members
  Events
  Services
  Pricing
  Content 
  
  And it will also be housed in a SliverAppBar.
  
  For now, I will use this approach:
  https://gist.github.com/X-Wei/ed1ce793482789c8e9632592b79458f7

  But in the future we can take an approach like this:
  https://medium.com/@diegoveloper/flutter-collapsing-toolbar-sliver-app-bar-14b858e87abe
  */


class HomeTabScreen extends StatefulWidget {

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(
      length: 8,
      vsync: this,
    );
  }

  @override
  Widget build (BuildContext context){

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var homeHeaderHeight = screenHeight*0.5;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            title: Text("More Than Rubies"),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: homeHeaderHeight,
            actionsIconTheme: IconThemeData(opacity: 0.0),
            flexibleSpace: Stack(
              children: <Widget> [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/home_background.jpg",
                    height: homeHeaderHeight,
                    width: screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Padding(
                    padding: const EdgeInsets.only(top: 90.0, left: 10.0, right: 10.0, bottom: 30.0),
                    child: SizedBox(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: <Widget> [
                                  Expanded(
                                    child: Column(
                                      children: <Widget> [
                                        Expanded(child: Placeholder()),
                                        Expanded(child: Placeholder())
                                      ]
                                    ),
                                  ),

                                  Expanded(
                                    child: Placeholder(),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: RaisedButton(
                                  elevation: 0.0,
                                  onPressed: () {
                                    print('invite Button Pressed');
                                    
                                  },
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      color: Color(0xFF527DAA),
                                      letterSpacing: 1.5,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Forum'),
                Tab(text: 'Groups'),
                Tab(text: 'Members'),
                Tab(text: 'Events'),
                Tab(text: 'Services'),
                Tab(text: 'Pricing'),
                Tab(text: 'Content'),
              ],
              controller: controller,
            )
          ),   
          SliverFillRemaining(
            child: TabBarView(
              controller: controller,
              children: <Widget> [
                Center(child: Text("Home")),
                Center(child: Text("Forum")),
                Center(child: Text("Groups")),
                Center(child: Text("Members")),
                Center(child: Text("Events")),
                Center(child: Text("Services")),
                Center(child: Text("Pricing")),
                Center(child: Text("Content")),
              ]
            )
          ),
        ]
      )
    );
  }
}
