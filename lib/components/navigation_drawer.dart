import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'dart:ui';

void displayNavigationDrawer(BuildContext context, Map params) {
  Widget header = Container(height: 1.0);
  Widget body = Container(height: 1.0);
  Color dividerColor = Colors.grey[200];
  double blurSigmaX = 0;
  double blurSigmaY = 0;

  //dart returns null if key doesnt exist in map -- unlike JS which returns 'undefined', ya'll be easy now
  if (null == params['title'] &&
      null == params['description'] &&
      null == params["custom_header"]) {
    dividerColor = Colors.white;
  }

  if (null != params['title'] &&
      null == params['description'] &&
      null == params["custom_header"]) {
    header = Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
      child: Text(
        params['title'],
        style: homeTextStyleBold,
        overflow: TextOverflow.visible,
      ),
    );
  }

  if (null == params['title'] &&
      null != params['description'] &&
      null == params["custom_header"]) {
    header = Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
      child: Text(
        params['description'],
        style: homeSubTextStyle,
        overflow: TextOverflow.visible,
      ),
    );
  }

  if (null != params['title'] &&
      null != params['description'] &&
      null == params["custom_header"]) {
    header = Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            params['title'],
            style: homeTextStyleBold,
            overflow: TextOverflow.visible,
          ),
          Text(
            params['description'],
            style: homeSubTextStyle,
            overflow: TextOverflow.visible,
          )
        ],
      ),
    );
  }

  if (null != params['custom_header']) {
    header = params['custom_header'];
  }

  if (modalBottomSheetBlur &&
      (null == params['blur'] || false != params['blur'])) {
    blurSigmaX = mbsSigmaX;
    blurSigmaY = mbsSigmaY;
  }

  if (null != params['custom_body']) {
    body = params['custom_body'];
  } else {
    body = ListView.builder(
        itemCount: params['options'].length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String optionTitle = params['options'][index]['title'];

          if (null != params['options'][index]['type'] &&
              'subtitle' == params['options'][index]['type']) {
            return Padding(
              padding: const EdgeInsets.only(
                left: sidePadding,
                right: sidePadding,
                top: 15.0,
              ),
              child: Text(optionTitle,
                  style: homeSubTextStyle, overflow: TextOverflow.visible),
            );
          }

          Widget icon = Container(
            width: 1.0,
            height: 1.0,
          ); //placeholder empty space
          Function onPressed = params['options'][index]['onPressed'];
          IconData iconData = params['options'][index]['iconData'];

          if (null != iconData) {
            icon = Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                iconData,
                color: Colors.black,
              ),
            );
          }

          print("iconData: $iconData");

          return FlatButton(
            onPressed:
                onPressed, //passing function definition onPressed and not invoking onPressed().
            child: Row(
              children: <Widget>[
                icon,
                Text(optionTitle,
                    style: homeTextStyleBold, overflow: TextOverflow.visible)
              ],
            ),
          );
        });
  }

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true, //stops max height being half screen
      context: context,
      builder: (BuildContext context) {
        Widget container = Container(
            margin: const EdgeInsets.only(
                top: 0.0, left: sidePadding, right: sidePadding, bottom: 20.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Wrap(
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 5.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        )),
                  )),
                  header,
                  Divider(
                    thickness: 1.0,
                    color: dividerColor,
                  ),
                  body,
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ));

        //for blur effect
        return new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
            child: container);
      });
}
