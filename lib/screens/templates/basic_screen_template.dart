import 'dart:collection';
import 'dart:ui';

import 'package:MTR_flutter/components/animated_cliprrect.dart';
import 'package:MTR_flutter/components/background_video.dart';
import 'package:MTR_flutter/components/inner_shadow.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/screens/tabs/home/landing_page/landing_page.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/announcements_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/forum_posts_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_preview_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';

import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/home_customize_screen.dart';
import "dart:math";
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'navigation_systems/tab_navigation.dart';

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

class BasicScreenTemplate extends StatefulWidget {
  final String videoSource;

  BasicScreenTemplate({this.videoSource});

  @override
  _BasicScreenTemplateState createState() => _BasicScreenTemplateState();
}

class _BasicScreenTemplateState extends State<BasicScreenTemplate>
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
  Color toolBarIconColor;
  int _currentTabIndex;

  TabBarStyle _selectedTabBarStyle;
  TabBarStyle _unselectedTabBarStyle;
  Color _selectedTabBarColor;
  Color _unselectedTabBarColor;
  Color _tabBarSelectedFontColor;
  Color _tabBarUnselectedFontColor;
  bool _expanded;
  double screenHeight;
  double screenWidth;
  bool appBarVisible;

  void tabControllerCb(index) {
    print("--.////------///---------tab controller cb called index: $index");
    setState(() {
      controller.index = index;
    });
  }

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

  toggleToolBarIconColor({bool expanded}) {
    if (_expanded == expanded) {
      //acts as a litmus test, to stop the rest executing
      return;
    }

    Color newIconColor = null != expanded && expanded
        ? toolBarExpandedIconsColor
        : toolBarFontColor;

    TabBarStyle newSelectedTabBarStyle = selectedTabBarStyle;
    TabBarStyle newUnselectedTabBarStyle = unselectedTabBarStyle;
    Color newSelectedTabBarColor = selectedTabBarColor;
    Color newUnselectedTabBarColor = unselectedTabBarColor;
    Color newTabBarSelectedFontColor = tabBarSelectedFontColor;
    Color newTabBarUnselectedFontColor = tabBarUnselectedFontColor;

    if (!expanded) {
      newSelectedTabBarStyle = cSelectedTabBarStyle;
      newUnselectedTabBarStyle = cUnselectedTabBarStyle;
      newSelectedTabBarColor = cSelectedTabBarColor;
      newUnselectedTabBarColor = cUnselectedTabBarColor;
      newTabBarSelectedFontColor = cTabBarSelectedFontColor;
      newTabBarUnselectedFontColor = cTabBarUnselectedFontColor;
    }

    // if (_selectedTabBarStyle == newSelectedTabBarStyle) {
    //   return;
    // }

    setState(() {
      toolBarIconColor = newIconColor;
      print("====/==== /= toolbarIconColor: $toolBarIconColor");

      // _selectedTabBarStyle = newSelectedTabBarStyle;
      // _unselectedTabBarStyle = newUnselectedTabBarStyle;
      // _selectedTabBarColor = newSelectedTabBarColor;
      // _unselectedTabBarColor = newUnselectedTabBarColor;
      // _tabBarSelectedFontColor = newTabBarSelectedFontColor;
      // _tabBarUnselectedFontColor = newTabBarUnselectedFontColor;

      _expanded = expanded;

      print("set state selected tabbar style: $selectedTabBarStyle");
    });
  }

  void onTabTap() {}

  void onTabDrag(int index) {
    String name = _tabs[index];

    print("====/=====/=== ontabdrag called, name: $name");
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
    print("========/=======/====//=== index change listener called ");

    // if (controller.indexIsChanging) {
    //   onTabTap();
    // } else if (controller.index != controller.previousIndex) {
    //   // Tab Changed swiping to a new tab
    //   //onTabDrag(controller.index);
    //   print("====/====/===== index changed via swiper");
    // }

    //set state for index change here
    setState(() {
      _currentTabIndex = controller.index;
    });
  }

  Color getAppBarColor() {
    Color color = Colors.transparent;

    color = contentLayouts['header'][headerOptions.blurredAppBar]
        ? Colors.transparent
        : contentLayouts['header'][headerOptions.appBarColor];

    switch (appBarStyle) {
      case AppBarStyle.material:
        // color = _expanded ? primaryColor : Colors.transparent;
        break;

      case AppBarStyle.rounded:
        color = Colors.transparent;
        break;
    }

    return color;
  }

  toggleLandingPage() {
    if (_expanded) {
      //animate to unexpanded position
      scrollController
          .animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 250), curve: Curves.decelerate)
          .then((value) {
        setState(() {
          landingPage = !landingPage;
          scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.ease);

          contentLayouts['header'][headerOptions.landingPageMode]
              [landingPageMode.active] = landingPage;
        });

        toggleNavBar(visible: !landingPage);
        customTabScrollUpdate(landingPage);
      });
    } else {
      setState(() {
        landingPage = !landingPage;
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 500), curve: Curves.ease);

        contentLayouts['header'][headerOptions.landingPageMode]
            [landingPageMode.active] = landingPage;
      });

      toggleNavBar(visible: !landingPage);
      customTabScrollUpdate(landingPage);
    }
  }

  @override
  void initState() {
    super.initState();

    //get the configured tab list

    _tabs = homeTabList;
    _currentTabIndex = 0;
    unselectedLabelColor = Colors.black38;
    _selectedTabBarStyle = selectedTabBarStyle;
    _unselectedTabBarStyle = unselectedTabBarStyle;
    _selectedTabBarColor = selectedTabBarColor;
    _unselectedTabBarColor = unselectedTabBarColor;
    _tabBarSelectedFontColor = tabBarSelectedFontColor;
    _tabBarUnselectedFontColor = tabBarUnselectedFontColor;
    _expanded = true;
    appBarVisible = true;

    //set controller list based on obtained list
    controller = TabController(
      length: _tabs.length,
      vsync: this,
    );

    updateTabController = () {
      setState(() {
        _tabs = homeTabList;
        controller = TabController(
          length: _tabs.length,
          vsync: this,
        );
      });

      print(
          "------------------updateTabController called, controller length: ${controller.length} and tab bar length: ${_tabs.length}");
    };

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

    toggleTBIconColors = toggleToolBarIconColor;
    leadingTabButtonAction = toggleLandingPage;
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double landingPageHeight =
        persistentNavBar ? screenHeight : screenHeight + 40;

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

    //set maximum home header height
    double maxHomeHeaderHeight = landingPage ? screenHeight + 100 : 350;
    homeHeaderHeight = homeHeaderHeight > maxHomeHeaderHeight
        ? maxHomeHeaderHeight
        : homeHeaderHeight;

    //THESE VALUES ARE STRICTLY FOR THE LANDINGPAGE SWITCH TAB BUTTON
    runtimeHome[HOMETABRT.heightFactor] = !landingPage ? 1.0 : 0.5;
    runtimeHome[HOMETABRT.minimumHeight] =
        !landingPage ? landingPageHeight : 340.0;
    runtimeHome[HOMETABRT.screenHeight] = screenHeight;
    runtimeHome[HOMETABRT.headerHeight] = runtimeHome[HOMETABRT.minimumHeight] >
            screenHeight * runtimeHome[HOMETABRT.heightFactor]
        ? runtimeHome[HOMETABRT.minimumHeight]
        : screenHeight * runtimeHome[HOMETABRT.heightFactor];

    print("header height: $homeHeaderHeight");
    updateSizeFactor(screenHeight);

    print("......................building again = landing page? $landingPage");
    print("......................homeHeaderHeight? $homeHeaderHeight");

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: bodyBackground,
        extendBodyBehindAppBar: false,
        body: NestedScrollView(
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
                    pinned: true,
                    snap: false,
                    forceElevated: true,
                    floating: collapsableToolBar,
                    toolbarHeight: appBarVisible ? 45 : 0,
                    // collapsedHeight: null,
                    leading: buildLeadingIconButton(),
                    automaticallyImplyLeading: false,
                    stretch: true,
                    onStretchTrigger: () {
                      print("stretch event triggered");
                    },
                    title: buildAppBarTitle(homeHeaderHeight),
                    elevation: contentLayouts['header']
                        [headerOptions.shadowHeight],
                    shadowColor: accentColor,
                    expandedHeight: homeHeaderHeight,
                    backgroundColor: getAppBarColor(),
                    actionsIconTheme: IconThemeData(opacity: 1.0),
                    actions: buildAppBarActions(context),
                    flexibleSpace: buildFlexibleSpace(
                        screenHeight, screenWidth, homeHeaderHeight, context),
                    bottom: HomeTabBar(
                      tabs: _tabs,
                      controller: controller,
                      scrollController: scrollController,
                      tabBarSelectedFontColor: _tabBarSelectedFontColor,
                      tabBarUnselectedFontColor: _tabBarUnselectedFontColor,
                      tabControllerCb: tabControllerCb,
                      selectedTabBarColor: _selectedTabBarColor,
                      selectedTabBarStyle: _selectedTabBarStyle,
                    )),
              ),
            ];
          },
          body: buildTabBarView(),
        ),
      ),
    );
  }

  Widget buildTabBarView() {
    Widget tabBarView = TabBarView(
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
                color: bodyBackground,
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
                    // SliverOverlapInjector(
                    //   // This is the flip side of the SliverOverlapAbsorber above.
                    //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    //       context),
                    // ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 8.0, bottom: 100.0),
                      // In this example, the inner scroll view has
                      // fixed-height list items, hence the use of
                      // SliverFixedExtentList. However, one could use any
                      // sliver widget here, e.g. SliverList or SliverGrid.
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // This builder is called for each child.

                            //set the selectedHomeTab state variable
                            selectedHomeTab = name;

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
    );

    Widget view = tabBarView;

    switch (bodyStyle) {
      case BodyStyle.halfTop:
        view = Container(
          color: halfTopColor,
          child: Padding(
            padding: EdgeInsets.only(
                top: collapsableToolBar
                    ? 85
                    : halfTopBodyShadow
                        ? 130.0
                        : 120.0,
                left: 0.0,
                right: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: _expanded && !bodyHalfTopFixed
                    ? BorderRadius.zero
                    : halfTopBorderRadius,
                boxShadow: halfTopBodyShadow
                    ? <BoxShadow>[
                        BoxShadow(
                            color: halfTopBodyShadowColor,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 0.0))
                      ]
                    : null,
              ),
              child: AnimatedClipRRect(
                duration: Duration(milliseconds: 400),
                borderRadius: _expanded && !bodyHalfTopFixed
                    ? BorderRadius.zero
                    : halfTopBorderRadius,
                child: Container(
                  child: Stack(children: [
                    tabBarView,
                    Container(
                      width: screenWidth,
                      height: 10,
                      decoration: BoxDecoration(
                        boxShadow: halfTopInnerBodyShadow && !_expanded
                            ? <BoxShadow>[
                                BoxShadow(
                                    color: halfTopInnerBodyShadowColor,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, -4.0))
                              ]
                            : null,
                      ),
                    )
                  ]),
                  decoration: BoxDecoration(

                      // color: Colors.grey[200],

                      borderRadius: _expanded && !bodyHalfTopFixed
                          ? BorderRadius.zero
                          : halfTopBorderRadius),
                ),
              ),
            ),
          ),
        );
        break;
      default:
        view = TabBarView(
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
                    color: bodyBackground,
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
                              left: 0.0, right: 0.0, top: 8.0, bottom: 100.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                // This builder is called for each child.

                                //set the selectedHomeTab state variable
                                selectedHomeTab = name;

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
        );
        ;
    }

    return view;
  }

  Widget buildFlexibleSpace(double screenHeight, double screenWidth,
      double homeHeaderHeight, BuildContext context) {
    Widget coreWidget = Stack(
      children: <Widget>[
        contentLayouts['header'][headerOptions.blurredAppBar] && tabBarBlurGlow
            ? Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: screenHeight,
                    width: screenWidth - 0,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            tabBarGlowColor,
                            tabBarGlowColor.withOpacity(0.2),
                            Colors.white.withOpacity(0.0)
                          ]),
                      borderRadius: BorderRadius.circular(0),
                    )),
              )
            : Container(),
        contentLayouts['header'][headerOptions.blurredAppBar] && tabBarLabelGlow
            ? Align(
                alignment: Alignment.bottomCenter,
                child: HomeTabBar(
                  tabs: _tabs,
                  controller: controller,
                  tabBarSelectedFontColor: _tabBarSelectedFontColor,
                  tabBarUnselectedFontColor: _tabBarUnselectedFontColor,
                  tabControllerCb: tabControllerCb,
                  selectedTabBarColor: selectedTabBarColor,
                  selectedTabBarStyle: selectedTabBarStyle,
                ))
            : Container(), //so there's a bleeding effect
        contentLayouts['header'][headerOptions.blurredAppBar] &&
                !_expanded //for performance reasons
            ? ClipRect(
                child: new BackdropFilter(
                    filter: new ImageFilter.blur(
                        sigmaX: tabBarBlurSigma, sigmaY: tabBarBlurSigma),
                    child: Container(
                        height:
                            homeHeaderHeight, //needs to be this height so it covers screen and doesnt cut in half when transitioning
                        color: tabBarBlurOverlayColor
                            .withOpacity(tabBarBlurOverlayOpacity))))
            : Container(height: 1.0),
        contentLayouts['header'][headerOptions.blurredAppBar] && tabBarBlurHue
            ? Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: screenHeight,
                    width: screenWidth - 0,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            tabBarGlowColor,
                            Colors.white.withOpacity(0.0)
                          ]),
                      borderRadius: BorderRadius.circular(0),
                    )),
              )
            : Container(),
        buildHeaderBackground(homeHeaderHeight, screenWidth),
        FlexibleSpaceBar(
          collapseMode: appBarCollapseMode,
          background: FadeOnScroll(
            scrollController: scrollController,
            zeroOpacityOffset: landingPage ? screenHeight - 150 : 50,
            fullOpacityOffset: 0,
            child: landingPage
                ? buildExpHeader(context) //LandingPage()
                : buildHeader(
                    context), //Just proof of concept that you can have a swiper here
          ),
        ),
      ],
    );

    Widget widget;

    switch (appBarStyle) {
      case AppBarStyle.material:
        widget = coreWidget;

        break;

      case AppBarStyle.rounded:
        widget = coreWidget;
        break;
      default:
        widget = coreWidget;
    }

    return widget;
  }

  Widget buildAppBarTitle(double homeHeaderHeight) {
    Widget widget;

    switch (appBarStyle) {
      case AppBarStyle.material:
        widget = collapsableToolBar
            ? Container()
            : FadeOnScroll(
                scrollController: scrollController,
                fullOpacityOffset: landingPage
                    ? homeHeaderHeight * 0.6
                    : homeHeaderHeight * 0.3,
                zeroOpacityOffset: 0,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      contentLayouts['header'][headerOptions.titleText],
                      style: GoogleFonts.lobster(
                          textStyle: TextStyle(
                              color: toolBarIconColor,
                              fontWeight: FontWeight.bold,
                              fontSize: appBarTitleFontSize)),
                    )));
        break;

      case AppBarStyle.rounded:
        widget = Container();
        break;

      default:
        widget = collapsableToolBar
            ? Container()
            : FadeOnScroll(
                scrollController: scrollController,
                fullOpacityOffset: landingPage
                    ? homeHeaderHeight * 0.6
                    : homeHeaderHeight * 0.3,
                zeroOpacityOffset: 0,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      contentLayouts['header'][headerOptions.titleText],
                      style: GoogleFonts.lobster(
                          textStyle: TextStyle(
                              color: toolBarIconColor,
                              fontWeight: FontWeight.bold,
                              fontSize: appBarTitleFontSize)),
                    )));
    }

    return widget;
  }

  Widget buildLeadingIconButton() {
    bool leadingButton = true;

    switch (appBarStyle) {
      case AppBarStyle.material:
        break;

      case AppBarStyle.rounded:
        leadingButton = false;
        break;
    }

    return leadingButton
        ? IconButton(
            icon: Icon(
              EvaIcons.arrowIosBackOutline,
              color:
                  collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                      ? Colors.white
                      : toolBarIconColor,
            ),
            onPressed: () {
              // do something
            },
          )
        : null;
  }

  List<Widget> buildAppBarActions(BuildContext context) {
    List<Widget> list = [];

    //declaring here as it will be used multiple times
    List<Widget> rounded = [
      Container(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.only(
              left: sidePadding, right: sidePadding, top: 5.0, bottom: 0.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: _expanded ? Colors.transparent : primaryColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        EvaIcons.arrowIosBackOutline,
                        color:
                            collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                ? Colors.white
                                : toolBarIconColor,
                      ),
                      onPressed: () {
                        // do something
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, right: 0),
                      child: Text(
                        contentLayouts['header'][headerOptions.titleText],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: IconButton(
                        icon: Icon(
                          EvaIcons.bell,
                          color:
                              collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                  ? Colors.white
                                  : toolBarIconColor,
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                    ),
                    buildAppBarMenuButton(context),
                  ],
                ),
              ),
            ),
          ]),
        ),
      )
    ];

    switch (appBarStyle) {
      case AppBarStyle.material:
        list = [
          collapsableToolBar
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 15, right: sidePadding + 5),
                  child: Text(
                    contentLayouts['header'][headerOptions.titleText],
                    style: TextStyle(
                        fontSize: appBarTitleFontSize, color: Colors.white),
                  ),
                )
              : Container(),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: IconButton(
              icon: Icon(
                EvaIcons.bell,
                color:
                    collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                        ? Colors.white
                        : toolBarIconColor,
              ),
              onPressed: () {
                // do something
              },
            ),
          ),
          buildAppBarMenuButton(context)
        ];
        break;

      case AppBarStyle.rounded:
        list = rounded;
        break;

      case AppBarStyle.roundedTop:
        list = [
          Container(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: sidePadding, right: sidePadding, top: 5.0, bottom: 5.0),
              child: Row(children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45)),
                        color: _expanded ? Colors.transparent : primaryColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.arrowIosBackOutline,
                            color:
                                collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                    ? Colors.white
                                    : toolBarIconColor,
                          ),
                          onPressed: () {
                            // do something
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 0),
                          child: Text(
                            contentLayouts['header'][headerOptions.titleText],
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                            icon: Icon(
                              EvaIcons.bell,
                              color:
                                  collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                      ? Colors.white
                                      : toolBarIconColor,
                            ),
                            onPressed: () {
                              // do something
                            },
                          ),
                        ),
                        buildAppBarMenuButton(context),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ];
        break;

      case AppBarStyle.roundedBottom:

        /*Same as rounded because the change is actually made in custom_tab_scroll,
      as the concerned background element exceeds the natural app bar, and goes offscreen. Go look
      in the method getLandingPageAppBar in custom_tab_scroll.dart */
        list = rounded;
        break;

      case AppBarStyle.halfTop:

        /*Same as material because the change is actually made in custom_tab_scroll,
      as the concerned background element exceeds the natural app bar, and goes offscreen. Go look
      in the method getLandingPageAppBar in custom_tab_scroll.dart */
        list = [
          collapsableToolBar
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 15, right: sidePadding + 5),
                  child: Text(
                    contentLayouts['header'][headerOptions.titleText],
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                )
              : Container(),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: IconButton(
              icon: Icon(
                EvaIcons.bell,
                color:
                    collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                        ? Colors.white
                        : toolBarIconColor,
              ),
              onPressed: () {
                // do something
              },
            ),
          ),
          buildAppBarMenuButton(context)
        ];
        break;

      case AppBarStyle.rectangle:
        list = [
          Container(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: sidePadding, right: sidePadding, top: 5.0, bottom: 5.0),
              child: Row(children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _expanded ? Colors.transparent : primaryColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.arrowIosBackOutline,
                            color:
                                collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                    ? Colors.white
                                    : toolBarIconColor,
                          ),
                          onPressed: () {
                            // do something
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 0),
                          child: Text(
                            contentLayouts['header'][headerOptions.titleText],
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                            icon: Icon(
                              EvaIcons.bell,
                              color:
                                  collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                                      ? Colors.white
                                      : toolBarIconColor,
                            ),
                            onPressed: () {
                              // do something
                            },
                          ),
                        ),
                        buildAppBarMenuButton(context),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ];

        break;

      default:
        list = [
          collapsableToolBar
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 15, right: sidePadding + 5),
                  child: Text(
                    contentLayouts['header'][headerOptions.titleText],
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                )
              : Container(),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: IconButton(
              icon: Icon(
                EvaIcons.bell,
                color:
                    collapsableToolBar //icons always visible if toolbar collapsable, disappear when expanded if not
                        ? Colors.white
                        : toolBarIconColor,
              ),
              onPressed: () {
                // do something
              },
            ),
          ),
          buildAppBarMenuButton(context)
        ];
    }
    return list;
  }

  AnimatedContainer buildAppBarMenuButton(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: IconButton(
        icon: Icon(
          EvaIcons.menu,
          color: toolBarFontColor,
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
                        builder: (context) => HomeCustomizeScreen()));
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
                top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (null != stateCallback[screen.main]) {
                  stateCallback[screen.main](() {
                    Navigator.pop(context);
                    mainScreenState[mainScreen.selectedIndex] = 2;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: avatarWidth,
                          height: avatarHeight,
                          margin: const EdgeInsets.only(right: 15, bottom: 5),
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(avatarRadius)),
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/profile_images/default_user.png'),
                              ))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
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
      Padding(
        padding: const EdgeInsets.only(bottom: 40.0, top: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(sidePadding),
              child: new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: SizedBox(
                      height: 120,
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: Padding(
                          padding: const EdgeInsets.all(sidePadding),
                          child: Text(
                              "This is an example landing page widget. Maybe an announcement or something goes here.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.heebo(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(sidePadding),
              child: new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: SizedBox(
                      height: 120,
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: Padding(
                          padding: const EdgeInsets.all(sidePadding),
                          child: Text(
                              "This is an example landing page widget. Maybe an announcement or something goes here.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.heebo(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(sidePadding),
              child: new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: SizedBox(
                      height: 120,
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: Padding(
                          padding: const EdgeInsets.all(sidePadding),
                          child: Text(
                              "This is an example landing page widget. Maybe an announcement or something goes here.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.heebo(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/home_background.jpg",
            height: MediaQuery.of(context).size.height + 100,
            width: MediaQuery.of(context).size.width,
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
          new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: new Container(
                  width: 300.0,
                  height: 200.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200.withOpacity(0.1)),
                  child: new Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'This is an example of an announcement or something.',
                        style: homeTextStyleWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/home_background_2.jpg",
            height: MediaQuery.of(context).size.height + 100,
            width: MediaQuery.of(context).size.width,
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
          new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: new Container(
                  width: 300.0,
                  height: 200.0,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200.withOpacity(0.1)),
                  child: new Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'This is an example of an announcement or something.',
                        style: homeTextStyleWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/home_background_3.jpg",
            height: MediaQuery.of(context).size.height + 150,
            width: MediaQuery.of(context).size.width,
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
          Padding(
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
          )
        ],
      ),
      // buildHeader(context),
    ];

    Widget swiper = Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: new Swiper(
          itemCount: slides.length,
          pagination: new SwiperPagination(
            alignment: Alignment(0.0, 0.9),
            builder: new DotSwiperPaginationBuilder(
                activeSize: 15.0,
                color: Colors.grey[300].withOpacity(0.3),
                activeColor: primaryColor),
          ),
          itemBuilder: (context, index) {
            return slides[index];
          },
        ));

    return swiper;
  }

  buildSelectedTabStyle({Color color, TabBarStyle tabBarStyle}) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: color);

    switch (tabBarStyle) {
      case TabBarStyle.halfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.inverseHalfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.border:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: color, width: 1),
            color: Colors.transparent);
        break;

      case TabBarStyle.fullRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color);
        break;

      case TabBarStyle.traditional:
        return UnderlineTabIndicator(
            borderSide: BorderSide(color: color, width: 4.0));
        break;

      case TabBarStyle.dot:
        return CircleTabIndicator(color: color, radius: 5.0);
        break;

      case TabBarStyle.bubble:
        return BubbleTabIndicator(color: color);
        break;

      case TabBarStyle.square:
        return BubbleTabIndicator(color: color, bubbleRadius: 5.0);
        break;

      case TabBarStyle.hoverLine:
        return LineTabIndicator(color: color, bubbleRadius: 5.0);
        break;
    }

    return decoration;
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      physics: BouncingScrollPhysics(),
      labelPadding:
          EdgeInsets.only(top: 0.0, bottom: 0.0, left: 5.0, right: 5.0),
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      tabs: _tabs.map((String name) {
        //only called at initial build
        //to force rebuild, set state and put dependant variable in here?: Yes
        //the variable is _currentTabIndex

        //if index is current index remove styling

        Widget widget = Tab(
          child: Container(
            // decoration: buildSelectedTabStyle(
            //     color: _unselectedTabBarColor,
            //     tabBarStyle: _unselectedTabBarStyle),
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
      labelColor: _tabBarSelectedFontColor,
      unselectedLabelColor: _tabBarUnselectedFontColor,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
      indicatorColor: _tabBarSelectedFontColor,
      indicator: buildSelectedTabStyle(
          color: _selectedTabBarColor, tabBarStyle: _selectedTabBarStyle),
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
      bool gradientThirdColorEnabled,
      Color diagonalBarColor,
      GradientOrientations gradientOrientation,
      backgroundStyles backgroundStyle,
      Map backgroundImage,
      Color solidBackgroundColor,
      bool diagonalBarShadow,
      double diagonalBarShadowBlurRadius,
      double diagonalBarShadowLift,
      double diagonalMaxOpacity,
      bool topLeftBar,
      bool topRightBar,
      bool bottomLeftBar,
      bool bottomRightBar,
      Color topLeftBarColor,
      Color topRightBarColor,
      Color bottomLeftBarColor,
      Color bottomRightBarColor}) {
    backgroundStyle = null != backgroundStyle
        ? backgroundStyle
        : contentLayouts["header"][headerOptions.backgroundStyle];

    solidBackgroundColor = null != solidBackgroundColor
        ? solidBackgroundColor
        : contentLayouts["header"][headerOptions.solidBackgroundColor];
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

    topLeftBarColor = null != topLeftBarColor
        ? topLeftBarColor
        : contentLayouts["header"][headerOptions.topLeftBarColor];

    topRightBarColor = null != topRightBarColor
        ? topRightBarColor
        : contentLayouts["header"][headerOptions.topRightBarColor];

    bottomLeftBarColor = null != bottomLeftBarColor
        ? bottomLeftBarColor
        : contentLayouts["header"][headerOptions.bottomLeftBarColor];

    bottomRightBarColor = null != bottomRightBarColor
        ? bottomRightBarColor
        : contentLayouts["header"][headerOptions.bottomRightBarColor];

    //gradient orientation and colors

    gradientOrientation = null != gradientOrientation
        ? gradientOrientation
        : currentGradientOrientation;

    gradientFirstColor =
        null != gradientFirstColor ? gradientFirstColor : gradientColor1;

    gradientSecondColor =
        null != gradientSecondColor ? gradientSecondColor : gradientColor2;

    gradientThirdColor =
        null != gradientThirdColor ? gradientThirdColor : gradientColor3;

    gradientThirdColorEnabled = null != gradientThirdColorEnabled
        ? gradientThirdColorEnabled
        : gradientColor3Active;

    gradientThirdColor = gradientThirdColorEnabled
        ? gradientThirdColor
        : null; //enabling disabling third color

    backgroundImage =
        null != backgroundImage ? backgroundImage : homeBackgroundImage;

    var imageProvider;

    if ("asset" == backgroundImage["type"]) {
      imageProvider = AssetImage(backgroundImage["data"]);
    } else if ("file" == backgroundImage["type"]) {
      imageProvider = FileImage(backgroundImage["data"]);
    }

    Widget backgroundImageWidget = Container(
      height: homeHeaderHeight * 1.1,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: null /* add child content here */,
    );

    //setting default bars until when i create the landing page settings page
    if (!landingPage) {
      bottomLeftBar = false;
      bottomRightBar = false;
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

    switch (backgroundStyle) {
      case backgroundStyles.solid:
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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(
                    width: screenWidth,
                    child: Container(color: solidBackgroundColor)),
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
      case backgroundStyles.diagonalLine:
        widget = Positioned.fill(
          child: Stack(
            children: <Widget>[
              backgroundImageWidget,
              // Image.asset(
              //   homeBackgroundImageURL,
              //   height: homeHeaderHeight * 1.1,
              //   width: screenWidth,
              //   fit: BoxFit.cover,
              // ),
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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: SizedBox(
              width: screenWidth,
              child: Stack(
                children: <Widget>[
                  // Image.asset(
                  //   backgroundImageURL,
                  //   height: homeHeaderHeight * 1.1,
                  //   width: screenWidth,
                  //   fit: BoxFit.cover,
                  // ),
                  backgroundImageWidget,
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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: SizedBox(
              width: screenWidth,
              child: Stack(
                children: <Widget>[
                  // Image.asset(
                  //   backgroundImageURL,
                  //   height: homeHeaderHeight * 1.1,
                  //   width: screenWidth,
                  //   fit: BoxFit.cover,
                  // ),
                  backgroundImageWidget,
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
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: gradient),
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
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: gradient),
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

      case backgroundStyles.video:
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: backgroundImageWidget),
                SizedBox.expand(
                    child: VideoPlayerScreen(
                        autoPlay: true,
                        loop: false,
                        videoSource: "assets/videos/background_video_2.mp4")),
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
      Color solidBackgroundColor,
      bool gradientThirdColorEnabled,
      Color diagonalBarColor,
      GradientOrientations gradientOrientation,
      backgroundStyles backgroundStyle,
      Map backgroundImage,
      bool diagonalBarShadow,
      double diagonalBarShadowBlurRadius,
      double diagonalBarShadowLift,
      double diagonalMaxOpacity,
      bool topLeftBar,
      bool topRightBar,
      bool bottomLeftBar,
      bool bottomRightBar,
      Color topLeftBarColor,
      Color topRightBarColor,
      Color bottomLeftBarColor,
      Color bottomRightBarColor}) {
    backgroundStyle = null != backgroundStyle
        ? backgroundStyle
        : contentLayouts["header"][headerOptions.backgroundStyle];

    solidBackgroundColor = null != solidBackgroundColor
        ? solidBackgroundColor
        : contentLayouts["header"][headerOptions.solidBackgroundColor];

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

    topLeftBarColor = null != topLeftBarColor
        ? topLeftBarColor
        : contentLayouts["header"][headerOptions.topLeftBarColor];

    topRightBarColor = null != topRightBarColor
        ? topRightBarColor
        : contentLayouts["header"][headerOptions.topRightBarColor];

    bottomLeftBarColor = null != bottomLeftBarColor
        ? bottomLeftBarColor
        : contentLayouts["header"][headerOptions.bottomLeftBarColor];

    bottomRightBarColor = null != bottomRightBarColor
        ? bottomRightBarColor
        : contentLayouts["header"][headerOptions.bottomRightBarColor];

    //gradient orientation and colors

    gradientOrientation = null != gradientOrientation
        ? gradientOrientation
        : currentGradientOrientation;

    gradientFirstColor =
        null != gradientFirstColor ? gradientFirstColor : gradientColor1;

    gradientSecondColor =
        null != gradientSecondColor ? gradientSecondColor : gradientColor2;

    gradientThirdColor =
        null != gradientThirdColor ? gradientThirdColor : gradientColor3;

    gradientThirdColorEnabled = null != gradientThirdColorEnabled
        ? gradientThirdColorEnabled
        : gradientColor3Active;

    gradientThirdColor = gradientThirdColorEnabled
        ? gradientThirdColor
        : null; //enabling disabling third color

    backgroundImage =
        null != backgroundImage ? backgroundImage : homeBackgroundImage;

    var imageProvider;

    if ("asset" == backgroundImage["type"]) {
      imageProvider = AssetImage(backgroundImage["data"]);
    } else if ("file" == backgroundImage["type"]) {
      imageProvider = FileImage(backgroundImage["data"]);
    }

    Widget backgroundImageWidget = Container(
      height: homeHeaderHeight * 1.2,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: null /* add child content here */,
    );

    //setting default bars until when i create the landing page settings page
    if (!landingPage) {
      bottomLeftBar = false;
      bottomRightBar = false;
    }

    //default background style
    Positioned widget = Positioned.fill(
      child: SizedBox(
          width: screenWidth,
          height: homeHeaderHeight * heightFactor,
          child: Container(color: solidBackgroundColor)),
    );

    homeHeaderHeight = null != homeHeaderHeight
        ? homeHeaderHeight
        : MediaQuery.of(context).size.height * heightFactor;

    switch (backgroundStyle) {
      case backgroundStyles.solid:
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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(
                    width: screenWidth,
                    child: Container(color: solidBackgroundColor)),
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
      case backgroundStyles.diagonalLine:
        widget = Positioned.fill(
          child: Stack(
            children: <Widget>[
              backgroundImageWidget,
              // Image.asset(
              //   homeBackgroundImageURL,
              //   height: homeHeaderHeight * 1.1,
              //   width: screenWidth,
              //   fit: BoxFit.cover,
              // ),
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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: SizedBox(
              width: screenWidth,
              child: Stack(
                children: <Widget>[
                  // Image.asset(
                  //   backgroundImageURL,
                  //   height: homeHeaderHeight * 1.1,
                  //   width: screenWidth,
                  //   fit: BoxFit.cover,
                  // ),
                  backgroundImageWidget,
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

      case backgroundStyles.imageDiagonalLine:
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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: SizedBox(
              width: screenWidth,
              child: Stack(
                children: <Widget>[
                  // Image.asset(
                  //   backgroundImageURL,
                  //   height: homeHeaderHeight * 1.1,
                  //   width: screenWidth,
                  //   fit: BoxFit.cover,
                  // ),
                  backgroundImageWidget,
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
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: gradient),
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
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: gradient),
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

      case backgroundStyles.video:
        Widget gradient = Container(
          decoration: BoxDecoration(
              gradient: getGradient(
                  gradientFirstColor: gradientFirstColor,
                  gradientSecondColor: gradientSecondColor,
                  gradientThirdColor: gradientThirdColor,
                  gradientOrientation: gradientOrientation)),
        );

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
            topLeftBar: topLeftBar,
            topRightBar: topRightBar,
            bottomLeftBar: bottomLeftBar,
            bottomRightBar: bottomRightBar,
            topLeftBarColor: topLeftBarColor,
            topRightBarColor: topRightBarColor,
            bottomLeftBarColor: bottomLeftBarColor,
            bottomRightBarColor: bottomRightBarColor,
            child: Stack(
              children: <Widget>[
                SizedBox(width: screenWidth, child: backgroundImageWidget),
                SizedBox.expand(
                    child: VideoPlayerScreen(
                        autoPlay: true,
                        loop: true,
                        videoSource: "assets/videos/background_video_2.mp4")),
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
      Color customButtonColor,
      Color customButtonTextColor,
      bool inviteButton,
      Color inviteButtonColor,
      Color inviteButtonTextColor,
      Color titleColor,
      Color tagLineColor,
      String titleText,
      String tagLineText,
      String customButtonText,
      Map placeImage}) {
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

    customButtonColor = null != customButtonColor
        ? customButtonColor
        : contentLayouts['header'][headerOptions.customButtonColor];
    customButtonTextColor = null != customButtonTextColor
        ? customButtonTextColor
        : contentLayouts['header'][headerOptions.customButtonTextColor];

    customButtonText = null != customButtonText
        ? customButtonText
        : contentLayouts['header'][headerOptions.customButtonText];

    inviteButtonColor = null != inviteButtonColor
        ? inviteButtonColor
        : contentLayouts['header'][headerOptions.inviteButtonColor];
    inviteButtonTextColor = null != inviteButtonTextColor
        ? inviteButtonTextColor
        : contentLayouts['header'][headerOptions.inviteButtonTextColor];

    titleText = null != titleText
        ? titleText
        : contentLayouts['header'][headerOptions.titleText];
    titleColor = null != titleColor
        ? titleColor
        : contentLayouts['header'][headerOptions.titleColor];

    tagLineText = null != tagLineText
        ? tagLineText
        : contentLayouts['header'][headerOptions.tagLineText];
    tagLineColor = null != tagLineColor
        ? tagLineColor
        : contentLayouts['header'][headerOptions.tagLineColor];

    double paddingTop = 90.0 * sizeFactor;
    double paddingLeft = 20.0 * sizeFactor;
    double paddingRight = 20.0 * sizeFactor;
    double paddingBottom =
        memberViewMode ? 0.0 * sizeFactor : 30.0 * sizeFactor;

    double innerPaddingTop = 25.0 * sizeFactor;

    double titleFontSize =
        contentLayouts['header'][headerOptions.titleFontSize] * sizeFactor;
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
                                      titleText,
                                      style: GoogleFonts.lobster(
                                          textStyle: TextStyle(
                                        color: titleColor,
                                        letterSpacing: titleSpacing,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.bold,
                                      )),
                                    )),
                                Spacer(
                                  flex: 1,
                                ),
                                headerBuilders['tagline'](
                                    sizeFactor: sizeFactor,
                                    tagLine: tagLine,
                                    color: tagLineColor,
                                    tagLineText: tagLineText),
                                Expanded(
                                    flex: 10,
                                    child: headerBuilders['member_preview'](
                                        context,
                                        sizeFactor: sizeFactor,
                                        color: tagLineColor,
                                        memberPreview: memberPreview))
                              ]),
                        ),
                      ),
                      headerBuilders['place_logo'](context,
                          sizeFactor: sizeFactor,
                          placeLogo: placeLogo,
                          placeImage: placeImage)
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
                              inviteButton: inviteButton,
                              inviteButtonColor: inviteButtonColor,
                              inviteButtonTextColor: inviteButtonTextColor),
                          headerBuilders['custom_button'](
                              sizeFactor: sizeFactor,
                              customButton: customButton,
                              customButtonColor: customButtonColor,
                              customButtonTextColor: customButtonTextColor,
                              customButtonText: customButtonText)
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
                                titleText,
                                style: GoogleFonts.lobster(
                                    textStyle: TextStyle(
                                  color: titleColor,
                                  letterSpacing: titleSpacing,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                )),
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          headerBuilders['tagline'](
                              sizeFactor: sizeFactor,
                              tagLine: tagLine,
                              color: tagLineColor,
                              tagLineText: tagLineText),
                          Expanded(
                            flex: 10,
                            child: headerBuilders['member_preview'](context,
                                sizeFactor: sizeFactor,
                                color: tagLineColor,
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
                              inviteButton: inviteButton,
                              inviteButtonColor: inviteButtonColor,
                              inviteButtonTextColor: inviteButtonTextColor),
                          headerBuilders['custom_button'](
                              sizeFactor: sizeFactor,
                              customButton: customButton,
                              customButtonColor: customButtonColor,
                              customButtonTextColor: customButtonTextColor,
                              customButtonText: customButtonText)
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

  Widget buildHeaderTagLine(
      {sizeFactor: 1.0, bool tagLine, Color color, String tagLineText}) {
    tagLine = null != tagLine
        ? tagLine
        : contentLayouts['header'][headerOptions.tagLine];
    Widget widget = Container(height: 1.0, width: 2.0);

    if (tagLine) {
      widget = Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Text(
          tagLineText,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: GoogleFonts.heebo(
              textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: subtitleFontSize * sizeFactor,
                  color: color)),
        ),
      );
    }
    return widget;
  }

  Widget buildHeaderCustomButton(
      {sizeFactor: 1.0,
      bool customButton,
      String customButtonText,
      Color customButtonColor,
      Color customButtonTextColor}) {
    customButton = null != customButton
        ? customButton
        : contentLayouts['header'][headerOptions.customButton];
    Widget widget = Container(height: 1.0, width: 1.0);

    if (customButton) {
      widget = SizedBox(
        child: FlatButton(
          height: buttonHeight * sizeFactor,
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
              color: customButtonColor,
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
                  EvaIcons.starOutline,
                  color: customButtonTextColor,
                  size: 18.0 * sizeFactor,
                ),
              ),
              Text(
                customButtonText,
                overflow: TextOverflow.clip,
                style: GoogleFonts.heebo(
                    textStyle: TextStyle(
                  color: customButtonTextColor,
                  letterSpacing: 1.5 * sizeFactor,
                  fontSize: buttonFontSize * sizeFactor,
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

  Widget buildHeaderInviteButton(
      {sizeFactor: 1.0,
      bool inviteButton,
      Color inviteButtonColor,
      Color inviteButtonTextColor}) {
    inviteButton = null != inviteButton
        ? inviteButton
        : contentLayouts['header'][headerOptions.inviteButton];

    Widget widget = Container(height: 1.0, width: 1.0);

    if (inviteButton) {
      widget = Padding(
        padding: EdgeInsets.only(right: 20.0 * sizeFactor),
        child: SizedBox(
          height: buttonHeight * sizeFactor,
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
                color: inviteButtonColor,
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
                      color: inviteButtonTextColor,
                      size: 18.0 * sizeFactor,
                    ),
                  ),
                  Text(
                    'Invite',
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.heebo(
                        textStyle: TextStyle(
                      color: inviteButtonTextColor,
                      letterSpacing: 1.5 * sizeFactor,
                      fontSize: buttonFontSize * sizeFactor,
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
      {sizeFactor: 1.0, bool placeLogo, Map placeImage}) {
    placeLogo = null != placeLogo
        ? placeLogo
        : contentLayouts['header'][headerOptions.placeLogo];

    placeImage = null != placeImage ? placeImage : homePlaceImage;

    var imageProvider;

    //get image depending on whether asset or file
    if ("asset" == placeImage["type"]) {
      imageProvider = AssetImage(placeImage["data"]);
    } else if ("file" == placeImage["type"]) {
      imageProvider = FileImage(placeImage["data"]);
    }

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
                      image: imageProvider,
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
      {sizeFactor: 1.0, bool memberPreview, Color color}) {
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
                    color: color,
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
