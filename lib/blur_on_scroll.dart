import 'dart:ui';

import 'package:flutter/material.dart';
//NOTE: REALLY BAD FOR PERFOMANCE

/*Used this to make the fade easier with sliver
https://gist.github.com/smkhalsa/ec33ec61993f29865a52a40fff4b81a2 */

class BlurOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  BlurOnScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0});

  @override
  _BlurOnScrollState createState() => _BlurOnScrollState();
}

class _BlurOnScrollState extends State<BlurOnScroll> {
  double _offset;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
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
    double opacity = _calculateOpacity();
    double blurFactor = 1 - opacity;
    double blurSigma = 15 * blurFactor;

    print("sigma: $blurSigma");
    return Stack(children: [
      Opacity(opacity: opacity, child: widget.child),
      ClipRect(
        child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Center(
              child: Container(
                  child: Text(
                      "this text needs to be here otherwise the blur wont work",
                      style: TextStyle(color: Colors.transparent)))),
        ),
      ),
    ]);
    ;
  }
}
