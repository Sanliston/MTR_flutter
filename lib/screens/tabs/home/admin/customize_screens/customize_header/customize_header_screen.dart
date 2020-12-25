import 'package:MTR_flutter/blur_on_scroll.dart';
import 'package:MTR_flutter/components/color_picker.dart';
import 'package:MTR_flutter/core_overrides/custom_reorderable_list.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:flutter/rendering.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

enum Options {
  primaryColor,
  secondaryColor,
  accentColor,
  gradientFirstColor,
  gradientSecondColor,
  gradientThirdColor
}

enum WorkingColors {
  primaryColor,
  secondaryColor,
  accentColor,
  gradientFirstColor,
  gradientSecondColor,
  gradientThirdColor
}

void dummyCB() {}

class CustomizeHeaderScreen extends StatefulWidget {
  @override
  _CustomizeHeaderScreenState createState() => _CustomizeHeaderScreenState();
}

class _CustomizeHeaderScreenState extends State<CustomizeHeaderScreen> {
  ScrollController mainScrollController = new ScrollController();
  List list;
  Color workingPrimaryColor;
  Color workingSecondaryColor;
  Color workingAccentColor;

  Color workingFirstGradientColor;
  Color workingSecondGradientColor;
  Color workingThirdGradientColor;

  Widget dormantWidget = Container(height: 1.0);
  double containerHeight = 1.0;
  bool colorEditorOpened = false;

  WorkingColors targetColor;
  Options currentOption;
  Map<Options, Widget> colorPickerContainers;
  Map<Options, double> colorPickerContainerHeights;
  Map<WorkingColors, Color> workingColors;

  @override
  void initState() {
    super.initState();

    list = [
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
    ];

    workingColors = {
      WorkingColors.primaryColor: primaryColor,
      WorkingColors.secondaryColor: secondaryColor,
      WorkingColors.accentColor: accentColor,
      WorkingColors.gradientFirstColor: primaryColor,
      WorkingColors.gradientSecondColor: secondaryColor,
      WorkingColors.gradientThirdColor: accentColor
    };

    targetColor = null;

    colorPickerContainers = {
      Options.primaryColor: dormantWidget,
      Options.secondaryColor: dormantWidget,
      Options.accentColor: dormantWidget,
      Options.gradientFirstColor: dormantWidget,
      Options.gradientSecondColor: dormantWidget,
      Options.gradientThirdColor: dormantWidget
    };

    colorPickerContainerHeights = {
      Options.primaryColor: 1.0,
      Options.secondaryColor: 1.0,
      Options.accentColor: 1.0,
      Options.gradientFirstColor: 1.0,
      Options.gradientSecondColor: 1.0,
      Options.gradientThirdColor: 1.0
    };

    //state stuff here
  }

  @override
  void dispose() {
    super.dispose();

    //free up any used resources here
  }

  _CustomizeHeaderScreenState(); //constructor call

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            title: Text('Customize Header', style: homeTextStyleBoldWhite),
            centerTitle: true,
            backgroundColor: darkNight,
            leading: IconButton(
              icon: const Icon(EvaIcons.closeOutline),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    //call controller to make changes to home_state
                  },
                  child:
                      Center(child: Text('Save', style: homeTextStyleWhite))),
            ]),
        body: CustomScrollView(
          controller: mainScrollController,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 305.0,
              floating: false,
              pinned: false,
              snap: false,
              elevation: 50,
              backgroundColor: darkNight,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: FadeOnScroll(
                  scrollController: mainScrollController,
                  zeroOpacityOffset: 300,
                  fullOpacityOffset: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0,
                        left: memberViewPadding,
                        right: memberViewPadding),
                    child:
                        AbsorbPointer(child: buildHeaderPreview(context, 0.9)),
                  ),
                ),
              ),
            ),
            new SliverList(delegate: new SliverChildListDelegate(_buildList())),
          ],
        ),
      ),
    );
  }

  List _buildList() {
    List<Widget> listItems = [
      buildPlaceName(),
      buildTagLine(),
      buildPlaceLogo(),
      buildCoverPhoto(),
      buildThemeColors(),
      buildGradientBackground()
    ];

    return listItems;
  }

  Padding buildGradientBackground() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gradient Background", style: homeTextStyleBold),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: workingColors[WorkingColors.primaryColor],
                    size: 40.0,
                  )
                ],
              ),
              Container(
                height: 50.0,
                child: Text(
                    "This changes the background of the header to a gradient of your chosen colors. Enabling this option automatically disables the Background Photo.",
                    style: homeSubTextStyle,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: AnimatedContainer(
                  //turn this into animated container
                  duration: Duration(milliseconds: 1500),
                  height: 100,
                  width:
                      MediaQuery.of(context).size.width - (sidePadding * 2.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        //maybe in future versions you can have an advanced tool for users to create gradients
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          workingColors[WorkingColors.gradientFirstColor],
                          workingColors[WorkingColors.gradientSecondColor],
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              buildColorRow("First Color",
                  workingColors[WorkingColors.gradientFirstColor],
                  onTapCallback: () {
                toggleColorEditor(Options.gradientFirstColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.gradientFirstColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height: colorPickerContainerHeights[Options.gradientFirstColor],
                child: colorPickerContainers[Options.gradientFirstColor],
              ),
              buildColorRow("Second Color",
                  workingColors[WorkingColors.gradientSecondColor],
                  onTapCallback: () {
                toggleColorEditor(Options.gradientSecondColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.gradientSecondColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height:
                    colorPickerContainerHeights[Options.gradientSecondColor],
                child: colorPickerContainers[Options.gradientSecondColor],
              ),
              buildColorRow("Third Color (Optional)",
                  workingColors[WorkingColors.gradientThirdColor],
                  onTapCallback: () {
                toggleColorEditor(Options.gradientThirdColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.gradientThirdColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height: colorPickerContainerHeights[Options.gradientThirdColor],
                child: colorPickerContainers[Options.gradientThirdColor],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorRow(String text, Color color,
      {Function onTapCallback = dummyCB,
      Function longpressCallback = dummyCB}) {
    return ElevatedButton(
      onPressed: onTapCallback,
      onLongPress: longpressCallback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  EvaIcons.droplet,
                  color: color,
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(text, style: homeSubTextStyleBold),
                ),
              ],
            ),
            Icon(
              EvaIcons.colorPaletteOutline,
              color: color,
              size: 25.0,
            )
          ],
        ),
      ),
    );
  }

  Padding buildThemeColors() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Theme Colors", style: homeTextStyleBold),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: workingColors[WorkingColors.primaryColor],
                    size: 40.0,
                  )
                ],
              ),
              Container(
                height: 40.0,
                child: Text(
                    "These are the colors used by buttons and links. When user clicks the color a color selection tool will popup",
                    style: homeSubTextStyle,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
              ),
              buildColorRow(
                  "Primary Color", workingColors[WorkingColors.primaryColor],
                  onTapCallback: () {
                toggleColorEditor(Options.primaryColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.primaryColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height: colorPickerContainerHeights[Options.primaryColor],
                child: colorPickerContainers[Options.primaryColor],
              ),
              buildColorRow("Secondary Color",
                  workingColors[WorkingColors.secondaryColor],
                  onTapCallback: () {
                toggleColorEditor(Options.secondaryColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.secondaryColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height: colorPickerContainerHeights[Options.secondaryColor],
                child: colorPickerContainers[Options.secondaryColor],
              ),
              buildColorRow(
                  "Accent Color", workingColors[WorkingColors.accentColor],
                  onTapCallback: () {
                toggleColorEditor(Options.accentColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.accentColor);
              }),
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                height: colorPickerContainerHeights[Options.accentColor],
                child: colorPickerContainers[Options.accentColor],
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleColorEditor(Options option) {
    Options previousOption = currentOption;
    currentOption = option;
    switch (option) {
      case Options.primaryColor:
        targetColor = WorkingColors.primaryColor;
        break;

      case Options.secondaryColor:
        targetColor = WorkingColors.secondaryColor;

        break;

      case Options.accentColor:
        targetColor = WorkingColors.accentColor;
        break;

      case Options.gradientFirstColor:
        targetColor = WorkingColors.gradientFirstColor;
        break;

      case Options.gradientSecondColor:
        targetColor = WorkingColors.gradientSecondColor;
        break;

      case Options.gradientThirdColor:
        targetColor = WorkingColors.gradientThirdColor;
        break;

      default:
        targetColor = WorkingColors.primaryColor;
    }

    setState(() {
      if (colorEditorOpened && currentOption == previousOption) {
        colorPickerContainers[previousOption] = Container(height: 1.0);
        colorPickerContainerHeights[previousOption] = 1.0;
        colorEditorOpened = false;

        return;
      }

      if (previousOption != currentOption) {
        colorPickerContainers[previousOption] = Container(height: 1.0);
        colorPickerContainerHeights[previousOption] = 1.0;
      }

      colorPickerContainers[currentOption] = SimpleColorPicker(
        height: 300,
        onColorTapped: (color) {
          print("on color tapped called");
          setState(() {
            workingColors[targetColor] = color;
          });
        },
        onSave: (color) {
          setState(() {
            workingColors[targetColor] = color;
          });
        },
        startingColor: workingColors[targetColor],
      );

      colorPickerContainerHeights[currentOption] = 400;
      colorEditorOpened = true;
    });
  }

  void displayPopupColorEditor(Options option) {
    WorkingColors selectedColor;

    switch (option) {
      case Options.primaryColor:
        selectedColor = WorkingColors.primaryColor;
        break;

      case Options.secondaryColor:
        selectedColor = WorkingColors.secondaryColor;

        break;

      case Options.accentColor:
        selectedColor = WorkingColors.accentColor;
        break;

      case Options.gradientFirstColor:
        selectedColor = WorkingColors.gradientFirstColor;
        break;

      case Options.gradientSecondColor:
        selectedColor = WorkingColors.gradientSecondColor;
        break;

      case Options.gradientThirdColor:
        selectedColor = WorkingColors.gradientThirdColor;
        break;

      default:
        selectedColor = WorkingColors.primaryColor;
    }

    displayColorPicker(context,
        startingColor: workingColors[selectedColor],
        blur: true, onColorTapped: (color) {
      setState(() {
        workingColors[selectedColor] = color;
      });
    }, onSave: (color) {
      setState(() {
        workingColors[selectedColor] = color;
      });
    });
  }

  Padding buildCoverPhoto() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Background Photo", style: homeTextStyleBold),
                      Text("Suggested size: 750x350 px",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    EvaIcons.plusCircleOutline,
                    color: workingColors[WorkingColors.primaryColor],
                    size: 25.0,
                  )
                ],
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - (sidePadding * 2.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: CustomReorderableListView(
                      padding: EdgeInsets.only(right: 25.0),
                      scrollDirection: Axis.horizontal,
                      children: buildPhotoList(),
                      onReorder: (oldIndex, newIndex) {
                        String old = list[oldIndex];
                        if (oldIndex > newIndex) {
                          for (int i = oldIndex; i > newIndex; i--) {
                            list[i] = list[i - 1];
                          }
                          list[newIndex] = old;
                        } else {
                          for (int i = oldIndex; i < newIndex - 1; i++) {
                            list[i] = list[i + 1];
                          }
                          list[newIndex - 1] = old;
                        }
                        setState(() {});
                      }),
                ),
              ),
              Text("Tap, hold and drag to reorder", style: homeSubTextStyle)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildPhotoList() {
    List<Widget> photoList = [];
    Widget temp;

    for (var i = 0; i < list.length; i++) {
      temp = Container(
        key: GlobalKey(),
        height: 70,
        margin: EdgeInsets.only(left: 0, right: 0),
        width: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  image: DecorationImage(
                    image: AssetImage(list[i]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null /* add child content here */,
              ),
            ),
            Container(
                height: 15,
                width: 15,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      EvaIcons.closeOutline,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    onPressed: null),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                )),
          ],
        ),
      );

      photoList.add(temp);
    }

    return photoList;
  }

  Padding buildPlaceLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Place Logo", style: homeTextStyleBold),
                      Text("Suggested size: 200x200 px",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: workingColors[WorkingColors.primaryColor],
                    size: 40.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home_background.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null /* add child content here */,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child:
                              Text("Replace Logo", style: homeSubTextStyleBold),
                        ),
                      ],
                    ),
                    Icon(
                      EvaIcons.editOutline,
                      color: workingColors[WorkingColors.primaryColor],
                      size: 25.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTagLine() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tagline", style: homeTextStyleBold),
                      Text("Add a short tagline to describe your place",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: workingColors[WorkingColors.primaryColor],
                    size: 40.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tagline", style: homeSubTextStyle),
                    Container(
                      height: 35.0,
                      child: TextFormField(
                        style: homeTextStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a tagline'),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[400], width: 1.0))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("14/25", style: homeTextStyle)],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPlaceName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Place Name", style: homeTextStyleBold),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text("Title", style: homeSubTextStyle),
                    ),
                    Container(
                      height: 35.0,
                      child: TextFormField(
                        style: homeTextStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a place name'),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[400], width: 1.0))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("14/20", style: homeTextStyle)],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderPreview(BuildContext context, double sizeFactor) {
    Widget widget = Stack(
      children: [
        headerBuilders['preview_background'](400.0,
            MediaQuery.of(context).size.width - (memberViewPadding * 2.0),
            gradientFirstColor: workingColors[WorkingColors.gradientFirstColor],
            gradientSecondColor:
                workingColors[WorkingColors.gradientSecondColor]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CustomizeHeaderScreen()));
              },
              padding: EdgeInsets.zero,
              child: AbsorbPointer(
                child: SizedBox(
                    height: 280.0,
                    child: headerBuilders['header'](
                      context,
                      memberViewMode: true,
                      sizeFactor: sizeFactor,
                    )),
              ),
            )
          ],
        )
      ],
    );
    return widget;
  }
}
