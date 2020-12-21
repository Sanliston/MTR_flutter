import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';

class SmallButton extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final IconData iconData;
  final String text;
  final Function onPressed;

  const SmallButton(
      {Key key,
      this.width,
      this.height = 24.0,
      this.iconData,
      this.iconSize = 14.0,
      this.onPressed,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = Container(width: 1.0);

    if (null != iconData) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          iconData,
          color: Colors.white,
          size: iconSize,
        ),
      );
    }

    // double buttonWidth = null == width ? text.length * 10.0 : width;
    Function buttonOnPressed = () {};
    if (null != onPressed) {
      buttonOnPressed = onPressed;
    }

    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        onPressed: buttonOnPressed,
        padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 10.0, bottom: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(
              text,
              style: GoogleFonts.heebo(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final IconData iconData;
  final String text;
  final Function onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final Color fontColor;
  final Color iconColor;

  const TransparentButton(
      {Key key,
      this.width,
      this.height = 25.0,
      this.iconData,
      this.iconSize = 18.0,
      this.onPressed,
      this.backgroundColor = Colors.transparent,
      this.borderColor = primaryColor,
      this.fontColor = primaryColor,
      this.iconColor = primaryColor,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = Container(width: 1.0);

    if (null != iconData) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      );
    }

    // double buttonWidth = null == width ? text.length * 10.0 : width;
    Function buttonOnPressed = () {};
    if (null != onPressed) {
      buttonOnPressed = onPressed;
    }

    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        onPressed: buttonOnPressed,
        padding:
            EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(
              text,
              style: GoogleFonts.heebo(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: fontColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SolidButton extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final IconData iconData;
  final String text;
  final Function onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final Color fontColor;
  final Color iconColor;

  const SolidButton(
      {Key key,
      this.width,
      this.height = 25.0,
      this.iconData,
      this.iconSize = 18.0,
      this.onPressed,
      this.backgroundColor = primaryColor,
      this.borderColor = primaryColor,
      this.fontColor = Colors.white,
      this.iconColor = Colors.white,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = Container(width: 1.0);

    if (null != iconData) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      );
    }

    // double buttonWidth = null == width ? text.length * 10.0 : width;
    Function buttonOnPressed = () {};
    if (null != onPressed) {
      buttonOnPressed = onPressed;
    }

    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        onPressed: buttonOnPressed,
        padding:
            EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(
              text,
              style: GoogleFonts.heebo(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: fontColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashedLine extends CustomPainter {
  final double topOffset;

  DashedLine({@required this.topOffset});
  @override
  void paint(Canvas canvas, Size size) {
    Color color = Colors.blue;
    final Paint paint = Paint();
    paint.color = color;
    paint.strokeWidth = 1.5;

    StrokeCap strokeCap = StrokeCap.square;
    double strokeWidth = 1;

    _drawDashedLine(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint) {
    // Chage to your preferred size
    const int dashWidth = 6;
    const int dashSpace = 4;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = 0;
    double y = topOffset;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);

      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }
}
