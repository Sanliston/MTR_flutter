import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';
import 'package:MTR_flutter/screens/tabs/home/home_content_screen.dart';

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


  NotificationListerner: https://stackoverflow.com/questions/54065354/how-to-detect-scroll-position-of-listview-in-flutter
  */


class HomeTabScreen extends StatefulWidget {

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with SingleTickerProviderStateMixin{

  TabController controller;
  final ScrollController scrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();
  bool topBarLock = false; 

  @override
  void initState(){
    super.initState();
    controller = TabController(
      length: 8,
      vsync: this,
    );
  }

  void scrollManipulation(OverscrollNotification scrollNotification){

      var offset = _childScrollController.offset;

      print("child scroll notifi, offset: $offset");

      if(_childScrollController.offset < 5.0){
        topBarLock = false;
      }

      if(topBarLock==false){
        print("topBarLock is false");
        //scrollController.jumpTo(offset);
      }
  }

  void scrollHandler(double pixels){

    
    print("scroll initiated, pixels: $pixels");
  }

  @override
  Widget build (BuildContext context){

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var homeHeaderHeight = screenHeight*0.5;

    return Scaffold(
      body: new NotificationListener(
        child: new CustomScrollView(
          controller: scrollController,
          slivers: <Widget> [
            SliverAppBar(
              title: FadeOnScroll(
                scrollController: scrollController,
                fullOpacityOffset: homeHeaderHeight*0.3,
                zeroOpacityOffset: 0,
                child: Text("More Than Rubies")
              ),
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: homeHeaderHeight,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(opacity: 1.0),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
              flexibleSpace: Stack(
                children: <Widget> [
                  Positioned.fill(
                    child: CustomTabScroll(
                      scrollController: scrollController,
                      zeroOpacityOffset: homeHeaderHeight*0.6,
                      fullOpacityOffset: 0,
                      child: Stack(
                        children: <Widget>[

                          Image.asset(
                            "assets/images/home_background.jpg",
                            height: homeHeaderHeight*1.1,
                            width: screenWidth,
                            fit: BoxFit.cover,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black38,
                                  Colors.transparent,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.0, 
                                  0.4
                                ],
                                tileMode: TileMode.clamp,
                              )
                            ),
            
                          ),
                        ],
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
                        padding: const EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0, bottom: 30.0),
                        child: SizedBox(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget> [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 25.0),
                                          child: Column(
                                            children: <Widget> [
                                              Flexible(
                                                flex: 20,
                                                child: Text(
                                                  "More than Rubies",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    letterSpacing: 1.5,
                                                    fontSize: 28.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                )
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 10,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                            left: 0.0,
                                                            top: 5.0,
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
                                                            top: 5.0,
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
                                                            top: 5.0,
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
                                                      flex: 5,
                                                      child: Text(
                                                        "87 Members",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          letterSpacing: 1.5,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.normal,
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
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Spacer(),
                                              Expanded(
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                    image: new DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage("https://randomuser.me/api/portraits/women/69.jpg"),
                                                    )
                                                  )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                    
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RaisedButton(

                                      elevation: 0.0,
                                      onPressed: () {
                                        print('invite Button Pressed');
                                        
                                      },
                                      padding: EdgeInsets.only(top: 4.0, left: 50.0, right: 50.0, bottom: 4.0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.red,
                                          width: 2.2,
                                        ),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: 15,
                                          maxWidth: 70, 
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.add,
                                              color: Colors.red,
                                              size: 14.0,
                                            ),
                                            Text(
                                              'Invite',
                                              style: TextStyle(
                                                color: Colors.red,
                                                letterSpacing: 1.5,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),
                                            ),
                                          ],
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
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.red,
              )
            ),   
            SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                controller: controller,
                children: <Widget> [
                  HomeContentScreen(scrollCallback: scrollManipulation, passedController: _childScrollController),
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
        ),

        onNotification: (scrollNotification){

          if(scrollNotification is OverscrollNotification){

            var parentOffset = scrollController.offset;
            print("parent offset: $parentOffset");
            if(scrollController.offset > 360.0){
              topBarLock = true;
            }

            if(topBarLock){
              print("***************Topbarlock is true");
              //scrollController.jumpTo(370.0);
            }

            var overscroll = scrollNotification.overscroll;
            var velocity = scrollNotification.velocity;
            print("overscroll, start listview scrolling, value: $overscroll");
            print("velocity: $velocity");

            var original = _childScrollController.offset;
            var newOffset = original+overscroll;
            //_childScrollController.jumpTo(newOffset);

            //for the reverse
            

          }

          
        },
      )
    );
  }
}
