import 'package:flutter/material.dart';


/*Used this to make the fade easier with sliver
https://gist.github.com/smkhalsa/ec33ec61993f29865a52a40fff4b81a2 */

class CustomTabScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  CustomTabScroll(
      {Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0});

  @override
  _CustomTabScrollState createState() => _CustomTabScrollState();
}

class _CustomTabScrollState extends State<CustomTabScroll> {

  /*
     */
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
        return (_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    } else {
      // fading out
      if (_offset <= widget.fullOpacityOffset){
        return 1;
      }else if (_offset >= widget.zeroOpacityOffset) {
        var value = (_offset - widget.fullOpacityOffset) / (widget.zeroOpacityOffset - widget.fullOpacityOffset);
        return 0;
      }else{
        var opacity = ((_offset - widget.zeroOpacityOffset) / (widget.zeroOpacityOffset - widget.fullOpacityOffset)).abs();
        //make sure it is between 1 and 0. 
        var returnValue = opacity <= 1 ? opacity: 1;

        // return (_offset - widget.fullOpacityOffset) / (widget.zeroOpacityOffset - widget.fullOpacityOffset);
        return returnValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    double calculatedOpacity = _calculateOpacity();
    double barOpacity = 1 - calculatedOpacity;
    double rotateAngle = 220.0 >= _offset ? (1 - (_offset/220))/4 : 0;
    double tolerance = 241.0 >= _offset ? (1 - (_offset/241))/4 : 0;
    double bottomOffset =tolerance*350;

    print("offset: $_offset , angle: $rotateAngle");
    print("bottomOffset: $bottomOffset");

    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          bottom: 50.0 + bottomOffset,
          child: Opacity(
            opacity: barOpacity,
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
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            
            opacity: calculatedOpacity,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}