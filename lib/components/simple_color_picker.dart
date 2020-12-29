import 'package:MTR_flutter/components/advanced_color_picker.dart';
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
                print("selected color: " + selectedColor.toString());
                //open navigation drawer with custom color picker
                displayAdvancedColorPicker(context,
                    startingColor: selectedColor);
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
          duration: Duration(milliseconds: 2000),
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

//====================Interface to be used=====
void callback(Color color) {}
void displaySimpleColorPicker(BuildContext context,
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
