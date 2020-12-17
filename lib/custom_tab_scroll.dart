import 'dart:ui';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:flutter/material.dart';

/*Used this to make the fade easier with sliver
https://gist.github.com/smkhalsa/ec33ec61993f29865a52a40fff4b81a2 */

class CustomTabScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final bool diagonalLine;

  CustomTabScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0,
      this.diagonalLine = false});

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

  @override
  initState() {
    super.initState();

    print("init state called");
    _offset = widget.scrollController.offset;
    _maxOffset = widget.scrollController.position.maxScrollExtent;
    _minOffset = widget.scrollController.position.minScrollExtent;
    widget.scrollController.addListener(_setOffset);
    widget.scrollController.position.isScrollingNotifier.addListener(snap);
  }

  @override
  dispose() {
    print("dispose called");
    widget.scrollController.position.isScrollingNotifier.removeListener(snap);
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;

      // print("scroll controller offset: $_offset");
    });
  }

  //This is the implementation of a custom snap functionality or the header when user stops scrolling
  void snap() {
    print("snap called");
    //set maxOffset if not already set
    if (!_maxOffsetSet) {
      _maxOffset = widget.scrollController.position.maxScrollExtent;
      _minOffset = widget.scrollController.position.minScrollExtent;
      _maxOffsetSet = true;
    }

    if (!widget.scrollController.position.isScrollingNotifier.value) {
      //This means the scroll has stopped
      double currentOffset = widget.scrollController.offset;

      if (currentOffset > _maxOffset / 2 && currentOffset < _maxOffset) {
        widget.scrollController.animateTo(_maxOffset,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      } else if (currentOffset < _maxOffset / 2 &&
          currentOffset != _minOffset) {
        widget.scrollController.animateTo(_minOffset,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      }
    } else {
      //this means scroll has started

    }
  }

  double _calculateOpacity() {
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
    double calculatedOpacity = _calculateOpacity();
    calculatedOpacity = customTabScrollSettings[CTS.appBarBackgroundImage]
        ? 1.0
        : calculatedOpacity;
    double barOpacity = 1 - calculatedOpacity;
    double rotateAngle = 220.0 >= _offset ? (1 - (_offset / 220)) / 4 : 0;
    double tolerance = 241.0 >= _offset ? (1 - (_offset / 241)) / 4 : 0;
    double bottomOffset = tolerance * 350;

    // print("offset: $_offset , angle: $rotateAngle");
    // print("bottomOffset: $bottomOffset");

    //opacity settings based on global statemenagement
    double tabBarOpacity = customTabScrollSettings[CTS.tabBackgroundImage]
        ? 1.0
        : calculatedOpacity;
    double dynamicBarOpacity =
        customTabScrollSettings[CTS.dynamicDiagnonalBar] ? barOpacity : 1.0;

    if (!diagonalLine) {
      return widget.child;
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
        Positioned(
          bottom: 50.0 + bottomOffset,
          child: Opacity(
            opacity: dynamicBarOpacity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 300.0,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Transform(
                alignment: Alignment.topRight,
                transform: Matrix4.skewY(rotateAngle),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
