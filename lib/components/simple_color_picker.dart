import 'package:MTR_flutter/components/advanced_color_picker.dart';
import 'package:MTR_flutter/components/buttons.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'dart:ui';

import 'package:flutter_swiper/flutter_swiper.dart';

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
  final double sidePadding;
  void callback(Color color) {}

  SimpleColorPicker(
      {@required this.onColorTapped,
      @required this.onSave,
      this.blur = true,
      this.widgetMode = true,
      this.handleBarColor = Colors.white,
      this.startingColor = Colors.red,
      this.height = 300,
      this.sidePadding = 15.0});

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
  static const List<Color> colorList = [
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

  static const List<Color> firstSlideColorList = [
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
  ];

  static const List<Color> secondSlideColorList = [
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
  ];

  static const List<Color> thirdSlideColorList = [
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
  ];

  static const List<Color> fourthSlideColorList = [
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
  ];

  List<Color> customColorList = [];

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
      double height = 200.0}) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  List<Widget> slides = _buildColorGrid(
                      onColorTapped, startingColor,
                      crossAxisCount: 8);

                  Widget swiper = new Swiper(
                    itemCount: slides.length,
                    pagination: new SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey[200], activeColor: primaryColor),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: sidePadding, right: sidePadding),
                        child: slides[index],
                      );
                    },
                  );

                  return swiper;
                } else {
                  List<Widget> slides = _buildColorGrid(
                      onColorTapped, startingColor,
                      crossAxisCount: 7);

                  Widget swiper = new Swiper(
                    itemCount: slides.length,
                    pagination: new SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey[200], activeColor: primaryColor),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: sidePadding, right: sidePadding),
                        child: slides[index],
                      );
                    },
                  );

                  return swiper;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: sidePadding, right: sidePadding),
            child: Text("Custom Color", style: homeSubTextStyle),
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: sidePadding * 2, right: sidePadding),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 1),
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: IconButton(
                          iconSize: 18,
                          icon: Icon(EvaIcons.plusOutline),
                          onPressed: () {
                            print(
                                "selected color: " + selectedColor.toString());
                            //open navigation drawer with custom color picker
                            displayAdvancedColorPicker(context,
                                startingColor: selectedColor, onSave: (color) {
                              selectedColor = color;
                              //check if color exists in customColorList or any of the other lists

                              //use 1 for loop, using the largest index as limit
                              int limit = customColorList.length >
                                      firstSlideColorList.length
                                  ? customColorList.length
                                  : firstSlideColorList.length;

                              //remembering that the 4 color lists have same length. Only the custom list will be diff as it is defined by user

                              for (int i = 0; i < limit; i++) {
                                if (null != customColorList[i] &&
                                    customColorList[i] == color) {
                                  //color matched, exit

                                  return null;
                                }

                                if (null != firstSlideColorList[i] &&
                                    firstSlideColorList[i] == color) {
                                  //color matched, exit

                                  return null;
                                }

                                if (null != secondSlideColorList[i] &&
                                    secondSlideColorList[i] == color) {
                                  //color matched, exit

                                  return null;
                                }

                                if (null != thirdSlideColorList[i] &&
                                    thirdSlideColorList[i] == color) {
                                  //color matched, exit

                                  return null;
                                }

                                if (null != fourthSlideColorList[i] &&
                                    fourthSlideColorList[i] == color) {
                                  //color matched, exit

                                  return null;
                                }
                              }

                              //add color to customColor list
                              setState(() {
                                customColorList.add(color);

                                onSave(color);
                              });

                              //animate this
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: customColorList.length,
                          itemBuilder: (context, index) {
                            Color color = customColorList[index];
                            bool isSelected =
                                selectedColor == customColorList[index];
                            Color color2 = Colors.white;
                            Widget colorWidget = Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 2000),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: customColorList[index]),
                                  child: SizedBox(
                                    height: 35,
                                    width: 35,
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
                                    ),
                                  )),
                            );

                            return colorWidget;
                          }),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: sidePadding, right: sidePadding),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[200],
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
      "handle_bar_color": handleBarColor,
      "side_padding": widget.sidePadding
    };

    Widget navigationDrawerContents = builNavigationDrawer(context, params);

    return navigationDrawerContents;
  }

  List<Widget> _buildColorGrid(Function onColorTapped, Color startingColor,
      {int crossAxisCount = 6}) {
    double spaceBetween = (MediaQuery.of(context).size.width / 7) * 0.4;
    List<Widget> colorWidgets =
        _buildColorWidgetList(onColorTapped, startingColor);

    //only have maximum of 3 rows
    int rows = 3;
    int maximumCount = crossAxisCount * rows;

    List<Widget> firstSlideColorWidgets = _buildColorWidgetList(
        onColorTapped, startingColor,
        colorList: firstSlideColorList);

    List<Widget> secondSlideColorWidgets = _buildColorWidgetList(
        onColorTapped, startingColor,
        colorList: secondSlideColorList);

    List<Widget> thirdSlideColorWidgets = _buildColorWidgetList(
        onColorTapped, startingColor,
        colorList: thirdSlideColorList);

    List<Widget> fourthSlideColorWidgets = _buildColorWidgetList(
        onColorTapped, startingColor,
        colorList: fourthSlideColorList);

    Widget firstSlideWidget = GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spaceBetween,
      mainAxisSpacing: spaceBetween,
      children: firstSlideColorWidgets,
    );

    Widget secondSlideWidget = GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spaceBetween,
      mainAxisSpacing: spaceBetween,
      children: secondSlideColorWidgets,
    );

    Widget thirdSlideWidget = GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spaceBetween,
      mainAxisSpacing: spaceBetween,
      children: thirdSlideColorWidgets,
    );

    Widget fourthSlideWidget = GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spaceBetween,
      mainAxisSpacing: spaceBetween,
      children: fourthSlideColorWidgets,
    );

    List<Widget> slides = [
      firstSlideWidget,
      secondSlideWidget,
      thirdSlideWidget,
      fourthSlideWidget
    ];

    return slides;
  }

  List<Widget> _buildColorWidgetList(Function onColorTapped, startingColor,
      {List<Color> colorList = colorList,
      int startingCount = 0,
      int maximumCount = 50}) {
    List<Widget> list = [];

    Color color2 =
        Colors.white; //white if selected, same color as container if not

    startingCount = startingCount < colorList.length ? startingCount : 0;

    for (int i = startingCount, length = colorList.length; i < length; i++) {
      if (i == maximumCount) {
        break;
      }

      bool isSelected = selectedColor == colorList[i];
      Color color = colorList[i];
      Widget widget = AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: color),
          child: SizedBox(
            height: 15,
            width: 15,
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
