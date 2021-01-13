import 'package:MTR_flutter/components/cached_blur.dart';
import 'package:MTR_flutter/custom_tab_scroll.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'dart:ui';

/*
TODO: make function more accessible via input parameters with default values etc. 
  I created this when I had just started learning flutter so I know it is a mess. At the time
  I thought I could use Maps in the same way you use objects in javascript. and that's the approach
  I took. 

  expected params parameters are as follows:
 

 */

void displayNavigationDrawer(BuildContext context, Map params) {
  print("display navigation drawer called");
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true, //stops max height being half screen
      context: context,
      builder: (BuildContext context) {
        return buildNavigationDrawer(context, params);
      }).whenComplete(() {
    if (null != params['on_close'] && params['on_close'] is Function) {
      params['on_close']();
    }
  });
}

Widget buildNavigationDrawer(BuildContext context, Map params) {
  Color dividerColor = Colors.grey[200];
  Color handleBarColor = Colors.grey[200]; //that little grey line at the top
  double blurSigmaX = 0;
  double blurSigmaY = 0;
  double navSidePadding = sidePadding;
  Widget header = Container(height: 1.0);
  Widget topDivider = Divider(
    thickness: 1.0,
    color: dividerColor,
  );
  Widget body = Container(height: 1.0);
  Widget container = Container(height: 1.0);
  double bottomPadding = 20.0;

  //This section will run if a custom_container value is set and exit out of the function before the next section
  if (modalBottomSheetBlur &&
      (null == params['blur'] || false != params['blur'])) {
    blurSigmaX = mbsSigmaX;
    blurSigmaY = mbsSigmaY;
  }

  if (null != params['custom_container']) {
    //means entire contents are custom
    container = params['custom_container'];

    return new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
        child: container);
  }

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

  if (null != params["handle_bar_color"] &&
      params["handle_bar_color"] is Color) {
    handleBarColor = params["handle_bar_color"];
  }

  if (null != params['top_divider'] && false == params["top_divider"]) {
    topDivider = Container(
      height: 0.0,
    );
  }

  if (null != params['side_padding'] && params['side_padding'] is double) {
    navSidePadding = params['side_padding'];
  }

  if (null != params['bottom_padding'] && params['bottom_padding'] is double) {
    bottomPadding = params['bottom_padding'];
  }

  container = GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(new FocusNode());
    },
    child: Container(
        margin: EdgeInsets.only(
            top: 0.0,
            left: navSidePadding,
            right: navSidePadding,
            bottom: bottomPadding),
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
                      color: handleBarColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    )),
              )),
              header,
              null != params['side_padding'] && 0.0 == params['side_padding']
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: sidePadding, right: sidePadding),
                      child: topDivider,
                    )
                  : topDivider,
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
        )),
  );

  if (false == params["blur"]) {
    return container;
  }

  print("sigmaX: $blurSigmaX, sigmaY: $blurSigmaY");
  //for blur effect
  // return CachedFrostedBox(
  //     sigmaX: blurSigmaX, sigmaY: blurSigmaY, child: container);

  return new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
      child: container);
}
