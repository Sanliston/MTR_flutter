import 'dart:ui';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui; //part of blur performance

/*Used this to make the fade easier with sliver
https://gist.github.com/smkhalsa/ec33ec61993f29865a52a40fff4b81a2 */

class CustomTabScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final bool diagonalLine;
  final bool fixedMode;
  final Color color;
  final bool shadow;
  final double shadowBlurRadius;
  final double shadowLift;
  final double maxOpacity;
  final bool blurBackground;
  final double blurRadius;
  final bool topLeftBar;
  final bool topRightBar;
  final bool bottomLeftBar;
  final bool bottomRightBar;
  final Color topLeftBarColor;
  final Color topRightBarColor;
  final Color bottomLeftBarColor;
  final Color bottomRightBarColor;
  final bool scrollFade;

  CustomTabScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0,
      this.diagonalLine = false,
      this.fixedMode = false,
      this.color,
      this.shadow = false,
      this.shadowBlurRadius = 15.0,
      this.shadowLift: 0.75,
      this.maxOpacity: 1.0,
      this.blurBackground: false,
      this.blurRadius: 5.0,
      this.topLeftBar = true,
      this.topRightBar = false,
      this.bottomLeftBar = false,
      this.bottomRightBar = false,
      this.topLeftBarColor,
      this.topRightBarColor,
      this.bottomLeftBarColor,
      this.bottomRightBarColor,
      this.scrollFade = true});

  @override
  _CustomTabScrollState createState() =>
      _CustomTabScrollState(this.scrollController, this.child,
          diagonalLine: this.diagonalLine,
          zeroOpacityOffset: this.zeroOpacityOffset,
          fullOpacityOffset: this.fullOpacityOffset,
          fixedMode: this.fixedMode,
          color: this.color,
          shadow: this.shadow,
          shadowBlurRadius: this.shadowBlurRadius,
          shadowLift: this.shadowLift,
          maxOpacity: this.maxOpacity,
          blurBackground: this.blurBackground,
          blurRadius: this.blurRadius,
          topLeftBar: this.topLeftBar,
          topRightBar: this.topRightBar,
          bottomLeftBar: this.bottomLeftBar,
          bottomRightBar: this.bottomRightBar,
          topLeftBarColor: this.topLeftBarColor,
          topRightBarColor: this.topRightBarColor,
          bottomLeftBarColor: this.bottomLeftBarColor,
          bottomRightBarColor: this.bottomRightBarColor,
          scrollFade: this.scrollFade);
}

class _CustomTabScrollState extends State<CustomTabScroll> {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final bool diagonalLine;
  final bool fixedMode;
  final Color color;
  final bool shadow;
  final double shadowBlurRadius;
  final double shadowLift;
  final double maxOpacity;
  final bool blurBackground;
  final double blurRadius;
  final bool topLeftBar;
  final bool topRightBar;
  final bool bottomLeftBar;
  final bool bottomRightBar;
  final Color topLeftBarColor;
  final Color topRightBarColor;
  final Color bottomLeftBarColor;
  final Color bottomRightBarColor;
  final bool scrollFade;

  _CustomTabScrollState(this.scrollController, this.child,
      {this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0,
      this.diagonalLine = false,
      this.fixedMode = false,
      this.color,
      this.shadow = false,
      this.shadowBlurRadius = 15.0,
      this.shadowLift: 0.75,
      this.maxOpacity: 1.0,
      this.blurBackground: false,
      this.blurRadius: 5.0,
      this.topLeftBar = false,
      this.topRightBar = true,
      this.bottomLeftBar = false,
      this.bottomRightBar = false,
      this.topLeftBarColor,
      this.topRightBarColor,
      this.bottomLeftBarColor,
      this.bottomRightBarColor,
      this.scrollFade});
  /*
     */
  double _offset;
  double _maxOffset;
  double _minOffset;
  bool _maxOffsetSet = false;
  double positioned;
  bool landingPage;
  double screenHeight;
  int performanceTracker;
  double lastOpacity;

  @override
  initState() {
    super.initState();

    _offset = scrollController.offset;

    //the two lines below were causing errors, commenting them doesnt seem to affect the app
    // _maxOffset = scrollController.position.maxScrollExtent;
    // _minOffset = scrollController.position.minScrollExtent;

    landingPage = contentLayouts['header'][headerOptions.landingPageMode]
        [landingPageMode.active];
    screenHeight = sharedStateManagement['screenHeight'];
    positioned = landingPage ? screenHeight * 0.5 : 50.0;

    if (!fixedMode) {
      scrollController.addListener(_setCTSOffset);
      scrollController.position.isScrollingNotifier.addListener(snap);
    }

    if (fixedMode) {
      //set to start position
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    performanceTracker = 0;
  }

  @override
  dispose() {
    // if (! fixedMode &&  scrollController.hasClients) {
    //    scrollController.position.isScrollingNotifier.removeListener(snap);
    //    scrollController.removeListener(_setCTSOffset);
    // }

    //scroll controller should be disposed in parent widget  if its shared between multiple children

    super.dispose();
  }

  void _setCTSOffset() {
    _offset = scrollController.offset;

    setState(() {
      // for dynamic navbar
      if (landingPage) {
        if (_offset < 300) {
          toggleNavBar(visible: false);
        }

        if (_offset > 300) {
          toggleNavBar(visible: true);
        }

        //for toggling tool bar icon colors
        if (_offset < 10) {
          toggleTBIconColors(expanded: true);
          toggleHomeTabBar(expanded: true);
        }

        if (_offset > 10) {
          toggleTBIconColors(expanded: false);
          toggleHomeTabBar(expanded: false);
        }
      } else {
        //for toggling tool bar icon colors
        if (_offset.roundToDouble() < 230) {
          toggleTBIconColors(expanded: true);
          toggleHomeTabBar(expanded: true);
        }

        if (_offset.roundToDouble() > 230) {
          toggleTBIconColors(expanded: false);
          toggleHomeTabBar(expanded: false);
        }
      }
    });
  }

  //This is the implementation of a custom snap functionality or the header when user stops scrolling
  void snap() {
    /*Rounding values before comparing fixes issue where it kept snapping even when the header
    was fully extended or not. Causing the user to lose their scroll position randomly when scrolling */

    //set maxOffset if not already set
    if (!_maxOffsetSet) {
      _maxOffset = scrollController.position.maxScrollExtent;
      _minOffset = scrollController.position.minScrollExtent;
      _maxOffsetSet = true;
    }

    double currentOffset = scrollController.offset;
    if (currentOffset == _maxOffset) {
      return;
    }

    if (!scrollController.position.isScrollingNotifier.value) {
      //This means the scroll has stopped

      if ((currentOffset).roundToDouble() > (_maxOffset / 2).roundToDouble() &&
          (currentOffset).roundToDouble() < (_maxOffset).roundToDouble()) {
        scrollController.animateTo(_maxOffset,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      } else if ((currentOffset).roundToDouble() <
              (_maxOffset / 2).roundToDouble() &&
          (currentOffset).roundToDouble() != (_minOffset).roundToDouble()) {
        scrollController.animateTo(_minOffset,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
    } else {
      //this means scroll has started

    }
  }

  double _calculateOpacity() {
    if (fixedMode) {
      return 1;
    }

    var zero = zeroOpacityOffset;
    var full = fullOpacityOffset;

    if (fullOpacityOffset == zeroOpacityOffset)
      return 1;
    else if (fullOpacityOffset > zeroOpacityOffset) {
      // fading in
      if (_offset <= zeroOpacityOffset)
        return 0;
      else if (_offset >= fullOpacityOffset)
        return 1;
      else
        return (_offset - zeroOpacityOffset) /
            (fullOpacityOffset - zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= fullOpacityOffset) {
        return 1;
      } else if (_offset >= zeroOpacityOffset) {
        var value = (_offset - fullOpacityOffset) /
            (zeroOpacityOffset - fullOpacityOffset);
        return 0;
      } else {
        var opacity = ((_offset - zeroOpacityOffset) /
                (zeroOpacityOffset - fullOpacityOffset))
            .abs();
        //make sure it is between 1 and 0.
        var returnValue = opacity <= 1 ? opacity : 1;

        // return (_offset -  fullOpacityOffset) / ( zeroOpacityOffset -  fullOpacityOffset);
        return returnValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double bottomBase = landingPage ? screenHeight * 0.9 : 350;
    double calculatedOpacity = _calculateOpacity();
    lastOpacity = calculatedOpacity;
    // calculatedOpacity = customTabScrollSettings[CTS.appBarBackgroundImage]
    //     ? 1.0
    //     : calculatedOpacity;
    double barOpacity = widget.maxOpacity - calculatedOpacity;
    barOpacity = barOpacity > 0 ? barOpacity : 0.05;
    double rotateAngle = 220.0 >= _offset ? (1 - (_offset / 220)) / 4 : 0;
    double tolerance = 241.0 >= _offset ? (1 - (_offset / 241)) / 4 : 0;
    double bottomOffset = tolerance * bottomBase;

    // print("offset: $_offset , angle: $rotateAngle");
    // print("bottomOffset: $bottomOffset");

    //opacity settings based on global statemenagement
    double tabBarOpacity = customTabScrollSettings[CTS.tabBackgroundImage]
        ? 1.0
        : calculatedOpacity;

    double dynamicBarOpacity =
        customTabScrollSettings[CTS.dynamicDiagnonalBar] ? barOpacity : 1.0;

    dynamicBarOpacity = customTabScrollSettings[CTS.appBarBackgroundImage]
        ? 0.2
        : dynamicBarOpacity;

    //landingPage Bar scrolling opacity
    double landingPageBarOpacity =
        1 - barOpacity * 2 > 0 ? 1 - barOpacity * 2 : 0;

    landingPageBarOpacity = landingPageBarOpacity > widget.maxOpacity
        ? widget.maxOpacity
        : landingPageBarOpacity; //

    landingPageBarOpacity = customTabScrollSettings[CTS.dynamicDiagnonalBar]
        ? landingPageBarOpacity
        : maxOpacity;

    //apply max opacity here instead of within the calculations
    dynamicBarOpacity = dynamicBarOpacity > widget.maxOpacity
        ? widget.maxOpacity
        : dynamicBarOpacity;

    if (!diagonalLine && scrollFade) {
      //when there's no diagonal line but still want background to fade on scroll
      return Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: tabBarOpacity,
              child: child,
            ),
          ),
        ],
      );
    }

    if (!diagonalLine) {
      //no diagonal line and no background fade on scroll.
      return child;
    }

    if (fixedMode) {
      barOpacity = widget.maxOpacity;
      dynamicBarOpacity = widget.maxOpacity;
      // bottomOffset = landingPage ? screenHeight * 0.15 : 40;
      bottomOffset = 30;
    }

    double topLeftBottom = positioned + bottomOffset + 85;
    double topRightBottom = positioned + bottomOffset;
    double bottomLeftBottom = 0;
    double bottomRightBottom = 0;

    // print("dynamic bar opacity: $dynamicBarOpacity");
    // print("bar opacity: $barOpacity");
    // print("landingpageopacity: $landingPageBarOpacity");

    Widget topLeftBarWidget = widget.topLeftBar
        ? HeaderBar(
            bottom: topLeftBottom,
            rotateAngle: rotateAngle,
            landingPage: landingPage,
            minHeight: 300,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.topLeft,
            color: widget.topLeftBarColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.shadowBlurRadius,
          )
        : Container();

    Widget topRightBarWidget = widget.topRightBar
        ? HeaderBar(
            bottom: topRightBottom,
            rotateAngle: -rotateAngle,
            landingPage: landingPage,
            minHeight: 300,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.topRight,
            color: widget.topRightBarColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.shadowBlurRadius,
          )
        : Container();

    Widget bottomLeftBarWidget = widget.bottomLeftBar
        ? HeaderBar(
            bottom: 0,
            rotateAngle: -rotateAngle,
            landingPage: landingPage,
            minHeight: 200,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.bottomLeft,
            color: widget.bottomLeftBarColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.shadowBlurRadius,
          )
        : Container();

    Widget bottomRightBarWidget = widget.bottomRightBar
        ? HeaderBar(
            bottom: 0,
            rotateAngle: rotateAngle,
            landingPage: landingPage,
            minHeight: 200,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.bottomRight,
            color: widget.bottomRightBarColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.shadowBlurRadius,
          )
        : Container();

    if (blurBackground) {
      //This is very intensive and a better solution will need to found

      return Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          // Positioned(
          //   bottom: 50.0 + bottomOffset,
          //   child: Opacity(
          //     opacity: barOpacity,
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(
          //         minHeight: 300.0,
          //         maxWidth: MediaQuery.of(context).size.width,
          //       ),
          //       child: Transform(
          //         alignment: Alignment.topRight,
          //         transform: Matrix4.skewY(rotateAngle),
          //         child: Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: 100.0,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned.fill(
            child: Opacity(
              opacity: customTabScrollSettings[CTS.appBarBackgroundImage]
                  ? 1.0
                  : tabBarOpacity,
              child: child,
            ),
          ),
          Positioned(
            bottom: positioned + bottomOffset,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 300.0,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Transform(
                alignment: Alignment.topRight,
                transform: Matrix4.skewY(rotateAngle),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(
                        sigmaX: blurRadius, sigmaY: blurRadius),
                    child: Opacity(
                      opacity: landingPage
                          ? landingPageBarOpacity
                          : dynamicBarOpacity,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          decoration: BoxDecoration(
                            boxShadow: shadow
                                ? <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: shadowBlurRadius,
                                        offset: Offset(0.0, shadowLift))
                                  ]
                                : null,
                            color: color,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        // Positioned(
        //   bottom: 50.0 + bottomOffset,
        //   child: Opacity(
        //     opacity: barOpacity,
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(
        //         minHeight: 300.0,
        //         maxWidth: MediaQuery.of(context).size.width,
        //       ),
        //       child: Transform(
        //         alignment: Alignment.topRight,
        //         transform: Matrix4.skewY(rotateAngle),
        //         child: Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: 100.0,
        //           color: Colors.red,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        getLandingPageAppBar(),
        Positioned.fill(
          child: Opacity(
            opacity: customTabScrollSettings[CTS.appBarBackgroundImage]
                ? 1.0
                : tabBarOpacity,
            child: widget.child,
          ),
        ),
        topRightBarWidget,
        topLeftBarWidget,
        bottomLeftBarWidget,
        bottomRightBarWidget,
      ],
    );
  }

  Widget getLandingPageAppBar() {
    Widget landingPageAppBar = Container();

    //for non landing page

    switch (appBarStyle) {
      case AppBarStyle.material:
        landingPageAppBar = tabBarSolidAppBar
            ? HeaderBar(
                bottom: 50,
                rotateAngle: 0,
                landingPage: landingPage,
                minHeight: MediaQuery.of(context).size.height,
                landingPageBarOpacity: 1,
                dynamicBarOpacity: 1,
                widget: widget,
                alignment: Alignment.bottomCenter,
                color: primaryColor,
                shadow: landingPage ? widget.shadow : false,
                shadowLift: widget.shadowLift,
                blurRadius: widget.shadowBlurRadius,
              )
            : Container();
        break;

      case AppBarStyle.materialFrosted:
        landingPageAppBar = tabBarSolidAppBar
            ? FrostedHeaderBar(
                bottom: 50,
                rotateAngle: 0,
                landingPage: landingPage,
                minHeight: MediaQuery.of(context).size.height,
                landingPageBarOpacity: 1,
                dynamicBarOpacity: 1,
                widget: widget,
                alignment: Alignment.bottomCenter,
                color: primaryColor.withOpacity(0.0),
                shadow: false,
                shadowLift: 0.0,
                blurRadius: widget.shadowBlurRadius,
              )
            : Container();
        break;

      case AppBarStyle.roundedBottom:
        landingPageAppBar = landingPage && tabBarSolidAppBar
            ? HeaderBar(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                bottom: 50,
                rotateAngle: 0,
                landingPage: landingPage,
                minHeight: MediaQuery.of(context).size.height,
                landingPageBarOpacity: 1,
                dynamicBarOpacity: 1,
                widget: widget,
                alignment: Alignment.bottomCenter,
                color: primaryColor,
                shadow: widget.shadow,
                shadowLift: widget.shadowLift,
                blurRadius: widget.shadowBlurRadius,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              )
            : Container();
        break;

      case AppBarStyle.halfTop:
        landingPageAppBar = tabBarSolidAppBar
            ? HeaderBar(
                bottom:
                    0, //to stop the color bleeding through at the bottom of the tabbar
                rotateAngle: 0,
                landingPage: landingPage,
                minHeight: MediaQuery.of(context).size.height,
                landingPageBarOpacity: 1,
                dynamicBarOpacity: 1,
                widget: widget,
                alignment: Alignment.bottomCenter,
                color: primaryColor,
                shadow: widget.shadow,
                shadowLift: widget.shadowLift,
                blurRadius: widget.shadowBlurRadius,
              )
            : Container();
        break;
    }

    return landingPageAppBar;
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar(
      {Key key,
      @required this.bottom,
      @required this.rotateAngle,
      @required this.landingPage,
      @required this.landingPageBarOpacity,
      @required this.dynamicBarOpacity,
      @required this.widget,
      @required this.alignment,
      @required this.minHeight,
      @required this.color,
      @required this.shadow,
      @required this.blurRadius,
      @required this.shadowLift,
      this.padding,
      this.borderRadius})
      : super(key: key);

  final double bottom;
  final double rotateAngle;
  final bool landingPage;
  final double landingPageBarOpacity;
  final double dynamicBarOpacity;
  final CustomTabScroll widget;
  final Alignment alignment;
  final double minHeight;
  final Color color;
  final bool shadow;
  final double shadowLift;
  final double blurRadius;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Color usedColor = null != color ? color : primaryColor;
    BorderRadius usedBorderRadius =
        null != borderRadius ? borderRadius : BorderRadius.zero;

    EdgeInsets usedPadding = null != padding ? padding : EdgeInsets.zero;

    List<BoxShadow> shadowList = shadow
        ? <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: blurRadius,
                offset: Offset(0.0, shadowLift))
          ]
        : null;

    return Positioned(
      bottom: bottom,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: usedPadding,
          child: Transform(
            alignment: alignment,
            transform: Matrix4.skewY(-rotateAngle),
            child: Opacity(
              opacity: landingPage ? landingPageBarOpacity : dynamicBarOpacity,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    borderRadius: usedBorderRadius,
                    color: usedColor,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class FrostedHeaderBar extends StatelessWidget {
  const FrostedHeaderBar(
      {Key key,
      @required this.bottom,
      @required this.rotateAngle,
      @required this.landingPage,
      @required this.landingPageBarOpacity,
      @required this.dynamicBarOpacity,
      @required this.widget,
      @required this.alignment,
      @required this.minHeight,
      @required this.color,
      @required this.shadow,
      @required this.blurRadius,
      @required this.shadowLift,
      this.padding,
      this.borderRadius})
      : super(key: key);

  final double bottom;
  final double rotateAngle;
  final bool landingPage;
  final double landingPageBarOpacity;
  final double dynamicBarOpacity;
  final CustomTabScroll widget;
  final Alignment alignment;
  final double minHeight;
  final Color color;
  final bool shadow;
  final double shadowLift;
  final double blurRadius;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Color usedColor = null != color ? color : primaryColor;
    BorderRadius usedBorderRadius =
        null != borderRadius ? borderRadius : BorderRadius.zero;

    EdgeInsets usedPadding = null != padding ? padding : EdgeInsets.zero;

    List<BoxShadow> shadowList = shadow
        ? <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: blurRadius,
                offset: Offset(0.0, shadowLift))
          ]
        : null;

    return Positioned(
      bottom: bottom,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: usedPadding,
          child: Transform(
            alignment: alignment,
            transform: Matrix4.skewY(-rotateAngle),
            child: Opacity(
              opacity: landingPage ? landingPageBarOpacity : dynamicBarOpacity,
              child: ClipRRect(
                borderRadius: usedBorderRadius,
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      decoration: BoxDecoration(
                        boxShadow: shadowList,
                        borderRadius: usedBorderRadius,
                        color: usedColor,
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
