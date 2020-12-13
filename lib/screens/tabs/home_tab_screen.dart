import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';
import 'package:MTR_flutter/screens/tabs/home/home_content_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/forum_content_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/groups_content_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/members_content_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/home_customize_screen.dart';
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
    with TickerProviderStateMixin {
  TabController controller;
  final ScrollController scrollController = ScrollController();

  final List<String> listItems = [];

  //State management: Forum
  GlobalKey<AnimatedListState> forumPostKey;
  AnimationController forumAnimationController;
  Animation forumInsertAnimation;

  void _onNewPost() {
    print("adding new post");
    Map newPost = {
      'user': 'New Post yooo',
      'title': 'Flocka Bitches',
      'date': '5 months ago',
      'body':
          'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
      'likes': 10,
      'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
    };
    setState(() {
      forumPosts.add(newPost);
    });
  }

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

  Map<String, Function> _tab_widgets = {
    "Home": buildHomeTab,
    "Forum": buildForumTab,
    "Groups": buildGroupsTab,
    "Members": buildMembersTab,
    "Events": buildEventsTab,
    "Services": buildServicesTab,
    "Pricing": buildPricingTab,
    "Content": buildContentTab
  };

  static List<Widget> buildEventsTab(BuildContext context) {
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

  static List<Widget> buildServicesTab(BuildContext context) {
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

  static List<Widget> buildPricingTab(BuildContext context) {
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

  static List<Widget> buildContentTab(BuildContext context) {
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

  void displayNavigationDrawer(Map params) {
    Widget header = Container(height: 1.0);

    Color dividerColor = Colors.grey[200];

    //dart returns null if key doesnt exist in map -- unlike JS which returns 'undefined', ya'll be easy now
    if (null == params['title'] &&
        null == params['description'] &&
        null == params["custom_header"]) {
      dividerColor = Colors.white;
    }

    if (null != params['title'] &&
        null == params['description'] &&
        null == params["custom_header"]) {
      header = Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
        child: Text(
          params['title'],
          style: homeTextStyleBold,
          overflow: TextOverflow.visible,
        ),
      );
    }

    if (null == params['title'] &&
        null != params['description'] &&
        null == params["custom_header"]) {
      header = Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
        child: Text(
          params['description'],
          style: homeSubTextStyle,
          overflow: TextOverflow.visible,
        ),
      );
    }

    if (null != params['title'] &&
        null != params['description'] &&
        null == params["custom_header"]) {
      header = Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              params['title'],
              style: homeTextStyleBold,
              overflow: TextOverflow.visible,
            ),
            Text(
              params['description'],
              style: homeSubTextStyle,
              overflow: TextOverflow.visible,
            )
          ],
        ),
      );
    }

    if (null != params['custom_header']) {
      header = params['custom_header'];
    }

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true, //stops max height being half screen
        context: context,
        builder: (BuildContext context) {
          return Container(
              margin: const EdgeInsets.only(
                  top: 0.0,
                  left: sidePadding,
                  right: sidePadding,
                  bottom: 20.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Wrap(
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 5.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          )),
                    )),
                    header,
                    Divider(
                      thickness: 1.0,
                      color: dividerColor,
                    ),
                    ListView.builder(
                        itemCount: params['options'].length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String optionTitle =
                              params['options'][index]['title'];

                          if (null != params['options'][index]['type'] &&
                              'subtitle' == params['options'][index]['type']) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: sidePadding,
                                right: sidePadding,
                                top: 15.0,
                              ),
                              child: Text(optionTitle,
                                  style: homeSubTextStyle,
                                  overflow: TextOverflow.visible),
                            );
                          }

                          Widget icon = Container(
                            width: 1.0,
                            height: 1.0,
                          ); //placeholder empty space
                          Function onPressed =
                              params['options'][index]['onPressed'];
                          IconData iconData =
                              params['options'][index]['iconData'];

                          if (null != iconData) {
                            icon = Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                iconData,
                                color: Colors.black,
                              ),
                            );
                          }

                          print("iconData: $iconData");

                          return FlatButton(
                            onPressed:
                                onPressed, //passing function definition onPressed and not invoking onPressed().
                            child: Row(
                              children: <Widget>[
                                icon,
                                Text(optionTitle,
                                    style: homeTextStyleBold,
                                    overflow: TextOverflow.visible)
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ));
        });
  }

  //function shared by widget nodes stemming from this widget
  void displayInviteMenu() {
    List options = [
      {
        "iconData": EvaIcons.messageCircleOutline,
        "title": "Send an SMS",
        "onPressed": () {
          print("****************callback function1 called");
        }
      },
      {
        "iconData": EvaIcons.cloudUploadOutline,
        "title": "Share via social and more",
        "onPressed": () {
          print("****************callback function2 called");
        }
      },
      {
        "iconData": EvaIcons.linkOutline,
        "title": "Copy link",
        "onPressed": () {
          print("****************callback function3 called");
        }
      }
    ];

    Map params = {
      "context": context,
      "title": "Invite Members",
      "description": "Invite people to join your space on the app",
      "options": options
    };

    sharedStateManagement['display_navigation_drawer'](params);
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 8,
      vsync: this,
    );

    forumPostKey = GlobalKey<AnimatedListState>();
    forumAnimationController = AnimationController(vsync: this);

    // sharedStateManagement = {
    //   "forum_post_key": forumPostKey,
    //   "forum_animation_controller": forumAnimationController,
    //   "display_navigation_drawer": displayNavigationDrawer
    // };

    //decided to make the sharedStateManagement Map a global variable
    sharedStateManagement['forum_post_key'] = forumPostKey;
    sharedStateManagement['forum_animation_controller'] =
        forumAnimationController;
    sharedStateManagement['display_navigation_drawer'] =
        displayNavigationDrawer;

    sharedStateManagement['hometabscreen_setstate'] = setState;
    sharedStateManagement['display_invite_menu'] = displayInviteMenu;

    //state callback declaration
    stateCallback[screen.homeTab] = setState;
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
                          List options = [
                            {
                              "title": "Admin Actions",
                              "type": "subtitle",
                            },
                            {
                              "iconData": EvaIcons.browserOutline,
                              "title": "Dashboard",
                              "onPressed": () {
                                //takes them to dashboard page, with analytics etc
                                print(
                                    "****************callback function1 called");
                              }
                            },
                            {
                              "iconData": EvaIcons.brushOutline,
                              "title": "Customize",
                              "onPressed": () {
                                print(
                                    "****************callback function2 called");
                              }
                            },
                            {"title": "More Actions", "type": "subtitle"},
                            {
                              "iconData": EvaIcons.personAddOutline,
                              "title": "Invite Members",
                              "onPressed": () {
                                //close this menu
                                Navigator.pop(context);

                                //open invite menue
                                sharedStateManagement['display_invite_menu']();
                              }
                            },
                            {
                              "iconData": EvaIcons.bellOutline,
                              "title": "Manage Notifications",
                              "onPressed": () {
                                print(
                                    "****************callback function3 called");
                              }
                            },
                            {
                              "iconData": EvaIcons.monitorOutline,
                              "title": "Add to Home Screen",
                              "onPressed": () {
                                print(
                                    "****************callback function3 called");
                              }
                            }
                          ];

                          Widget customHeader = Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: sidePadding,
                                right: sidePadding),
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (null != stateCallback[screen.main]) {
                                  stateCallback[screen.main](() {
                                    Navigator.pop(context);
                                    mainScreenState[mainScreen.selectedIndex] =
                                        2;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: avatarWidth,
                                          height: avatarHeight,
                                          margin: const EdgeInsets.only(
                                              right: 15, bottom: 5),
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      avatarRadius)),
                                              image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://randomuser.me/api/portraits/women/69.jpg"),
                                              ))),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Sanliston",
                                            style: homeTextStyleBold,
                                            overflow: TextOverflow.visible,
                                          ),
                                          Text(
                                            "Owner",
                                            style: homeSubTextStyle,
                                            overflow: TextOverflow.visible,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                  //button which takes you to user profile
                                  IconButton(
                                    icon: Icon(
                                      EvaIcons.chevronRightOutline,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      // Take user to their profile page
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                          Map params = {
                            "context": context,
                            "custom_header": customHeader,
                            "options": options
                          };

                          sharedStateManagement['display_navigation_drawer'](
                              params);
                        },
                      )
                    ],
                    flexibleSpace: Stack(
                      children: <Widget>[
                        buildHeaderBackground(homeHeaderHeight, screenWidth),
                        FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: FadeOnScroll(
                            scrollController: scrollController,
                            zeroOpacityOffset: 50,
                            fullOpacityOffset: 0,
                            child: buildHeader(context),
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
                                left: 0.0, right: 0.0, top: 8.0, bottom: 0.0),
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
                                  return _tab_widgets[name](context)[index];
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: _tab_widgets[name](context).length,
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

  Positioned buildHeaderBackground(
      double homeHeaderHeight, double screenWidth) {
    return Positioned.fill(
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
    );
  }

  Padding buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 90.0, left: 20.0, right: 20.0, bottom: 30.0),
      child: SizedBox(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(children: <Widget>[
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
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 10,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            MemberSearchScreen()));
                              },
                              padding: EdgeInsets.all(0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      children: <Widget>[
                                        //use a function to dynamically build this list
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
                                                    image: NetworkImage(
                                                        "https://randomuser.me/api/portraits/women/36.jpg"),
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
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        "https://randomuser.me/api/portraits/women/37.jpg"),
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
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        "https://randomuser.me/api/portraits/women/32.jpg"),
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
                            ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://randomuser.me/api/portraits/women/69.jpg"),
                                        ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              HomeCustomizeScreen()));
                                },
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
                  child: FlatButton(
                    onPressed: () {
                      sharedStateManagement['display_invite_menu']();
                    },
                    padding: EdgeInsets.only(
                        top: 4.0, left: 50.0, right: 50.0, bottom: 4.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red,
                        width: 1.5,
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
    );
  }
}
