import 'package:MTR_flutter/components/buttons.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'dart:ui';

/* 
You can implement this widget 2 ways:

- As a normal widget by just calling the widget - SimpleColorPicker(...)
  this approach onviously returns an instance of the widget to the invoker.

- As a navigation drawer popup - by calling displayColorPicker(...)
  this approach does not return an instance of the widget to the invoker,
  instead it directly passes the instance to the showModalBottomSheet(...builder: (){ return widget})
  resulting in the widget being displayed in a popup navigation drawer. Enter the parameters accordingly

  However, this approach seems less performant

*/

class SimpleColorPicker extends StatefulWidget {
  final Color startingColor;
  final bool blur;
  final Function onColorTapped;
  final Function onSave;
  final Color handleBarColor;
  final bool widgetMode;
  final double height;
  void callback(Color color) {}

  SimpleColorPicker(
      {@required this.onColorTapped,
      @required this.onSave,
      this.blur = true,
      this.widgetMode = true,
      this.handleBarColor = Colors.white,
      this.startingColor = Colors.red,
      this.height = 300});

  @override
  _SimpleColorPickerState createState() => _SimpleColorPickerState(
      onColorTapped: this.onColorTapped,
      onSave: this.onSave,
      handleBarColor: this.handleBarColor,
      startingColor: this.startingColor,
      blur: this.blur,
      widgetMode: this.widgetMode,
      height: this.height);
}

class _SimpleColorPickerState extends State<SimpleColorPicker> {
  List<Color> colorList = [
    Color(0xFFFF416C),
    Color(0xFFf80759),
    Color(0xFFC06C84),
    Color(0xFF263238),
    Color(0xFF2d82fe),
    Color(0xFFFF4B2B),
    Color(0xFFFF4B2B),
    Color(0xFF2d82fe),
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent
  ];

  final Color startingColor;
  final bool blur;
  final Function onColorTapped;
  final Function onSave;
  final Color handleBarColor;
  final bool widgetMode;
  final double height;
  Color selectedColor;

  _SimpleColorPickerState(
      {@required this.onColorTapped,
      @required this.onSave,
      this.blur = true,
      this.widgetMode,
      this.handleBarColor = Colors.white,
      this.startingColor = Colors.red,
      this.height});

  @override
  void initState() {
    super.initState();

    selectedColor = startingColor;
  }

  @override
  void dispose() {
    super.dispose();

    //free up any used resources here
  }

  Widget build(BuildContext context) {
    print("color picker called");
    return buildColorPicker(context, onColorTapped, onSave,
        widgetMode: widgetMode, height: height);
  }

  Widget buildColorPicker(
      BuildContext context, Function onColorTapped, Function onSave,
      {bool blur = true,
      bool widgetMode = false,
      Color handleBarColor = Colors.white,
      Color startingColor = Colors.red,
      double height = 300.0}) {
    /*Build the color as stateful widget, and the built widget is passed to navigation drawer
    by displayColorPicker() -- only intended to be used with display color picker but can work 
    in standalone too */

    Widget customHeader = Padding(
      padding: const EdgeInsets.only(
          top: 0.0, bottom: 5.0, left: sidePadding, right: sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            //using because flatbutton and Iconbutton have to high of a padding
            onTap: () {
              Navigator.pop(context);
            },

            child: Icon(
              EvaIcons.closeOutline,
              color: Colors.black45,
              size: 25.0,
            ),
          ),

          //button which takes you to user profile
          TransparentButton(
            text: "Save",
            onPressed: () {
              //return the desired color;

              onSave(selectedColor);
              //then pop context
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

    double padding = sidePadding;

    if (widgetMode) {
      customHeader = customHeader = Padding(
        padding: const EdgeInsets.only(
            top: 0.0, bottom: 5.0, left: sidePadding, right: sidePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Pick a color", style: homeSubTextStyle)

            //button which takes you to user profile
          ],
        ),
      );
      blur = false;
      padding = 0.0;
    }

    //use layout builder to account for different screen sizes
    Widget customBody = Padding(
      padding: EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: padding, right: padding),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return _buildColorGrid(onColorTapped, startingColor,
                      crossAxisCount: 10);
                } else if (constraints.maxWidth > 400) {
                  return _buildColorGrid(onColorTapped, startingColor);
                } else {
                  return _buildColorGrid(onColorTapped, startingColor,
                      crossAxisCount: 7);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: TransparentButton(
              text: "Custom Color",
              width: 150,
              height: 30,
              iconData: EvaIcons.brush,
              onPressed: () {
                //open navigation drawer with custom color picker
                displayColorPicker(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Divider(
              thickness: 0.5,
              color: startingColor.withOpacity(0.5),
            ),
          )
        ],
      ),
    );

    Map params = {
      "context": context,
      "custom_header": customHeader,
      "custom_body": customBody,
      "blur": blur,
      "handle_bar_color": handleBarColor
    };

    Widget navigationDrawerContents = builNavigationDrawer(context, params);

    return navigationDrawerContents;
  }

  Widget _buildColorGrid(Function onColorTapped, Color startingColor,
      {int crossAxisCount = 6}) {
    List<Widget> colorWidgets =
        _buildColorWidgetList(onColorTapped, startingColor);

    Widget widget = GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      children: colorWidgets,
    );

    return widget;
  }

  List<Widget> _buildColorWidgetList(Function onColorTapped, startingColor) {
    List<Widget> list = [];

    Color color2 =
        Colors.white; //white if selected, same color as container if not

    for (int i = 0, length = colorList.length; i < length; i++) {
      bool isSelected = selectedColor == colorList[i];
      Color color = colorList[i];
      Widget widget = AnimatedContainer(
          duration: Duration(milliseconds: 5000),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: color),
          child: GestureDetector(
            onTap: () {
              onColorTapped(color);
              setState(() {
                selectedColor = color;
              });
            },
            child: Icon(
              EvaIcons.checkmarkOutline,
              color: isSelected ? color2 : color,
              size: 20.0,
            ),
          ));
      list.add(widget);
    }
    return list;
  }
}

//========implementation of build navigation drawer here ====//
Widget builNavigationDrawer(BuildContext context, Map params) {
  Widget header = Container(height: 1.0);
  Widget body = Container(height: 1.0);
  Widget container = Container(height: 1.0);
  Color dividerColor = Colors.grey[200];
  Color handleBarColor = Colors.grey[200]; //that little grey line at the top
  double blurSigmaX = 0;
  double blurSigmaY = 0;

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

  container = Container(
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
                    color: handleBarColor,
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

  if (false == params["blur"]) {
    return container;
  }
  //for blur effect
  return new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
      child: container);
}

//====================Interface to be used=====
void callback(Color color) {}
void displayColorPicker(BuildContext context,
    {Function onColorTapped = callback,
    Function onSave = callback,
    bool blur = true,
    Color handleBarColor = Colors.white,
    Color startingColor = Colors.red}) {
/*returns the picked color by the user
    Optional onColorTapped(Color color) callback parameters gets called when user clicks on a color,
    this callback should be used to change any states etc for preview

    onSave(Color color) callback gets called when user clicks the save button, this should be used to change state
    in the invoking widget etc to selected color. 

    optional blur parameter is for background to be blurred or not
  */

  SimpleColorPicker simpleColorPicker = SimpleColorPicker(
    onColorTapped: onColorTapped,
    onSave: onSave,
    blur: blur,
    handleBarColor: handleBarColor,
    startingColor: startingColor,
    widgetMode: false,
  );

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true, //stops max height being half screen
      context: context,
      builder: (BuildContext context) {
        return simpleColorPicker;
      });
}
