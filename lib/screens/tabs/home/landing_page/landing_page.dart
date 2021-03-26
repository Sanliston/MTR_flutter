import 'dart:ui';
import 'package:MTR_flutter/state_management/root_template_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool centerActive;
  double centerButtonWidth = 65;
  double centerButtonHeight = 65;
  List<Widget> centerButtonList;
  bool navBarEnabled = false;
  // ···

  _LandingPageState();

  @override
  initState() {
    super.initState();
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
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      buildExpHeader(context),
      navBarEnabled
          ? Positioned(
              bottom: 0,
              child: buildNavBar(),
            )
          : Container(),
      navBarEnabled
          ? Positioned(
              //to create a soft shadow for the box below
              bottom: 105,
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
            )
          : Container(),
      Positioned(
        //to create a soft shadow for the box below
        bottom: 165,
        left: (MediaQuery.of(context).size.width / 2) - 75,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: 40.0,
          height: 10.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: centerActive
                  ? primaryColor.withOpacity(0.7)
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
        bottom: 165,
        left: (MediaQuery.of(context).size.width / 2) + 35,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: 40.0,
          height: 10.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: centerActive
                  ? primaryColor.withOpacity(0.7)
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
      Positioned(bottom: 160, child: buildExpandedCenter()),
      navBarEnabled
          ? Positioned(
              bottom: 105,
              child: Container(
                  width: centerButtonWidth,
                  height: centerButtonHeight,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        centerActive = !centerActive;
                      });
                    },
                    icon: Icon(
                      EvaIcons.plusOutline,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )))
          : Container()
    ]);
  }

  Widget buildExpandedCenter({bool shrinking: false}) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 400),
      width: centerActive ? 190 : 0,
      height: centerActive ? 150 : 0,
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

  Widget buildNavBar() {
    Radius navBarRadius = Radius.circular(25);
    Radius navBarInnerRadius = Radius.circular(20);

    Widget widget = Container();

    widget = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 110,
            child: Container(width: 100, height: 50, color: Colors.white)),
        Positioned(
            bottom: 110,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 400),
                width: centerActive ? 110 : 30,
                height: centerActive ? 510 : 50,
                color: primaryColor)),
        Positioned(
            bottom: 0,
            child: Container(width: 100, height: 130, color: Colors.white)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 160,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: navBarRadius, topRight: navBarRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                  child: Icon(
                                EvaIcons.chevronUpOutline,
                                color: Colors.grey[400],
                                size: 40.0,
                              )),
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Icon(
                                  EvaIcons.chevronUpOutline,
                                  color: Colors.grey[400],
                                  size: 40.0,
                                )),
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
                        height: 160,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: navBarInnerRadius,
                                topRight: navBarRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Icon(
                                  EvaIcons.chevronUpOutline,
                                  color: Colors.grey[400],
                                  size: 40.0,
                                )),
                            Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Icon(
                                  EvaIcons.chevronUpOutline,
                                  color: Colors.grey[400],
                                  size: 40.0,
                                )),
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

  Widget buildExpHeader(BuildContext context) {
    //this is like this for demonstration
    //actual Exp header will be built using a builder of some sort
    //this will allow the user to configure what elements they want etc
    //like with the tabs
    List<Widget> slides = [
      Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: 100.0,
              left: sidePadding,
              right: sidePadding,
              bottom: navBarEnabled ? 100 : 30),
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
                        child: Container(),
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
                                      fontWeight: FontWeight.normal,
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
                                      fontWeight: FontWeight.normal,
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
                                      fontWeight: FontWeight.normal,
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
                        style: homeTextStyleBoldWhite,
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
                        style: homeTextStyleBoldWhite,
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
                      child: Container(),
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
        padding: EdgeInsets.only(bottom: 80),
        child: new Swiper(
          itemCount: slides.length,
          pagination: new SwiperPagination(
            margin: EdgeInsets.only(bottom: navBarEnabled ? 110 : 20),
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
}
