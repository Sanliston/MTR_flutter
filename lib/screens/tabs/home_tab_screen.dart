import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';
import 'package:MTR_flutter/screens/tabs/home/home_content_screen.dart';
import "dart:math";
import 'package:MTR_flutter/utilities/utility_imports.dart';

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

  SOLUTION TO SCROLL ISSUE: USER NESTEDSCROLLVIEW: used the first answer: https://stackoverflow.com/questions/55187332/flutter-tabbar-and-sliverappbar-that-hides-when-you-scroll-down
  and swapped it with my own SliverAppBar
  */

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final ScrollController scrollController = ScrollController();

  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Home",
    "Forum",
    "Groups",
    "Members",
    "Events",
    "Services",
    "Pricing",
    "Content"
  ];

  Map<String, List> _tab_widgets = {
    "Home": buildHomeTab(),
    "Forum": buildForumTab(),
    "Groups": buildGroupsTab(),
    "Members": buildMembersTab(),
    "Events": buildEventsTab(),
    "Services": buildServicesTab(),
    "Pricing": buildPricingTab(),
    "Content": buildContentTab()
  };

//*********************HOME TAB START***************** */
  //can be dynamically changed, yay
  static List<Map> announcements = [
    {
      'user': 'Jane',
      'title': 'Test',
      'date': '5 months ago',
      'body':
          'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man'
    },
    {
      'user': 'Jane',
      'title': 'Test',
      'date': '1 year ago',
      'body': 'Lorem ipsum etc man'
    },
    {
      'user': 'Jane',
      'title': 'Test',
      'date': '20/10/16',
      'body': 'Lorem ipsum etc man'
    },
    {
      'user': 'Jane',
      'title': 'Test',
      'date': '20/10/12',
      'body': 'Lorem ipsum etc man'
    },
  ];

  static List<Map> membersShortlist = [
    {
      "username": "Jane Ipsum",
      "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
    },
    {
      "username": "Bebe Rxha",
      "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
    },
    {
      "username": "Claire Jojo",
      "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
    },
    {
      "username": "Bebe Reha",
      "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
    },
    {
      "username": "Yolo oi",
      "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
    },
  ];

  //build the home widget Map
  static List<Widget> buildHomeTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */
    List<Widget> widgets = <Widget>[
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 0.0, right: 0.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Announcements',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                Text(
                  'See All',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeLinkTextStyle,
                )
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: announcements.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(
                    top: 0.0, left: 0.0, right: 0.0, bottom: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: avatarWidth,
                              height: avatarHeight,
                              margin:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(avatarRadius)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://randomuser.me/api/portraits/women/69.jpg"),
                                  ))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(announcements[index]['user'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      homeTextStyleBold), //set a global style to be shared
                              SizedBox(
                                  height:
                                      5), //sized box to create space between
                              Text(announcements[index]['date'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: homeSubTextStyle),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                        child: new Text(announcements[index]['body'],
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            style: homeTextStyle),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 0.0, right: 0.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Members',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                Text(
                  'See All',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeLinkTextStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: avatarHeight + 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        if (4 == index) {
                          //return container with overlay
                          return Stack(children: [
                            Container(
                                width: avatarWidth,
                                height: avatarHeight,
                                margin:
                                    const EdgeInsets.only(right: 10, bottom: 5),
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(avatarRadius)),
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          membersShortlist[index]
                                              ["profile_image"]),
                                    ))),
                            Container(
                                width: avatarWidth,
                                height: avatarHeight,
                                margin:
                                    const EdgeInsets.only(right: 10, bottom: 5),
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(avatarRadius)),
                                    color: new Color.fromRGBO(255, 0, 0, 0.5)),
                                child: Center(
                                    child: Text(
                                  "+86",
                                  style: homeTextStyleBoldWhite,
                                ))),
                          ]);
                        } else {
                          return Container(
                              width: avatarWidth,
                              height: avatarHeight,
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 5),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(avatarRadius)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(membersShortlist[index]
                                        ["profile_image"]),
                                  )));
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 10.0),
                  child: new Text(
                      "90 members including " +
                          membersShortlist[0]["username"] +
                          ", " +
                          membersShortlist[1]["username"] +
                          " and " +
                          membersShortlist[2]["username"],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                ),
                RaisedButton(
                  elevation: 0.0,
                  onPressed: () {
                    print('invite Button Pressed');
                  },
                  padding: EdgeInsets.only(
                      top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.red,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'Invite Members',
                    overflow: TextOverflow.visible,
                    style: homeLinkTextStyle,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 0.0, right: 0.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                Text(
                  'View Calendar',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeLinkTextStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
            child: new Text("Nothing upcoming",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: homeSubTextStyle),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, right: 0.0, bottom: 10.0),
            child: Text(
              'Contact Us',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: homeSubtitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
            child: Text(
                "This is a great place to tell members about who you are, what you do and what you can offer them.",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: homeTextStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Get in Touch",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                  Text("Test community",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeSubTextStyle)
                ],
              ),
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  print('invite Button Pressed');
                },
                padding: EdgeInsets.only(
                    top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'Message',
                  overflow: TextOverflow.visible,
                  style: homeLinkTextStyle,
                ),
              )
            ],
          ),
          Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("610QEB",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                  Text("Invite Code",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeSubTextStyle)
                ],
              ),
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  print('invite Button Pressed');
                },
                padding: EdgeInsets.only(
                    top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'Message',
                  overflow: TextOverflow.visible,
                  style: homeLinkTextStyle,
                ),
              )
            ],
          )
        ],
      )
    ];

    return widgets;
  }

  //***********HOMETAB END*********************

  static List<Widget> buildForumTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */
    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildGroupsTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildMembersTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildEventsTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildServicesTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildPricingTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  static List<Widget> buildContentTab() {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    List<Widget> widgets = <Widget>[
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder()),
      SizedBox(height: 150.0, child: Placeholder())
    ];

    return widgets;
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 8,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var homeHeaderHeight = screenHeight * 0.5;

    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                    title: FadeOnScroll(
                        scrollController: scrollController,
                        fullOpacityOffset: homeHeaderHeight * 0.3,
                        zeroOpacityOffset: 0,
                        child: Text("More Than Rubies")),
                    pinned: true,
                    snap: false,
                    forceElevated: true,
                    elevation: 4.0,
                    shadowColor: Colors.black38,
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
                      children: <Widget>[
                        Positioned.fill(
                          child: CustomTabScroll(
                            scrollController: scrollController,
                            zeroOpacityOffset: homeHeaderHeight * 0.6,
                            fullOpacityOffset: 0,
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/home_background.jpg",
                                  height: homeHeaderHeight * 1.1,
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
                                    stops: [0.0, 0.4],
                                    tileMode: TileMode.clamp,
                                  )),
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
                              padding: const EdgeInsets.only(
                                  top: 90.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 30.0),
                              child: SizedBox(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 25.0),
                                                child:
                                                    Column(children: <Widget>[
                                                  Flexible(
                                                      flex: 20,
                                                      child: Text(
                                                        "More than Rubies",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          letterSpacing: 1.5,
                                                          fontSize: 28.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'OpenSans',
                                                        ),
                                                      )),
                                                  Spacer(
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage("https://randomuser.me/api/portraits/women/36.jpg"),
                                                                        ))),
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
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage("https://randomuser.me/api/portraits/women/37.jpg"),
                                                                        ))),
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
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage("https://randomuser.me/api/portraits/women/32.jpg"),
                                                                        ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            "87 Members",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              letterSpacing:
                                                                  1.5,
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  'OpenSans',
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 25.0, bottom: 20.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Spacer(),
                                                    Expanded(
                                                      child: Container(
                                                          decoration:
                                                              new BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8.0)),
                                                                  image:
                                                                      new DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        "https://randomuser.me/api/portraits/women/69.jpg"),
                                                                  ))),
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
                                            padding: EdgeInsets.only(
                                                top: 4.0,
                                                left: 50.0,
                                                right: 50.0,
                                                bottom: 4.0),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.red,
                                                width: 2.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                      tabs:
                          _tabs.map((String name) => Tab(text: name)).toList(),
                      controller: controller,
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: Colors.red,
                    )),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            controller: controller,
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is "inside"
                  // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                  // find the NestedScrollView.
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      child: CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber above.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 8.0, bottom: 0.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.

                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  print(
                                      "build item, index:  $index \n, tab name: $name");

                                  //here we return the corresponding view depending on the given index, so we need to create an array of views to return
                                  /*The array of views will vary depending on the current active tab
                                  tab index is decided by: name 
                                  So we create a map containing the arrays and the views for the relevant tab
                                  And then we index that map using the value of the name variable*/
                                  return _tab_widgets[name][index];
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: _tab_widgets[name].length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
