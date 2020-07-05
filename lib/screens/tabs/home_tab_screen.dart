import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';

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
  final ScrollController scrollController = ScrollController();

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
        controller: scrollController,
        slivers: <Widget> [
          SliverAppBar(
            title: Text("More Than Rubies"),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: homeHeaderHeight,
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(opacity: 0.0),
            flexibleSpace: Stack(
              children: <Widget> [
                Positioned.fill(
                  child: CustomTabScroll(
                    scrollController: scrollController,
                    zeroOpacityOffset: homeHeaderHeight*0.6,
                    fullOpacityOffset: 0,
                    child: Image.asset(
                      "assets/images/home_background.jpg",
                      height: homeHeaderHeight,
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: FadeOnScroll(
                      scrollController: scrollController,
                      zeroOpacityOffset: 50,
                      fullOpacityOffset: 0,
                      child: Padding(
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
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "More than Rubies",
                                              style: TextStyle(
                                                color: Color(0xFF527DAA),
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),
                                            )
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 3,
                                                  child: Stack( 
                                                    children: <Widget>[
                                                      Positioned(
                                                        left: 0.0,
                                                        top: 12.0,
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: new BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: new DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage("https://randomuser.me/api/portraits/women/36.jpg"),
                                                            )
                                                          )
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 20.0,
                                                        top: 12.0,
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: new BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: new DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage("https://randomuser.me/api/portraits/women/37.jpg"),
                                                            )
                                                          )
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 40.0,
                                                        top: 12.0,
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: new BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: new DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage("https://randomuser.me/api/portraits/women/32.jpg"),
                                                            )
                                                          )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    "87 Members",
                                                    style: TextStyle(
                                                      color: Color(0xFF527DAA),
                                                      letterSpacing: 1.5,
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'OpenSans',
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
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
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
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
