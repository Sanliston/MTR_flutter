import 'package:MTR_flutter/components/buttons.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/external/hsv_colorpicker.dart';
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

class AdvancedColorPicker extends StatefulWidget {
  final Color startingColor;
  final bool blur;
  final Function onColorTapped;
  final Function onSave;
  final Color handleBarColor;
  final bool widgetMode;
  final double height;
  void callback(Color color) {}

  AdvancedColorPicker(
      {@required this.onColorTapped,
      @required this.onSave,
      this.blur = true,
      this.widgetMode = true,
      this.handleBarColor = Colors.white,
      this.startingColor = Colors.red,
      this.height = 300});

  @override
  _AdvancedColorPickerState createState() => _AdvancedColorPickerState(
      onColorTapped: this.onColorTapped,
      onSave: this.onSave,
      handleBarColor: this.handleBarColor,
      startingColor: this.startingColor,
      blur: this.blur,
      widgetMode: this.widgetMode,
      height: this.height);
}

class _AdvancedColorPickerState extends State<AdvancedColorPicker> {
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
  HSVColor activeColor;
  String hexColor;
  TextEditingController textInputController;
  Brightness brightness;
  Color textColor;

  _AdvancedColorPickerState(
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

    activeColor = new HSVColor.fromColor(selectedColor);
    hexColor = (activeColor.toColor().value & 0xFFFFFF)
        .toRadixString(16)
        .padLeft(6, '0')
        .toUpperCase();

    textInputController = new TextEditingController();
    textInputController.text = hexColor;

    brightness = ThemeData.estimateBrightnessForColor(startingColor);
    textColor = Brightness.light == brightness ? Colors.black54 : Colors.white;
  }

  @override
  void dispose() {
    super.dispose();

    //free up any used resources here
  }

  void onChanged(HSVColor value) => this.activeColor = value;

  Widget build(BuildContext context) {
    print("color picker called");
    return buildAdvancedColorPicker(context, onColorTapped, onSave,
        widgetMode: widgetMode, height: height, startingColor: startingColor);
  }

  Widget buildAdvancedColorPicker(
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
          top: 0.0, bottom: 10.0, left: sidePadding, right: sidePadding),
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

              onSave(activeColor.toColor());
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

    print("starting color: $startingColor");

    Widget customBody = Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 10.0, left: 0, right: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              height: 150,
              child: Center(
                  child: SizedBox(
                width: 110,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 1.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Container(
                      width: 70,
                      child: TextFormField(
                        key: new GlobalKey(),
                        controller: textInputController,
                        maxLength: 6,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.heebo(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                letterSpacing: 4.0,
                                color: textColor)),
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixText: "#",
                            prefixStyle: GoogleFonts.heebo(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    letterSpacing: 4.0,
                                    color: textColor)),
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            hintText: ""),
                        onChanged: (text) {
                          //see if text has 6 characters
                          if (6 > text.length) {
                            return;
                          }

                          String hexString = '#' + text;

                          //convert text from hex to color -- return if not possible
                          Color color = hexToColor(hexString);

                          print("text obtained: $text, color obtained: $color");

                          //set as selected color through setState
                          setState(() {
                            selectedColor = color;
                            activeColor = new HSVColor.fromColor(selectedColor);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )),
              decoration: BoxDecoration(
                color: activeColor.toColor(),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: sidePadding, right: sidePadding),
            child: HSVPicker(
              color: activeColor,
              onChanged: (value) {
                setState(() {
                  startingColor = activeColor.toColor();
                  activeColor = value;
                  hexColor = (activeColor.toColor().value & 0xFFFFFF)
                      .toRadixString(16)
                      .padLeft(6, '0')
                      .toUpperCase();

                  print("hexColor: $hexColor");
                  textInputController.text = hexColor;

                  brightness =
                      ThemeData.estimateBrightnessForColor(startingColor);

                  textColor = Brightness.light == brightness
                      ? Colors.black54
                      : Colors.white;
                });
              },
            ),
          ),
        ],
      ),
    );

    Map params = {
      "context": context,
      "custom_header": customHeader,
      "custom_body": customBody,
      "blur": blur,
      "handle_bar_color": handleBarColor,
      "top_divider": false
    };

    Widget navigationDrawerContents = buildNavigationDrawer(context, params);

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

      Brightness brightness = ThemeData.estimateBrightnessForColor(color);

      Color selectedIconColor =
          brightness == Brightness.light ? Colors.black54 : color2;

      Widget widget = AnimatedContainer(
          duration: Duration(milliseconds: 5000),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: Colors.grey[400], width: 1.0),
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
              color: isSelected ? selectedIconColor : color,
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
void displayAdvancedColorPicker(BuildContext context,
    {Function onColorTapped = callback,
    Function onSave = callback,
    bool blur = true,
    Color handleBarColor = Colors.white,
    Color startingColor = Colors.blue}) {
/*returns the picked color by the user
    Optional onColorTapped(Color color) callback parameters gets called when user clicks on a color,
    this callback should be used to change any states etc for preview

    onSave(Color color) callback gets called when user clicks the save button, this should be used to change state
    in the invoking widget etc to selected color. 

    optional blur parameter is for background to be blurred or not
  */

  AdvancedColorPicker simpleColorPicker = AdvancedColorPicker(
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

/***************
Used this for reference: https://medium.com/@mhstoller.it/how-i-made-a-custom-color-picker-slider-using-flutter-and-dart-e2350ec693a1 

* */

final double scrollerRadius = 12;

class _SliderIndicatorPainter extends CustomPainter {
  final double position;
  final Color scrollColor;

  _SliderIndicatorPainter(this.position, {this.scrollColor = primaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    // print("Paint passed position: $position");
    Offset center = Offset(position, size.height / 2);

    Paint paintCircle = Paint()..color = scrollColor;

    Paint paintBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Paint paintShadow = Paint()
      ..color = darkNight.withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: scrollerRadius + 3));
    canvas.drawPath(oval, paintShadow);

    canvas.drawCircle(center, scrollerRadius, paintCircle);

    canvas.drawCircle(center, scrollerRadius - 2, paintBorder);
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}

class ColorPicker extends StatefulWidget {
  final double width;
  final Color startingColor;
  ColorPicker(this.width, this.startingColor);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final List<Color> _colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
  ];

  double _colorSliderPosition = 0;
  double _shadeSliderPosition;
  Color _currentColor;
  Color _shadedColor;
  Color colorTextColor;
  TextStyle colorTextStyle;
  String currentHex;

  @override
  initState() {
    super.initState();
    //_colorSliderPosition = _getInitialPosition(widget.startingColor);

    _currentColor = _calculateSelectedColor(_colorSliderPosition);
    _shadeSliderPosition = widget.width / 2; //center the shader selector
    _shadedColor = _calculateShadedColor(_shadeSliderPosition);

    _setInitialPosition(widget.startingColor);

    colorTextColor = Colors.white;
  }

  @override
  dispose() {
    super.dispose();
  }

  void _setInitialPosition(Color color,
      {int tolerance = 64, bool secondRun = false}) {
    //TODO - set the position based on the starting color that's passed in the initialState

    //get RGB value of color and separate in red, blue, green
    int red = color.red;
    int blue = color.blue;
    int green = color.green;

    //print("red value: $red, blue value $blue, green value $green");

    List<int> redIndexes = [];

    //narrow index values to those closest to our red value
    for (int i = 0; i < _colors.length; i++) {
      int obtainedRed = _colors[i].red;
      int difference = (obtainedRed - red).abs();
      print("difference: $difference");

      if (difference <= tolerance) {
        redIndexes.add(i);
      }
    }

    //print("obtained red indexes: $redIndexes");

    //get blue indexes from redIndexes

    List<int> blueIndexes = [];

    //narrow index values to those closest to our red value
    for (int i = 0; i < redIndexes.length; i++) {
      int obtainedBlue = _colors[redIndexes[i]].blue;
      print("obtained blue: $obtainedBlue");
      int difference = (obtainedBlue - blue).abs();

      if (difference <= tolerance) {
        blueIndexes.add(redIndexes[i]);
      }
    }

    //print("obtained blue indexes: $blueIndexes");

    //get green indexes from redIndexes

    List<int> greenIndexes = [];

    //narrow index values to those closest to our red value
    for (int i = 0; i < blueIndexes.length; i++) {
      int obtainedGreen = _colors[blueIndexes[i]].green;
      print("obtained green : $obtainedGreen");
      int difference = (obtainedGreen - green).abs();

      if (difference <= tolerance) {
        greenIndexes.add(blueIndexes[i]);
      }
    }

    //print("obtained green indexes: $greenIndexes");

    if (secondRun && 0 == greenIndexes.length) {
      _colorChangeHandler(0);
    }

    double position = 0;

    if (0 < greenIndexes.length) {
      position = greenIndexes[0].toDouble();
    }

    //move slider to the interpolated position

    position = position * (widget.width * (_colors.length - 1));
    position = position / 100;

    //print("calculated position: $position");
    _colorChangeHandler(position);
  }

  _colorChangeHandler(double position) {
    //account for scrollRadius
    position = position - scrollerRadius - (scrollerRadius / 4);
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < (scrollerRadius / 2)) {
      //print("positon less than 0: $position");
      position = scrollerRadius / 2;
    }
    //print("New pos: $position");
    setState(() {
      _colorSliderPosition = position;
      _currentColor = _calculateSelectedColor(_colorSliderPosition);
      _shadedColor = _calculateShadedColor(_shadeSliderPosition);
    });
  }

  _shadeChangeHandler(double position) {
    //handle out of bounds gestures
    if (position > widget.width) position = widget.width;
    if (position < 0) position = 0;
    setState(() {
      _shadeSliderPosition = position;
      _shadedColor = _calculateShadedColor(_shadeSliderPosition);
      print(
          "r: ${_shadedColor.red}, g: ${_shadedColor.green}, b: ${_shadedColor.blue}");
    });
  }

  Color _calculateShadedColor(double position) {
    double ratio = position / widget.width;
    if (ratio > 0.5) {
      //Calculate new color (values converge to 255 to make the color lighter)
      int redVal = _currentColor.red != 255
          ? (_currentColor.red +
                  (255 - _currentColor.red) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      int greenVal = _currentColor.green != 255
          ? (_currentColor.green +
                  (255 - _currentColor.green) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      int blueVal = _currentColor.blue != 255
          ? (_currentColor.blue +
                  (255 - _currentColor.blue) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      //Calculate new color (values converge to 0 to make the color darker)
      int redVal = _currentColor.red != 0
          ? (_currentColor.red * ratio / 0.5).round()
          : 0;
      int greenVal = _currentColor.green != 0
          ? (_currentColor.green * ratio / 0.5).round()
          : 0;
      int blueVal = _currentColor.blue != 0
          ? (_currentColor.blue * ratio / 0.5).round()
          : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      //return the base color
      return _currentColor;
    }
  }

  Color _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            height: 175,
            child: Center(
                child: SizedBox(
              width: 95,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1.0))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: 70,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.heebo(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              letterSpacing: 4.0,
                              color: colorTextColor)),
                      decoration: InputDecoration(
                          prefixText: "#",
                          prefixStyle: GoogleFonts.heebo(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  letterSpacing: 4.0,
                                  color: colorTextColor)),
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          border: InputBorder.none,
                          hintText: ''),
                    ),
                  ),
                ),
              ),
            )),
            decoration: BoxDecoration(
              color: _shadedColor,
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              print("_-------------------------STARTED DRAG");
              _colorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            //This outside padding makes it much easier to grab the   slider because the gesture detector has
            // the extra padding to recognize gestures inside of
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: _colors),
                ),
                child: CustomPaint(
                  painter: _SliderIndicatorPainter(_colorSliderPosition,
                      scrollColor: _shadedColor),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              print("_-------------------------STARTED DRAG");
              _shadeChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _shadeChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _shadeChangeHandler(details.localPosition.dx);
            },
            //This outside padding makes it much easier to grab the slider because the gesture detector has
            // the extra padding to recognize gestures inside of
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Colors.black, _currentColor, Colors.white]),
                ),
                child: CustomPaint(
                  painter: _SliderIndicatorPainter(_shadeSliderPosition,
                      scrollColor: _shadedColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
