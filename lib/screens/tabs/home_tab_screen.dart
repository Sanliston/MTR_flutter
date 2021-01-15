import 'dart:collection';
import 'dart:ui';

import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/announcements_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/forum_posts_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_preview_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';

import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/home_customize_screen.dart';
import "dart:math";
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  ScrollController scrollController;
  final List<String> listItems = [];
  //State management: Forum
  GlobalKey<AnimatedListState> forumPostKey;
  AnimationController forumAnimationController;
  Animation forumInsertAnimation;
  List<String> _tabs;
  Color unselectedLabelColor;
  bool landingPage;

  List<Widget> buildTab(BuildContext context, String tab) {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

    if (null == contentLayouts[tab]) {
      tab = "default";
    }

    List<Widget> widgets = <Widget>[];

    List components = contentLayouts[tab];

    for (var i = 0; i < components.length; i++) {
      //ADD components to build list
      Widget component = sectionMap[components[i]]();

      widgets.add(component);
    }

    return widgets;
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

    displayNavigationDrawer(context, params);
  }

  void onTabTap() {}

  void onTabDrag(int index) {
    String name = _tabs[index];

    if ("AddTabButton" == name) {
      //stop event execution
      int index = controller.previousIndex;
      setState(() {
        controller.index = index;
      });
    }
  }

  void scrollControllerHandler() {
    double offset = scrollController.offset;
    double maxOffset = scrollController.position.maxScrollExtent;

    if (!scrollController.position.isScrollingNotifier.value &&
        offset == maxOffset) {
      print("Setting unselectedLabel color to black");
      setState(() {
        unselectedLabelColor = Colors.black38;
      });
    }
  }

  void indexChangeListener() {
    if (controller.indexIsChanging) {
      onTabTap();
    } else if (controller.index != controller.previousIndex) {
      // Tab Changed swiping to a new tab
      onTabDrag(controller.index);
    }
  }

  @override
  void initState() {
    super.initState();

    //get the configured tab list

    _tabs = isAdmin ? homeAdminTabList : homeTabList;
    unselectedLabelColor = Colors.white;

    //set controller list based on obtained list
    controller = TabController(
      length: _tabs.length,
      vsync: this,
    );

    print("init state called");
    //persistent tab index stored from last time
    print("#######selectedHomeTab: $selectedHomeTab");
    int index = _tabs.indexOf(selectedHomeTab);

    print("########index of tab: $index");

    if (-1 < index) {
      controller.animateTo(index);
    }

    //event handlers for when tab is changed via swipe or tap
    controller.addListener(indexChangeListener);

    //scroll controller
    scrollController = new ScrollController();

    //assign listener event to scroll controller
    scrollController.addListener(scrollControllerHandler);

    //decided to make the sharedStateManagement Map a global variable
    sharedStateManagement['display_navigation_drawer'] =
        displayNavigationDrawer;

    sharedStateManagement['hometabscreen_setstate'] = setState;
    sharedStateManagement['display_invite_menu'] = displayInviteMenu;

    //state callback declaration
    stateCallback[screen.homeTab] = setState;

    //pass build functions to headerBuilders
    headerBuilders['preview_background'] = buildPreviewHeaderBackground;
    headerBuilders['header'] = buildHeader;
    headerBuilders['tagline'] = buildHeaderTagLine;
    headerBuilders['place_logo'] = buildHeaderPlaceLogo;
    headerBuilders['member_preview'] = buildHeaderMemberPreview;
    headerBuilders['invite_button'] = buildHeaderInviteButton;
    headerBuilders['custom_button'] = buildHeaderCustomButton;

    landingPage = contentLayouts['header'][headerOptions.landingPageMode]
        [landingPageMode.active];
  }

  @override
  void dispose() {
    super.dispose();
    stateCallback[screen.homeTab] = null;
    controller.removeListener(indexChangeListener);
    scrollController.removeListener(scrollControllerHandler);

    controller.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double landingPageHeight =
        persistentNavBar ? screenHeight : screenHeight + 58;

    var minimumHeaderHeight = landingPage
        ? landingPageHeight
        : 340.0; //default value: 340.0, this can be set by the user in settings - to add a full screen effect to the header
    var screenHeightFactor = landingPage
        ? 1.0
        : 0.5; //can also be set by the user -- when screen height factor > 0.7 or 0.8 then the header will have a different layout
    var homeHeaderHeight =
        minimumHeaderHeight > screenHeight * screenHeightFactor
            ? minimumHeaderHeight
            : screenHeight * screenHeightFactor;

    print("header height: $homeHeaderHeight");

    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            //store context so it can be used in customFunctions that want it
            sharedStateManagement['screenHeight'] = screenHeight;
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
                    stretch: true,
                    onStretchTrigger: () {
                      print("stretch event triggered");
                    },
                    title: FadeOnScroll(
                        scrollController: scrollController,
                        fullOpacityOffset: landingPage
                            ? homeHeaderHeight * 0.6
                            : homeHeaderHeight * 0.3,
                        zeroOpacityOffset: 0,
                        child: Text("More Than Rubies")),
                    pinned: true,
                    snap: false,
                    forceElevated: true,
                    elevation: contentLayouts['header']
                        [headerOptions.shadowHeight],
                    shadowColor: accentColor,
                    floating: false,
                    expandedHeight: homeHeaderHeight,
                    backgroundColor: contentLayouts['header']
                        [headerOptions.appBarColor],
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
                                Navigator.pop(context);
                              }
                            },
                            {
                              "iconData": EvaIcons.brushOutline,
                              "title": "Customize",
                              "onPressed": () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            HomeCustomizeScreen()));
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
                                Navigator.pop(context);
                              }
                            },
                            {
                              "iconData": UniconsLine.mobile_android,
                              "title": "Add to Home Screen",
                              "onPressed": () {
                                Navigator.pop(context);
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
                                                image: AssetImage(
                                                    'assets/images/profile_images/default_user.png'),
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

                          displayNavigationDrawer(context, params);
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
                            zeroOpacityOffset: landingPage ? 300 : 50,
                            fullOpacityOffset: 0,
                            child: landingPage
                                ? buildExpHeader(context)
                                : buildHeader(
                                    context), //Just proof of concept that you can have a swiper here
                          ),
                        ),
                      ],
                    ),
                    bottom: buildTabBar(context)),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            controller: controller,
            physics: BouncingScrollPhysics(),
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
                        physics: BouncingScrollPhysics(),
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

                                  //set the selectedHomeTab state variable
                                  selectedHomeTab = name;

                                  print(
                                      "build item, index:  $index \n, tab name: $name");

                                  //here we return the corresponding view depending on the given index, so we need to create an array of views to return
                                  /*The array of views will vary depending on the current active tab
                                tab index is decided by: name 
                                So we create a map containing the arrays and the views for the relevant tab
                                And then we index that map using the value of the name variable*/
                                  return buildTab(context, name)[index];
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: contentLayouts[name].length,
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

  Widget buildExpHeader(BuildContext context) {
    //this is like this for demonstration
    //actual Exp header will be built using a builder of some sort
    //this will allow the user to configure what elements they want etc
    //like with the tabs
    List<Widget> slides = [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 100.0, left: sidePadding, right: sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(UniconsLine.cloud_computing, color: Colors.white, size: 200),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Welcome",
                    style: GoogleFonts.heebo(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 44,
                            color: Colors.white))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                child: Text(
                    "Make yourself at home. This is your landing page, your space. You can turn it into whatever you want. Swipe left, swipe up, or swipe right. The possibilities are endless.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.heebo(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.white))),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 40.0, top: 90),
        child: Column(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(sidePadding),
              child: new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: SizedBox(
                      height: 350,
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: buildHeader(context),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      // Stack(
      //   children: <Widget>[
      //     Image.asset(
      //       "assets/images/home_background.jpg",
      //       height: MediaQuery.of(context).size.height + 100,
      //       width: MediaQuery.of(context).size.width,
      //       fit: BoxFit.cover,
      //     ),
      //     Container(
      //       decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //         colors: [
      //           Colors.black38,
      //           Colors.transparent,
      //         ],
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomRight,
      //         stops: [0.0, 0.4],
      //         tileMode: TileMode.clamp,
      //       )),
      //     ),
      //     new Center(
      //       child: new ClipRect(
      //         child: new BackdropFilter(
      //           filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      //           child: new Container(
      //             width: 300.0,
      //             height: 200.0,
      //             decoration: new BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 color: Colors.grey.shade200.withOpacity(0.1)),
      //             child: new Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: new Text(
      //                   'This is an example of an announcement or something.',
      //                   style: homeTextStyleBoldWhite,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      // buildHeader(context),
    ];

    Widget swiper = Padding(
        padding: EdgeInsets.only(bottom: 80),
        child: new Swiper(
          itemCount: slides.length,
          pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: new DotSwiperPaginationBuilder(
                color: Colors.grey[300].withOpacity(0.3),
                activeColor: primaryColor),
          ),
          itemBuilder: (context, index) {
            return slides[index];
          },
        ));

    return swiper;
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      labelPadding:
          EdgeInsets.only(top: 0.0, bottom: 0.0, left: 5.0, right: 5.0),
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      tabs: _tabs.map((String name) {
        Widget widget = Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.transparent, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(name),
              ),
            ),
          ),
        );

        if ("AddTabButton" == name) {
          widget = Icon(
            EvaIcons.plusCircle,
            color: Colors.white,
          );
        }

        return widget;
      }).toList(),
      controller: controller,
      labelColor: contentLayouts['header'][headerOptions.appBarColor],
      unselectedLabelColor: unselectedLabelColor,
      indicatorColor: contentLayouts['header'][headerOptions.appBarColor],
      indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      onTap: (index) {
        String name = _tabs[index];

        if ("AddTabButton" == name) {
          //stop event execution
          int index = controller.previousIndex;
          setState(() {
            controller.index = index;
          });

          //do stuff with button here
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => HomeCustomizeScreen()));
        }
      },
    );
  }

  Positioned buildPreviewHeaderBackground(
      double homeHeaderHeight, double screenWidth,
      {bool memberViewMode = false,
      Color gradientFirstColor,
      Color gradientSecondColor,
      Color gradientThirdColor,
      Color diagonalBarColor,
      GradientOrientations gradientOrientation = GradientOrientations.diagonal,
      backgroundStyles backgroundStyle,
      bool diagonalBarShadow,
      double diagonalBarShadowBlurRadius,
      double diagonalBarShadowLift,
      double diagonalMaxOpacity,
      bool topLeftBar,
      bool topRightBar,
      bool bottomLeftBar,
      bool bottomRightBar}) {
    backgroundStyle = null != backgroundStyle
        ? backgroundStyle
        : contentLayouts["header"][headerOptions.backgroundStyle];
    diagonalBarColor = null != diagonalBarColor
        ? diagonalBarColor
        : contentLayouts["header"][headerOptions.diagonalBarColor];
    double heightFactor = 0.6;

    diagonalBarShadow = null != diagonalBarShadow
        ? diagonalBarShadow
        : contentLayouts["header"][headerOptions.diagonalBarShadow];

    diagonalBarShadowBlurRadius = null != diagonalBarShadowBlurRadius
        ? diagonalBarShadowBlurRadius
        : contentLayouts["header"][headerOptions.diagonalBarShadowBlurRadius];
    diagonalBarShadowLift = null != diagonalBarShadowLift
        ? diagonalBarShadowLift
        : contentLayouts["header"][headerOptions.diagonalBarShadowLift];

    diagonalMaxOpacity = null != diagonalMaxOpacity
        ? diagonalMaxOpacity
        : contentLayouts["header"][headerOptions.diagonalMaxOpacity];

    topLeftBar = null != topLeftBar
        ? topLeftBar
        : contentLayouts["header"][headerOptions.topLeftBar];

    topRightBar = null != topRightBar
        ? topRightBar
        : contentLayouts["header"][headerOptions.topRightBar];

    bottomLeftBar = null != bottomLeftBar
        ? bottomLeftBar
        : contentLayouts["header"][headerOptions.bottomLeftBar];

    bottomRightBar = null != bottomRightBar
        ? bottomRightBar
        : contentLayouts["header"][headerOptions.bottomRightBar];

    //setting default bars until when i create the landing page settings page
    if (landingPage) {
      topLeftBar = true;
      topRightBar = true;
      bottomLeftBar = true;
      bottomRightBar = true;
    }

    //default background style
    Positioned widget = Positioned.fill(
      child: SizedBox(
        width: screenWidth,
        height: homeHeaderHeight * heightFactor,
        child: Container(color: primaryColor),
      ),
    );

    homeHeaderHeight = null != homeHeaderHeight
        ? homeHeaderHeight
        : MediaQuery.of(context).size.height * heightFactor;

    print("preview header background style: $backgroundStyle");

    switch (backgroundStyle) {
      case backgroundStyles.diagonalLine:
        widget = Positioned.fill(
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
        );
        break;

      case backgroundStyles.image:
        widget = Positioned.fill(
          child: SizedBox(
            width: screenWidth,
            height: homeHeaderHeight * heightFactor,
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
        break;

      case backgroundStyles.imageDiagonalLine:
        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            diagonalLine: true,
            fixedMode: true,
            color: diagonalBarColor,
            shadow: diagonalBarShadow,
            shadowBlurRadius: diagonalBarShadowBlurRadius,
            shadowLift: diagonalBarShadowLift,
            maxOpacity: diagonalMaxOpacity,
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            child: SizedBox(
              width: screenWidth,
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
        );
        break;

      case backgroundStyles.gradient:
        widget = Positioned.fill(
          child: SizedBox(
              width: screenWidth,
              height: homeHeaderHeight * heightFactor,
              child: Container(
                decoration: BoxDecoration(
                    gradient: getGradient(
                        gradientFirstColor: gradientFirstColor,
                        gradientSecondColor: gradientSecondColor,
                        gradientThirdColor: gradientThirdColor,
                        gradientOrientation: gradientOrientation)),
              )),
        );
        break;

      case backgroundStyles.gradientDiagonalLine:
        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            diagonalLine: true,
            fixedMode: true,
            color: diagonalBarColor,
            shadow: diagonalBarShadow,
            shadowBlurRadius: diagonalBarShadowBlurRadius,
            shadowLift: diagonalBarShadowLift,
            maxOpacity: diagonalMaxOpacity,
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            child: Stack(
              children: <Widget>[
                SizedBox(
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: getGradient(
                              gradientFirstColor: gradientFirstColor,
                              gradientSecondColor: gradientSecondColor,
                              gradientThirdColor: gradientThirdColor,
                              gradientOrientation: gradientOrientation)),
                    )),
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
        break;

      default:
    }

    return widget;
  }

  //TODO: update this with all the changes to match the previewHeaderBackground function
  /*What's the difference between the two?
  
  The preview header has no snap functionality and no scroll events 
  
  The diagonal line has no CustomTabScroll parent in preview,
  
  So you'll need to be careful when updating headerBackground to match preview background*/
  Positioned buildHeaderBackground(double homeHeaderHeight, double screenWidth,
      {bool memberViewMode = false,
      Color gradientFirstColor,
      Color gradientSecondColor,
      Color gradientThirdColor,
      Color diagonalBarColor,
      GradientOrientations gradientOrientation = GradientOrientations.diagonal,
      backgroundStyles backgroundStyle,
      bool diagonalBarShadow,
      double diagonalBarShadowBlurRadius,
      double diagonalBarShadowLift,
      double diagonalMaxOpacity,
      bool topLeftBar,
      bool topRightBar,
      bool bottomLeftBar,
      bool bottomRightBar}) {
    backgroundStyle = null != backgroundStyle
        ? backgroundStyle
        : contentLayouts["header"][headerOptions.backgroundStyle];
    diagonalBarColor = null != diagonalBarColor
        ? diagonalBarColor
        : contentLayouts["header"][headerOptions.diagonalBarColor];
    double heightFactor = 0.6;

    diagonalBarShadow = null != diagonalBarShadow
        ? diagonalBarShadow
        : contentLayouts["header"][headerOptions.diagonalBarShadow];

    diagonalBarShadowBlurRadius = null != diagonalBarShadowBlurRadius
        ? diagonalBarShadowBlurRadius
        : contentLayouts["header"][headerOptions.diagonalBarShadowBlurRadius];
    diagonalBarShadowLift = null != diagonalBarShadowLift
        ? diagonalBarShadowLift
        : contentLayouts["header"][headerOptions.diagonalBarShadowLift];

    diagonalMaxOpacity = null != diagonalMaxOpacity
        ? diagonalMaxOpacity
        : contentLayouts["header"][headerOptions.diagonalMaxOpacity];

    topLeftBar = null != topLeftBar
        ? topLeftBar
        : contentLayouts["header"][headerOptions.topLeftBar];

    topRightBar = null != topRightBar
        ? topRightBar
        : contentLayouts["header"][headerOptions.topRightBar];

    bottomLeftBar = null != bottomLeftBar
        ? bottomLeftBar
        : contentLayouts["header"][headerOptions.bottomLeftBar];

    bottomRightBar = null != bottomRightBar
        ? bottomRightBar
        : contentLayouts["header"][headerOptions.bottomRightBar];

    //setting default bars until when i create the landing page settings page
    if (landingPage) {
      topLeftBar = true;
      topRightBar = true;
      bottomLeftBar = true;
      bottomRightBar = true;
    }

    print(
        "Build Header background called ***********************************************************************************");

    homeHeaderHeight = null != homeHeaderHeight
        ? homeHeaderHeight
        : MediaQuery.of(context).size.height * 0.5;

    print("background style: $backgroundStyle");

    //default background style
    Positioned widget = Positioned.fill(
      child: SizedBox(
          width: screenWidth,
          height: homeHeaderHeight * heightFactor,
          child: Container(color: primaryColor)),
    );

    switch (backgroundStyle) {
      case backgroundStyles.diagonalLine:
        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            diagonalLine: true,
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
        break;

      case backgroundStyles.image:
        widget = Positioned.fill(
          child: SizedBox(
            width: screenWidth,
            height: homeHeaderHeight * heightFactor,
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
        break;

      case backgroundStyles.imageDiagonalLine:
        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            diagonalLine: true,
            fixedMode: false,
            blurBackground: false,
            color: diagonalBarColor,
            shadow: diagonalBarShadow,
            shadowBlurRadius: diagonalBarShadowBlurRadius,
            shadowLift: diagonalBarShadowLift,
            child: SizedBox(
              width: screenWidth,
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
        );
        break;

      case backgroundStyles.gradient:
        Widget gradient = Positioned.fill(
          child: SizedBox(
              width: screenWidth,
              height: homeHeaderHeight * heightFactor,
              child: Container(
                decoration: BoxDecoration(
                    gradient: contentLayouts['header']
                        [headerOptions.backgroundGradient]),
              )),
        );

        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: SizedBox(
                      width: screenWidth,
                      height: homeHeaderHeight * heightFactor,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: contentLayouts['header']
                                [headerOptions.backgroundGradient]),
                      )),
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
        break;

      case backgroundStyles.gradientDiagonalLine:
        widget = Positioned.fill(
          child: CustomTabScroll(
            scrollController: scrollController,
            zeroOpacityOffset: homeHeaderHeight * heightFactor,
            fullOpacityOffset: 0,
            diagonalLine: true,
            fixedMode: false,
            color: diagonalBarColor,
            shadow: diagonalBarShadow,
            shadowBlurRadius: diagonalBarShadowBlurRadius,
            shadowLift: diagonalBarShadowLift,
            maxOpacity: diagonalMaxOpacity,
            child: Stack(
              children: <Widget>[
                SizedBox(
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: getGradient(
                              gradientFirstColor: gradientFirstColor,
                              gradientSecondColor: gradientSecondColor,
                              gradientThirdColor: gradientThirdColor,
                              gradientOrientation: gradientOrientation)),
                    )),
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
        break;

      default:
    }

    return widget;
  }

  Padding buildHeader(BuildContext context,
      {bool memberViewMode = false,
      double sizeFactor = 1.0,
      bool placeLogo,
      bool tagLine,
      bool memberPreview,
      bool customButton,
      bool inviteButton,
      Color titleColor,
      Color tagLineColor}) {
    placeLogo = null != placeLogo
        ? placeLogo
        : contentLayouts['header'][headerOptions.placeLogo];

    tagLine = null != tagLine
        ? tagLine
        : contentLayouts['header'][headerOptions.tagLine];

    memberPreview = null != memberPreview
        ? memberPreview
        : contentLayouts['header'][headerOptions.memberPreview];

    customButton = null != customButton
        ? customButton
        : contentLayouts['header'][headerOptions.customButton];

    inviteButton = null != inviteButton
        ? inviteButton
        : contentLayouts['header'][headerOptions.inviteButton];

    titleColor = null != titleColor
        ? titleColor
        : contentLayouts['header'][headerOptions.titleColor];
    tagLineColor = null != tagLineColor
        ? tagLineColor
        : contentLayouts['header'][headerOptions.tagLineColor];

    double paddingTop = 90.0 * sizeFactor;
    double paddingLeft = 20.0 * sizeFactor;
    double paddingRight = 20.0 * sizeFactor;
    double paddingBottom =
        memberViewMode ? 0.0 * sizeFactor : 30.0 * sizeFactor;

    double innerPaddingTop = 25.0 * sizeFactor;

    double titleFontSize = 22.0 * sizeFactor;
    double titleSpacing = 1.5 * sizeFactor;

    if (placeLogo) {
      return Padding(
        padding: EdgeInsets.only(
            top: paddingTop,
            left: paddingLeft,
            right: paddingRight,
            bottom: paddingBottom),
        child: SizedBox(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: innerPaddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                    flex: 20,
                                    child: Text(
                                      "More than Rubies",
                                      style: TextStyle(
                                        color: titleColor,
                                        letterSpacing: titleSpacing,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    )),
                                Spacer(
                                  flex: 1,
                                ),
                                headerBuilders['tagline'](
                                    sizeFactor: sizeFactor,
                                    tagLine: tagLine,
                                    color: tagLineColor),
                                Expanded(
                                    flex: 10,
                                    child: headerBuilders['member_preview'](
                                        context,
                                        sizeFactor: sizeFactor,
                                        memberPreview: memberPreview))
                              ]),
                        ),
                      ),
                      headerBuilders['place_logo'](context,
                          sizeFactor: sizeFactor, placeLogo: placeLogo)
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0 * sizeFactor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headerBuilders['invite_button'](
                              sizeFactor: sizeFactor,
                              inviteButton: inviteButton),
                          headerBuilders['custom_button'](
                              sizeFactor: sizeFactor,
                              customButton: customButton)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            top: paddingTop,
            left: paddingLeft,
            right: paddingRight,
            bottom: paddingBottom),
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(top: innerPaddingTop),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 20,
                              child: Text(
                                "More than Rubies",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: titleSpacing,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          headerBuilders['tagline'](
                              sizeFactor: sizeFactor,
                              tagLine: tagLine,
                              color: tagLineColor),
                          Expanded(
                            flex: 10,
                            child: headerBuilders['member_preview'](context,
                                sizeFactor: sizeFactor,
                                memberPreview: memberPreview),
                          )
                        ]),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0 * sizeFactor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          headerBuilders['invite_button'](
                              sizeFactor: sizeFactor,
                              inviteButton: inviteButton),
                          headerBuilders['custom_button'](
                              sizeFactor: sizeFactor,
                              customButton: customButton)
                        ],
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

  Widget buildHeaderTagLine({sizeFactor: 1.0, bool tagLine, Color color}) {
    tagLine = null != tagLine
        ? tagLine
        : contentLayouts['header'][headerOptions.tagLine];
    Widget widget = Container(height: 1.0, width: 2.0);

    if (tagLine) {
      widget = Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Text(
          "This is the length of this tag line ,text past the comma and including the comma is therefore not shown",
          maxLines: 1,
          textAlign: TextAlign.start,
          style: GoogleFonts.heebo(
              textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 11 * sizeFactor,
                  color: color)),
        ),
      );
    }
    return widget;
  }

  Widget buildHeaderCustomButton({sizeFactor: 1.0, bool customButton}) {
    customButton = null != customButton
        ? customButton
        : contentLayouts['header'][headerOptions.customButton];
    Widget widget = Container(height: 1.0, width: 1.0);

    if (customButton) {
      widget = SizedBox(
        height: 25.0 * sizeFactor,
        child: FlatButton(
          onPressed: () {
            sharedStateManagement['display_invite_menu']();
          },
          padding: EdgeInsets.only(
              top: 0.0 * sizeFactor,
              left: 15.0 * sizeFactor,
              right: 15.0 * sizeFactor,
              bottom: 0.0 * sizeFactor),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0 * sizeFactor),
          ),
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  EvaIcons.brushOutline,
                  color: Colors.white,
                  size: 18.0 * sizeFactor,
                ),
              ),
              Text(
                'Custom',
                overflow: TextOverflow.clip,
                style: GoogleFonts.heebo(
                    textStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5 * sizeFactor,
                  fontSize: 11.0 * sizeFactor,
                  fontWeight: FontWeight.normal,
                )),
              ),
            ],
          ),
        ),
      );
    }
    return widget;
  }

  Widget buildHeaderInviteButton({sizeFactor: 1.0, bool inviteButton}) {
    inviteButton = null != inviteButton
        ? inviteButton
        : contentLayouts['header'][headerOptions.inviteButton];

    Widget widget = Container(height: 1.0, width: 1.0);

    if (inviteButton) {
      widget = Padding(
        padding: EdgeInsets.only(right: 20.0 * sizeFactor),
        child: SizedBox(
          height: 25.0 * sizeFactor,
          child: FlatButton(
            onPressed: () {
              sharedStateManagement['display_invite_menu']();
            },
            padding: EdgeInsets.only(
                top: 0.0 * sizeFactor,
                left: 15.0 * sizeFactor,
                right: 15.0 * sizeFactor,
                bottom: 0.0 * sizeFactor),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(30.0 * sizeFactor),
            ),
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      EvaIcons.personAddOutline,
                      color: Colors.white,
                      size: 18.0 * sizeFactor,
                    ),
                  ),
                  Text(
                    'Invite',
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.heebo(
                        textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5 * sizeFactor,
                      fontSize: 11.0 * sizeFactor,
                      fontWeight: FontWeight.normal,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return widget;
  }

  Widget buildHeaderPlaceLogo(BuildContext context,
      {sizeFactor: 1.0, bool placeLogo}) {
    placeLogo = null != placeLogo
        ? placeLogo
        : contentLayouts['header'][headerOptions.placeLogo];
    Widget widget = Container();

    double radius = 8.0;

    switch (contentLayouts['header'][headerOptions.logoShape]) {
      case logoShape.square:
        radius = contentLayouts['header'][headerOptions.logoRadius];
        break;
      case logoShape.circle:
        radius = 150;
        break;
      default:
    }

    if (placeLogo) {
      widget = Expanded(
        child: Padding(
          padding:
              EdgeInsets.only(top: 0.0 * sizeFactor, bottom: 0.0 * sizeFactor),
          child: FlatButton(
            padding: EdgeInsets.zero,
            child: Container(
                height: 100.0 * sizeFactor,
                width: 100.0 * sizeFactor,
                decoration: new BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius * sizeFactor)),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/profile_images/default_user.png'),
                    ))),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => HomeCustomizeScreen()));
            },
          ),
        ),
      );
    }

    return widget;
  }

  Widget buildHeaderMemberPreview(BuildContext context,
      {sizeFactor: 1.0, bool memberPreview}) {
    memberPreview = null != memberPreview
        ? memberPreview
        : contentLayouts['header'][headerOptions.memberPreview];
    Widget widget = Container(height: 1.0, width: 1.0);

    if (memberPreview) {
      widget = FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MemberSearchScreen()));
        },
        padding: EdgeInsets.all(0),
        child: Container(
          width: 200.0 * sizeFactor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    //use a function to dynamically build this list
                    Positioned(
                      left: 0.0,
                      // top: 5.0 * sizeFactor,
                      child: Container(
                          width: 20 * sizeFactor,
                          height: 20 * sizeFactor,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/profile_images/user3.jpg'),
                              ))),
                    ),
                    Positioned(
                      left: 15.0 * sizeFactor,
                      // top: 5.0 * sizeFactor,
                      child: Container(
                          width: 20 * sizeFactor,
                          height: 20 * sizeFactor,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/profile_images/default_user.png'),
                              ))),
                    ),
                    Positioned(
                      left: 30.0 * sizeFactor,
                      // top: 5.0 * sizeFactor,
                      child: Container(
                          width: 20 * sizeFactor,
                          height: 20 * sizeFactor,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/profile_images/user2.jpg'),
                              ))),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  "87 Members",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5 * sizeFactor,
                    fontSize: 11.0 * sizeFactor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return widget;
  }
}
