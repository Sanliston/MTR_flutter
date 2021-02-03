import 'dart:ui';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SimpleNavBar extends StatefulWidget {
  final Function onItemTapped;

  SimpleNavBar({@required this.onItemTapped});

  @override
  _SimpleNavBarState createState() =>
      _SimpleNavBarState(onItemTapped: this.onItemTapped);
}

class _SimpleNavBarState extends State<SimpleNavBar> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool centerActive;
  double centerButtonWidth = 55;
  double centerButtonHeight = 55;
  List<Widget> centerButtonList;
  Color backgroundColor;
  Color glowColor;
  final Function onItemTapped;
  bool blurEffect;
  Color blurBackground;

  // ···

  _SimpleNavBarState({this.onItemTapped});

  @override
  initState() {
    centerActive = false;

    centerButtonList = [
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      ),
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      ),
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      )
    ];

    backgroundColor = Colors.white;
    blurBackground =
        darkMode ? Colors.black38 : Colors.grey[100].withOpacity(0.4);
    glowColor = Colors.grey[400];

    blurEffect = true;

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print("gesture detector on tap called");
        if (centerActive) {
          print("gesture detector on tap called inside if");
          setState(() {
            centerActive = false;
          });
        }
      },
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        height: centerActive ? screenHeight : 80,
        width: screenWidth,
        color: Colors.transparent,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Positioned(
            bottom: 0,
            child: blurEffect ? buildBlurredNavBar() : buildNavBar(),
          ),
          Positioned(
            //to create a soft shadow for the box below
            bottom: 15,
            child: Container(
              width: 40.0,
              height: 15.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.7),
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            //to create a soft shadow for the box below
            bottom: 70,
            left: (MediaQuery.of(context).size.width / 2) - 75,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 60.0,
              height: 10.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: centerActive
                      ? primaryColor.withOpacity(0.9)
                      : Colors.transparent,
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            //to create a soft glow for the expanded box
            bottom: 70,
            left: (MediaQuery.of(context).size.width / 2) + 35,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 60.0,
              height: 10.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: centerActive
                      ? primaryColor.withOpacity(0.9)
                      : Colors.transparent,
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(bottom: 60, child: buildExpandedCenter()),
          Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    centerActive = !centerActive;
                  });
                },
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: centerActive
                        ? centerButtonWidth + 2
                        : centerButtonWidth,
                    height: centerActive
                        ? centerButtonHeight + 50
                        : centerButtonHeight,
                    decoration: BoxDecoration(
                      gradient: getGradient(
                          gradientFirstColor: primaryColor,
                          gradientSecondColor: centerActive
                              ? primaryColor.withOpacity(0.0)
                              : primaryColor,
                          gradientThirdColor: centerActive
                              ? primaryColor.withOpacity(0.0)
                              : primaryColor,
                          gradientOrientation: centerActive
                              ? GradientOrientations.navFade
                              : GradientOrientations.reverseVertical),
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(centerActive ? 50 : 20)),
                    ),
                    child: centerActive
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                EvaIcons.closeCircle,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            getCenterIcon(),
                            color: Colors.white,
                            size: 20.0,
                          )),
              ))
        ]),
      ),
    );
  }

  Widget buildExpandedCenter({bool shrinking: false}) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 400),
      width: centerActive ? 280 : 30,
      height: centerActive ? 250 : 0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: getGradient(
              gradientFirstColor: centerActive ? secondaryColor : primaryColor,
              gradientSecondColor: primaryColor,
              gradientOrientation: GradientOrientations.nav)),
      child: Column(
        children: centerActive ? [] : [],
      ),
    );
  }

  IconData getCenterIcon() {
    IconData icon = UniconsLine.moon;
    switch (mainScreenState[mainScreen.selectedIndex]) {
      case 0:
        icon = EvaIcons.heartOutline;
        break;

      case 1:
        icon = EvaIcons.paperPlaneOutline;
        break;

      case 2:
        icon = EvaIcons.gridOutline;
        break;

      case 3:
        icon = EvaIcons.shieldOutline;
        break;
    }

    return icon;
  }

  Widget buildNavBar() {
    Radius navBarRadius = Radius.circular(0);
    Radius navBarInnerRadius = Radius.circular(20);

    Widget widget = Container();

    widget = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 10,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                width: centerActive ? 110 : 30,
                height: centerActive ? 50 : 50,
                color: primaryColor)),
        Positioned(
            bottom: 0,
            child: Container(width: 100, height: 40, color: backgroundColor)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.0),
              borderRadius: BorderRadius.only(
                  topLeft: navBarRadius, topRight: navBarRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: glowColor.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(-10.0, 1.0))
                            ],
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: navBarRadius,
                                topRight: navBarInnerRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(0);
                                },
                                child: Icon(
                                  EvaIcons.homeOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          0
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(1);
                                },
                                child: Icon(
                                  EvaIcons.messageCircleOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          1
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        //this will be just to take space
                        width: centerButtonWidth,
                        height: 50,
                        color: Colors.transparent),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: glowColor.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(10.0, 1.0))
                            ],
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: navBarInnerRadius,
                                topRight: navBarRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(2);
                                },
                                child: Icon(
                                  EvaIcons.searchOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          2
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(3);
                                },
                                child: Icon(
                                  EvaIcons.personOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          3
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );

    return widget;
  }

  Widget buildBlurredNavBar() {
    Radius navBarRadius = Radius.circular(0);
    Radius navBarInnerRadius = Radius.circular(20);

    Widget widget = Container();

    widget = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 10,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                width: centerActive ? 110 : 30,
                height: centerActive ? 50 : 50,
                color: primaryColor)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.0),
              borderRadius: BorderRadius.only(
                  topLeft: navBarRadius, topRight: navBarRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: navBarRadius, topRight: navBarInnerRadius),
                        child: BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: glowColor.withOpacity(0.5),
                                //       blurRadius: 10.0,
                                //       offset: Offset(-10.0, 1.0))
                                // ],
                                color: blurBackground,
                                borderRadius: BorderRadius.only(
                                    topLeft: navBarRadius,
                                    topRight: navBarInnerRadius)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(0);
                                    },
                                    child: Icon(
                                      EvaIcons.homeOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              0
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(1);
                                    },
                                    child: Icon(
                                      EvaIcons.messageCircleOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              1
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        //this will be just to take space
                        width: centerButtonWidth,
                        height: 50,
                        color: Colors.transparent),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: navBarInnerRadius, topRight: navBarRadius),
                        child: BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: glowColor.withOpacity(0.5),
                                //       blurRadius: 10.0,
                                //       offset: Offset(10.0, 1.0))
                                // ],
                                color: blurBackground,
                                borderRadius: BorderRadius.only(
                                    topLeft: navBarInnerRadius,
                                    topRight: navBarRadius)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(2);
                                    },
                                    child: Icon(
                                      EvaIcons.searchOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              2
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(3);
                                    },
                                    child: Icon(
                                      EvaIcons.personOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              3
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: navBarInnerRadius, topRight: navBarInnerRadius),
                child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: getGradient(
                              gradientOrientation:
                                  GradientOrientations.blurFade,
                              gradientFirstColor:
                                  blurBackground.withOpacity(0.0),
                              gradientSecondColor: blurBackground,
                              gradientThirdColor:
                                  blurBackground.withOpacity(0.0))),
                      width: 90,
                      height: 40,
                    )))),
      ],
    );

    return widget;
  }
}

//=========================================

class LeanNavBar extends StatefulWidget {
  final Function onItemTapped;

  LeanNavBar({@required this.onItemTapped});

  @override
  _LeanNavBarState createState() =>
      _LeanNavBarState(onItemTapped: this.onItemTapped);
}

class _LeanNavBarState extends State<LeanNavBar> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool centerActive;
  double centerButtonWidth = 55;
  double centerButtonHeight = 55;
  List<Widget> centerButtonList;
  Color backgroundColor;
  Color glowColor;
  final Function onItemTapped;
  bool blurEffect;
  Color blurBackground;
  double baseHeight = 30;

  // ···

  _LeanNavBarState({this.onItemTapped});

  @override
  initState() {
    centerActive = false;

    centerButtonList = [
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      ),
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      ),
      Text(
        "Mood check-in",
        style: homeTextStyleBoldWhiteSmall,
      )
    ];

    backgroundColor = Colors.white;
    blurBackground =
        darkMode ? Colors.black38 : Colors.grey[100].withOpacity(0.4);
    glowColor = Colors.grey[400];

    blurEffect = true;

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print("gesture detector on tap called");
        if (centerActive) {
          print("gesture detector on tap called inside if");
          setState(() {
            centerActive = false;
          });
        }
      },
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        height: centerActive ? screenHeight : baseHeight + 40,
        width: screenWidth,
        color: Colors.transparent,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Positioned(
            bottom: 0,
            child: blurEffect ? buildBlurredNavBar() : buildNavBar(),
          ),
          Positioned(
            //to create a soft shadow for the box below
            bottom: 15,
            child: Container(
              width: baseHeight,
              height: 15.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.7),
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            //to create a soft shadow for the box below
            bottom: baseHeight + 30,
            left: (MediaQuery.of(context).size.width / 2) - 75,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 60.0,
              height: 10.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: centerActive
                      ? primaryColor.withOpacity(0.9)
                      : Colors.transparent,
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            //to create a soft glow for the expanded box
            bottom: baseHeight + 30,
            left: (MediaQuery.of(context).size.width / 2) + 35,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 60.0,
              height: 10.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: centerActive
                      ? primaryColor.withOpacity(0.9)
                      : Colors.transparent,
                  blurRadius: 15.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(bottom: baseHeight + 20, child: buildExpandedCenter()),
          Positioned(
              bottom: baseHeight - 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    centerActive = !centerActive;
                  });
                },
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: centerActive
                        ? centerButtonWidth + 2
                        : centerButtonWidth,
                    height: centerActive
                        ? centerButtonHeight + 50
                        : centerButtonHeight,
                    decoration: BoxDecoration(
                      gradient: getGradient(
                          gradientFirstColor: primaryColor,
                          gradientSecondColor: centerActive
                              ? primaryColor.withOpacity(0.0)
                              : primaryColor,
                          gradientThirdColor: centerActive
                              ? primaryColor.withOpacity(0.0)
                              : primaryColor,
                          gradientOrientation: centerActive
                              ? GradientOrientations.navFade
                              : GradientOrientations.reverseVertical),
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(centerActive ? 50 : 60)),
                    ),
                    child: centerActive
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                EvaIcons.closeCircle,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            getCenterIcon(),
                            color: Colors.white,
                            size: 20.0,
                          )),
              ))
        ]),
      ),
    );
  }

  Widget buildExpandedCenter({bool shrinking: false}) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 400),
      width: centerActive ? 280 : 30,
      height: centerActive ? 250 : 0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: getGradient(
              gradientFirstColor: centerActive ? secondaryColor : primaryColor,
              gradientSecondColor: primaryColor,
              gradientOrientation: GradientOrientations.nav)),
      child: Column(
        children: centerActive ? [] : [],
      ),
    );
  }

  IconData getCenterIcon() {
    IconData icon = UniconsLine.moon;
    switch (mainScreenState[mainScreen.selectedIndex]) {
      case 0:
        icon = EvaIcons.heartOutline;
        break;

      case 1:
        icon = EvaIcons.paperPlaneOutline;
        break;

      case 2:
        icon = EvaIcons.gridOutline;
        break;

      case 3:
        icon = EvaIcons.shieldOutline;
        break;
    }

    return icon;
  }

  Widget buildNavBar() {
    Radius navBarRadius = Radius.circular(0);
    Radius navBarInnerRadius = Radius.circular(20);

    Widget widget = Container();

    widget = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 10,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                width: centerActive ? 110 : 30,
                height: centerActive ? 50 : 50,
                color: primaryColor)),
        Positioned(
            bottom: 0,
            child: Container(
                width: 100, height: baseHeight, color: backgroundColor)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: baseHeight + 60,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.0),
              borderRadius: BorderRadius.only(
                  topLeft: navBarRadius, topRight: navBarRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: baseHeight + 20,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: glowColor.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(-10.0, 1.0))
                            ],
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: navBarRadius,
                                topRight: navBarInnerRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(0);
                                },
                                child: Icon(
                                  EvaIcons.homeOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          0
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(1);
                                },
                                child: Icon(
                                  EvaIcons.messageCircleOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          1
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        //this will be just to take space
                        width: centerButtonWidth,
                        height: 50,
                        color: Colors.transparent),
                    Expanded(
                      child: Container(
                        height: baseHeight + 20,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: glowColor.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(10.0, 1.0))
                            ],
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: navBarInnerRadius,
                                topRight: navBarRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(2);
                                },
                                child: Icon(
                                  EvaIcons.searchOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          2
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                  child: GestureDetector(
                                onTap: () {
                                  onItemTapped(3);
                                },
                                child: Icon(
                                  EvaIcons.personOutline,
                                  color: mainScreenState[
                                              mainScreen.selectedIndex] ==
                                          3
                                      ? primaryColor
                                      : Colors.grey[400],
                                  size: 25.0,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );

    return widget;
  }

  Widget buildBlurredNavBar() {
    Radius navBarRadius = Radius.circular(0);
    Radius navBarInnerRadius = Radius.circular(20);

    Widget widget = Container();

    widget = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 10,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                width: centerActive ? 110 : 30,
                height: centerActive ? 50 : 50,
                color: primaryColor)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.0),
              borderRadius: BorderRadius.only(
                  topLeft: navBarRadius, topRight: navBarRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: navBarRadius, topRight: navBarInnerRadius),
                        child: BackdropFilter(
                          filter: new ImageFilter.blur(
                              sigmaX: bottomNavSigma, sigmaY: bottomNavSigma),
                          child: Container(
                            height: baseHeight + 20,
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: glowColor.withOpacity(0.5),
                                //       blurRadius: 10.0,
                                //       offset: Offset(-10.0, 1.0))
                                // ],
                                color: blurBackground,
                                borderRadius: BorderRadius.only(
                                    topLeft: navBarRadius,
                                    topRight: navBarInnerRadius)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(0);
                                    },
                                    child: Icon(
                                      EvaIcons.homeOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              0
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(1);
                                    },
                                    child: Icon(
                                      EvaIcons.messageCircleOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              1
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        //this will be just to take space
                        width: centerButtonWidth,
                        height: 50,
                        color: Colors.transparent),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: navBarInnerRadius, topRight: navBarRadius),
                        child: BackdropFilter(
                          filter: new ImageFilter.blur(
                              sigmaX: bottomNavSigma, sigmaY: bottomNavSigma),
                          child: Container(
                            height: baseHeight + 20,
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: glowColor.withOpacity(0.5),
                                //       blurRadius: 10.0,
                                //       offset: Offset(10.0, 1.0))
                                // ],
                                color: blurBackground,
                                borderRadius: BorderRadius.only(
                                    topLeft: navBarInnerRadius,
                                    topRight: navBarRadius)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(2);
                                    },
                                    child: Icon(
                                      EvaIcons.searchOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              2
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: () {
                                      onItemTapped(3);
                                    },
                                    child: Icon(
                                      EvaIcons.personOutline,
                                      color: mainScreenState[
                                                  mainScreen.selectedIndex] ==
                                              3
                                          ? primaryColor
                                          : Colors.grey[400],
                                      size: 25.0,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: navBarInnerRadius, topRight: navBarInnerRadius),
                child: BackdropFilter(
                    filter: new ImageFilter.blur(
                        sigmaX: bottomNavSigma, sigmaY: bottomNavSigma),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: getGradient(
                              gradientOrientation:
                                  GradientOrientations.blurFade,
                              gradientFirstColor:
                                  blurBackground.withOpacity(0.0),
                              gradientSecondColor: blurBackground,
                              gradientThirdColor:
                                  blurBackground.withOpacity(0.0))),
                      width: 90,
                      height: baseHeight,
                    )))),
      ],
    );

    return widget;
  }
}
