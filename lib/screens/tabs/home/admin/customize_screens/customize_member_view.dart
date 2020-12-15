import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';

class CustomizeMemberView extends StatelessWidget {
  const CustomizeMemberView({
    Key key,
  }) : super(key: key);

  List<Widget> buildPreview(BuildContext context, String tab) {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

    if (null == contentLayouts[tab]) {
      tab = "default";
    }

    List<Widget> widgets = <Widget>[];

    List components = contentLayouts[tab];

    for (var i = 0; i < components.length; i++) {
      //ADD components to build list
      Widget component = sectionMap[components[i]]();

      widgets.add(component);
    }

    return widgets;
  }

  Widget buildHeaderPreview(BuildContext context) {
    return headerBuilders['header'](context);
  }

  Widget scaleDown(Widget section) {
    //purpose of function is to scale down font size, width etc to make it more
    //https://stasheq.medium.com/scale-whole-app-or-widget-contents-to-a-screen-size-in-flutter-e3be161b5ab4
  }

  /*to do the fancy little buttons we will be taking a unique approach using stacks and lists
  
    There are 2 parts to this:
    -The header and the tab bar. This can be regarded as one self contained unit.
    -The 'Add section' area and immediate component preview underneath. This can be regarded as one unit

    The reason is that they don't contain elements that hang outside of their bounds. So can be
    put into a List builder and look fine.

    The individual units however will need to be carefully constructed:

    header and tab bar unit:
    -padding at top
    -

  */

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkNight,
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Stack(alignment: Alignment.topCenter, children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: memberViewPadding, right: memberViewPadding, top: 12.0),
              child: Container(
                height: 430.0,
                color: Colors.white,
                child: buildHeaderPreview(context),
              ),
            ),
            SizedBox(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: DashedLine(topOffset: 12.0),
              ),
            ),
            Positioned(
              top: 400.0,
              child: SizedBox(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: DashedLine(topOffset: 0.0),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SmallButton(
                    width: 90.0, iconData: EvaIcons.edit, text: 'Edit Header'),
              ),
            ),
            Positioned(
              top: 388.0,
              left: 0, //300 - (buttonHeight/2)
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SmallButton(
                    width: 150.0,
                    iconData: EvaIcons.edit,
                    text: 'Edit Navigation Tabs'),
              ),
            )
          ]),
        ),
      ]),
    );
  }
}

class SmallButton extends StatelessWidget {
  final double width;
  final IconData iconData;
  final String text;

  const SmallButton(
      {Key key, @required this.width, this.iconData, @required this.text})
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
          size: 14.0,
        ),
      );
    }

    return SizedBox(
      height: 24.0,
      width: width,
      child: FlatButton(
        onPressed: () {
          sharedStateManagement['display_invite_menu']();
        },
        padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
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
              style: customizeButtonText,
            ),
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
