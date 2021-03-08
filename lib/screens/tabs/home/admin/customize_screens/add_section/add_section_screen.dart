import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_place_card.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_member_view.dart';
import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AddSectionScreen extends StatefulWidget {
  final String tab;
  final int position;

  AddSectionScreen({@required this.tab, this.position});

  @override
  _AddSectionScreenState createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen>
    with TickerProviderStateMixin {
  TabController controller;
  Color backgroundColor;
  Color fontColor;
  int currentIndex;
  Key firstTabKey;
  Key lastTabKey;
  bool firstTabVisible = true;
  bool lastTabVisible = false;
  Duration animationDuration = Duration(milliseconds: 10);

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'General'),
    Tab(text: 'Elements'),
    Tab(text: 'Blog'),
    Tab(text: 'Members'),
    Tab(text: 'Pricing Plans'),
    Tab(text: 'Groups'),
    Tab(text: 'Events'),
    Tab(text: 'Forum'),
    Tab(text: 'Bookings'),
    Tab(text: 'Challenges'),
    Tab(text: 'Shop'),
    Tab(text: 'Shared Gallery'),
  ];

  @override
  void initState() {
    super.initState();

    print(
        "Add Section called, tab: ${widget.tab} and position: ${widget.position}");

    //state stuff here
    controller = new TabController(length: myTabs.length, vsync: this);
    currentIndex = controller.index;
    controller.addListener(() {
      print("Current index: ${controller.index}");

      if (currentIndex != controller.index) {
        setState(() {
          currentIndex = controller.index;
        });
      }
    });
    backgroundColor = bodyBackground;
    fontColor = bodyFontColor;
    firstTabKey = new GlobalKey();
    lastTabKey = new GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("home customize screen being rebuilt");
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.black.withOpacity(0.0), width: 0.0))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.infoOutline,
                            color: fontColor,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          'Choose A Section',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: homeTextStyleBold,
                        ),
                        FlatButton(
                          onPressed: () {
                            //to simulate adding a section - for now

                            print(
                                "DEBUG: ------------Adding to tab: ${widget.tab}");

                            if (null != contentLayouts[widget.tab] &&
                                null != widget.position) {
                              contentLayouts[widget.tab]
                                  .insert(widget.position, sections.contactUs);
                            } else if (null != contentLayouts[widget.tab]) {
                              contentLayouts[widget.tab]
                                  .add(sections.contactUs);
                            }

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Done',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: homeTextStyle,
                          ),
                        )
                      ]),
                ),
              ),
              Flexible(
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: Stack(
                      children: [
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: backgroundColor,
                          automaticallyImplyLeading: false,
                          bottom: TabBar(
                            isScrollable: true,
                            physics: BouncingScrollPhysics(),
                            controller: controller,
                            indicatorColor: fontColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: myTabs.map((Tab name) {
                              //only called at initial build
                              //to force rebuild, set state and put dependant variable in here?: Yes
                              //the variable is _currentTabIndex

                              int index = myTabs.indexOf(name);

                              //if index is current index remove styling

                              Widget widget = Tab(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Container(
                                    // decoration: buildUnselectedTabStyle(
                                    //     color: _unselectedTabBarColor,
                                    //     tabBarStyle: _unselectedTabBarStyle),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Text(name.text,
                                            style: homeTextStyle),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              if (0 == index) {
                                widget = VisibilityDetector(
                                  key: firstTabKey,
                                  onVisibilityChanged: (visibilityInfo) {
                                    var visiblePercentage =
                                        visibilityInfo.visibleFraction * 100;

                                    if (visiblePercentage > 85 &&
                                        !firstTabVisible &&
                                        this.mounted) {
                                      setState(() {
                                        firstTabVisible = true;
                                      });
                                    } else if (visiblePercentage < 85 &&
                                        firstTabVisible &&
                                        this.mounted) {
                                      setState(() {
                                        firstTabVisible = false;
                                      });
                                    }
                                  },
                                  child: widget,
                                );
                              } else if (myTabs.length - 1 == index) {
                                widget = VisibilityDetector(
                                  key: lastTabKey,
                                  onVisibilityChanged: (visibilityInfo) {
                                    var visiblePercentage =
                                        visibilityInfo.visibleFraction * 100;

                                    if (visiblePercentage > 85 &&
                                        !lastTabVisible) {
                                      setState(() {
                                        lastTabVisible = true;
                                      });
                                    } else if (visiblePercentage < 85 &&
                                        lastTabVisible) {
                                      setState(() {
                                        lastTabVisible = false;
                                      });
                                    }
                                  },
                                  child: widget,
                                );
                              }

                              if ("AddTabButton" == name) {
                                widget = Icon(
                                  EvaIcons.plusCircle,
                                  color: Colors.white,
                                );
                              }

                              return widget;
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: AnimatedContainer(
                                duration: animationDuration,
                                width: 105,
                                decoration: BoxDecoration(
                                    //may be better to set gradient once in initState and just swap it out as needed instead of creating it each time
                                    gradient: getGradient(
                                        gradientFirstColor: firstTabVisible
                                            ? backgroundColor.withOpacity(0.0)
                                            : backgroundColor,
                                        gradientSecondColor:
                                            backgroundColor.withOpacity(0.0),
                                        gradientOrientation:
                                            GradientOrientations.horizontal)),
                              ),
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: AnimatedContainer(
                                duration: animationDuration,
                                width: 105,
                                decoration: BoxDecoration(
                                    gradient: getGradient(
                                        gradientFirstColor:
                                            backgroundColor.withOpacity(0.0),
                                        gradientSecondColor: lastTabVisible
                                            ? backgroundColor.withOpacity(0.0)
                                            : backgroundColor,
                                        gradientOrientation:
                                            GradientOrientations.horizontal)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    controller: controller,
                    physics: BouncingScrollPhysics(),
                    children: myTabs.map((Tab tab) {
                      //place relevant tab widgets here
                      final String label = tab.text;

                      Widget widget = Container(
                        child: Text(label),
                      );

                      switch (label) {
                        case "Member View":
                          widget = new CustomizeMemberView();
                          break;
                        case "Place Card":
                          widget = new CustomizePlaceCard();
                          break;
                      }

                      return widget;
                    }).toList(),
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
