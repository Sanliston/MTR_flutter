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

class AddSectionScreen extends StatefulWidget {
  @override
  _AddSectionScreenState createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen>
    with TickerProviderStateMixin {
  TabController controller;
  ScrollController scrollController;
  Color backgroundColor;
  Color fontColor;
  int currentIndex;
  bool scrollAtMin;
  bool scrollAtMax;

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

    scrollController = new ScrollController();
    scrollController.addListener(() {
      //listen if position is at max or minimum
      print("scroll position: ${scrollController.offset}");
    });
    backgroundColor = bodyBackground;
    fontColor = bodyFontColor;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollController.dispose();
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
                        bottom: BorderSide(color: Colors.black, width: 0.0))),
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
                            rebuildMainScreen(context);
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
                                            left: 15.0, right: 15.0),
                                        child: Text(name.text,
                                            style: homeTextStyle),
                                      ),
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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 55,
                              decoration: BoxDecoration(
                                  gradient: getGradient(
                                      gradientFirstColor: 0 == currentIndex
                                          ? backgroundColor.withOpacity(0.0)
                                          : backgroundColor,
                                      gradientSecondColor:
                                          backgroundColor.withOpacity(0.0),
                                      gradientOrientation:
                                          GradientOrientations.horizontal)),
                            ),
                            Container(
                              width: 55,
                              decoration: BoxDecoration(
                                  gradient: getGradient(
                                      gradientFirstColor:
                                          backgroundColor.withOpacity(0.0),
                                      gradientSecondColor:
                                          controller.length - 1 == currentIndex
                                              ? backgroundColor.withOpacity(0.0)
                                              : backgroundColor,
                                      gradientOrientation:
                                          GradientOrientations.horizontal)),
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
