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

  CustomTabScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0,
      this.diagonalLine = false,
      this.fixedMode = false,
      this.color = primaryColor,
      this.shadow = false,
      this.shadowBlurRadius = 15.0,
      this.shadowLift: 0.75,
      this.maxOpacity: 1.0,
      this.blurBackground: false,
      this.blurRadius: 5.0,
      this.topLeftBar = true,
      this.topRightBar = true,
      this.bottomLeftBar = true,
      this.bottomRightBar = true});

  @override
  _CustomTabScrollState createState() =>
      _CustomTabScrollState(diagonalLine: this.diagonalLine);
}

class _CustomTabScrollState extends State<CustomTabScroll> {
  bool diagonalLine;
  _CustomTabScrollState({this.diagonalLine = false});
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

    print("init state called");
    _offset = widget.scrollController.offset;
    _maxOffset = widget.scrollController.position.maxScrollExtent;
    _minOffset = widget.scrollController.position.minScrollExtent;
    landingPage = contentLayouts['header'][headerOptions.landingPageMode]
        [landingPageMode.active];
    screenHeight = sharedStateManagement['screenHeight'];
    positioned = landingPage ? screenHeight * 0.5 : 50.0;

    if (!widget.fixedMode) {
      widget.scrollController.addListener(_setCTSOffset);
      widget.scrollController.position.isScrollingNotifier.addListener(snap);
    }

    performanceTracker = 0;
  }

  @override
  dispose() {
    print("dispose called");

    // if (!widget.fixedMode && widget.scrollController.hasClients) {
    //   widget.scrollController.position.isScrollingNotifier.removeListener(snap);
    //   widget.scrollController.removeListener(_setCTSOffset);
    // }

    //scroll controller should be disposed in parent widget  if its shared between multiple children

    super.dispose();
  }

  void _setCTSOffset() {
    _offset = widget.scrollController.offset;

    setState(() {
      // print("scroll controller offset: $_offset");
      if (_offset < 300) {
        toggleNavBar(visible: false);
      }

      if (_offset > 300) {
        toggleNavBar(visible: true);
      }
    });
  }

  //This is the implementation of a custom snap functionality or the header when user stops scrolling
  void snap() {
    /*Rounding values before comparing fixes issue where it kept snapping even when the header
    was fully extended or not. Causing the user to lose their scroll position randomly when scrolling */
    print("snap called");
    print(widget.scrollController.offset);
    //set maxOffset if not already set
    if (!_maxOffsetSet) {
      _maxOffset = widget.scrollController.position.maxScrollExtent;
      _minOffset = widget.scrollController.position.minScrollExtent;
      _maxOffsetSet = true;
    }

    double currentOffset = widget.scrollController.offset;
    if (currentOffset == _maxOffset) {
      return;
    }

    if (!widget.scrollController.position.isScrollingNotifier.value) {
      //This means the scroll has stopped

      if ((currentOffset).roundToDouble() > (_maxOffset / 2).roundToDouble() &&
          (currentOffset).roundToDouble() < (_maxOffset).roundToDouble()) {
        widget.scrollController.animateTo(_maxOffset,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      } else if ((currentOffset).roundToDouble() <
              (_maxOffset / 2).roundToDouble() &&
          (currentOffset).roundToDouble() != (_minOffset).roundToDouble()) {
        widget.scrollController.animateTo(_minOffset,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      }
    } else {
      //this means scroll has started

    }
  }

  double _calculateOpacity() {
    if (widget.fixedMode) {
      return 1;
    }

    var zero = widget.zeroOpacityOffset;
    var full = widget.fullOpacityOffset;

    if (widget.fullOpacityOffset == widget.zeroOpacityOffset)
      return 1;
    else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (_offset <= widget.zeroOpacityOffset)
        return 0;
      else if (_offset >= widget.fullOpacityOffset)
        return 1;
      else
        return (_offset - widget.zeroOpacityOffset) /
            (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= widget.fullOpacityOffset) {
        return 1;
      } else if (_offset >= widget.zeroOpacityOffset) {
        var value = (_offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset);
        return 0;
      } else {
        var opacity = ((_offset - widget.zeroOpacityOffset) /
                (widget.zeroOpacityOffset - widget.fullOpacityOffset))
            .abs();
        //make sure it is between 1 and 0.
        var returnValue = opacity <= 1 ? opacity : 1;

        // return (_offset - widget.fullOpacityOffset) / (widget.zeroOpacityOffset - widget.fullOpacityOffset);
        return returnValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double bottomBase = landingPage ? screenHeight * 0.9 : 350;
    double calculatedOpacity = _calculateOpacity();
    lastOpacity = calculatedOpacity;
    calculatedOpacity = customTabScrollSettings[CTS.appBarBackgroundImage]
        ? 1.0
        : calculatedOpacity;
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

    //landingPage Bar scrolling opacity
    double landingPageBarOpacity =
        1 - barOpacity * 2 > 0 ? 1 - barOpacity * 2 : 0;

    landingPageBarOpacity = landingPageBarOpacity > widget.maxOpacity
        ? widget.maxOpacity
        : landingPageBarOpacity; //

    //apply max opacity here instead of within the calculations
    dynamicBarOpacity = dynamicBarOpacity > widget.maxOpacity
        ? widget.maxOpacity
        : dynamicBarOpacity;

    if (!diagonalLine) {
      return widget.child;
    }

    if (widget.fixedMode) {
      barOpacity = widget.maxOpacity;
      dynamicBarOpacity = widget.maxOpacity;
      // bottomOffset = landingPage ? screenHeight * 0.15 : 40;
      bottomOffset = 30;
    }

    double topLeftBottom = positioned + bottomOffset + 50;
    double topRightBottom = positioned + bottomOffset;
    double bottomLeftBottom = 0;
    double bottomRightBottom = 0;

    // print("dynamic bar opacity: $dynamicBarOpacity");
    // print("bar opacity: $barOpacity");
    // print("landingpageopacity: $landingPageBarOpacity");

    Widget topLeftBar = widget.topLeftBar
        ? HeaderBar(
            bottom: topLeftBottom,
            rotateAngle: rotateAngle,
            landingPage: landingPage,
            minHeight: 300,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.topLeft,
            color: secondaryColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.blurRadius,
          )
        : Container();

    Widget topRightBar = widget.topRightBar
        ? HeaderBar(
            bottom: topRightBottom,
            rotateAngle: -rotateAngle,
            landingPage: landingPage,
            minHeight: 300,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.topRight,
            color: widget.color,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.blurRadius,
          )

        //  Positioned(
        //     bottom: topRightBottom,
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(
        //         minHeight: 300.0,
        //         maxWidth: MediaQuery.of(context).size.width,
        //       ),
        //       child: Transform(
        //         alignment: Alignment.topRight,
        //         transform: Matrix4.skewY(rotateAngle),
        //         child: Opacity(
        //           opacity:
        //               landingPage ? landingPageBarOpacity : dynamicBarOpacity,
        //           child: Container(
        //               width: MediaQuery.of(context).size.width,
        //               height: 100.0,
        //               decoration: BoxDecoration(
        //                 boxShadow: widget.shadow
        //                     ? <BoxShadow>[
        //                         BoxShadow(
        //                             color: Colors.black54,
        //                             blurRadius: widget.shadowBlurRadius,
        //                             offset: Offset(0.0, widget.shadowLift))
        //                       ]
        //                     : null,
        //                 color: widget.color,
        //               )),
        //         ),
        //       ),
        //     ),
        //   )
        : Container();

    Widget bottomLeftBar = widget.bottomLeftBar
        ? HeaderBar(
            bottom: 0,
            rotateAngle: -rotateAngle,
            landingPage: landingPage,
            minHeight: 200,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.bottomLeft,
            color: secondaryColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.blurRadius,
          )

        // Positioned(
        //     bottom: 0,
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(
        //         minHeight: 200.0,
        //         maxWidth: MediaQuery.of(context).size.width,
        //       ),
        //       child: Transform(
        //         alignment: Alignment.bottomLeft,
        //         transform: Matrix4.skewY(rotateAngle),
        //         child: Opacity(
        //           opacity:
        //               landingPage ? landingPageBarOpacity : dynamicBarOpacity,
        //           child: Container(
        //               width: MediaQuery.of(context).size.width,
        //               height: 100.0,
        //               decoration: BoxDecoration(
        //                 boxShadow: widget.shadow
        //                     ? <BoxShadow>[
        //                         BoxShadow(
        //                             color: Colors.black54,
        //                             blurRadius: widget.shadowBlurRadius,
        //                             offset: Offset(0.0, widget.shadowLift))
        //                       ]
        //                     : null,
        //                 color: secondaryColor,
        //               )),
        //         ),
        //       ),
        //     ),
        //   )
        : Container();

    Widget bottomRightBar = widget.bottomRightBar
        ? HeaderBar(
            bottom: 0,
            rotateAngle: rotateAngle,
            landingPage: landingPage,
            minHeight: 200,
            landingPageBarOpacity: landingPageBarOpacity,
            dynamicBarOpacity: dynamicBarOpacity,
            widget: widget,
            alignment: Alignment.bottomRight,
            color: secondaryColor,
            shadow: widget.shadow,
            shadowLift: widget.shadowLift,
            blurRadius: widget.blurRadius,
          )

        // Positioned(
        //     bottom: 0,
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(
        //         minHeight: 200.0,
        //         maxWidth: MediaQuery.of(context).size.width,
        //       ),
        //       child: Transform(
        //         alignment: Alignment.bottomRight,
        //         transform: Matrix4.skewY(-rotateAngle),
        //         child: Opacity(
        //           opacity:
        //               landingPage ? landingPageBarOpacity : dynamicBarOpacity,
        //           child: Container(
        //               width: MediaQuery.of(context).size.width,
        //               height: 100.0,
        //               decoration: BoxDecoration(
        //                 boxShadow: widget.shadow
        //                     ? <BoxShadow>[
        //                         BoxShadow(
        //                             color: Colors.black54,
        //                             blurRadius: widget.shadowBlurRadius,
        //                             offset: Offset(0.0, widget.shadowLift))
        //                       ]
        //                     : null,
        //                 color: secondaryColor,
        //               )),
        //         ),
        //       ),
        //     ),
        //   )
        : Container();

    if (widget.blurBackground) {
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
              opacity: tabBarOpacity,
              child: widget.child,
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
                        sigmaX: widget.blurRadius, sigmaY: widget.blurRadius),
                    child: Opacity(
                      opacity: landingPage
                          ? landingPageBarOpacity
                          : dynamicBarOpacity,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          decoration: BoxDecoration(
                            boxShadow: widget.shadow
                                ? <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: widget.shadowBlurRadius,
                                        offset: Offset(0.0, widget.shadowLift))
                                  ]
                                : null,
                            color: widget.color,
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
        Positioned.fill(
          child: Opacity(
            opacity: tabBarOpacity,
            child: widget.child,
          ),
        ),
        topRightBar,
        topLeftBar,
        bottomLeftBar,
        bottomRightBar
      ],
    );
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
      @required this.shadowLift})
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

  @override
  Widget build(BuildContext context) {
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
                  color: color,
                )),
          ),
        ),
      ),
    );
  }
}
