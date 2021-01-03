import 'package:MTR_flutter/blur_on_scroll.dart';
import 'package:MTR_flutter/components/buttons.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/components/simple_color_picker.dart';
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

  GradientOrientations workingGradientOrientation;

  Widget dormantWidget = Container(height: 1.0);
  double containerHeight = 1.0;
  bool colorEditorOpened = false;

  WorkingColors targetColor;
  Options currentOption;
  Map<Options, Widget> colorPickerContainers;
  Map<Options, double> colorPickerContainerHeights;
  Map<WorkingColors, Color> workingColors;
  bool gradientThirdColorEnabled = false;
  FocusNode customButtonFocusNode;
  FocusNode customButtonActionFocusNode;
  FocusNode placeNameFocusNode;
  FocusNode taglineFocusNode;
  FocusNode gradientOFocusNode;

  TextEditingController placeNameController;
  TextEditingController taglineController;
  TextEditingController customButtonLabelController;
  TextEditingController customButtonActionController;
  TextEditingController gradientOController;

  bool workingTaglineActive;
  bool workingPlaceLogoActive;
  bool workingBGGradientActive;
  bool workingMemberPreviewActive;
  bool workingInviteButtonActive;
  bool workingCustomButtonActive;

  backgroundStyles workingBackgroundStyle;

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

    workingGradientOrientation = gradientOrientation;

    //state stuff here
    workingTaglineActive = contentLayouts['header'][headerOptions.tagLine];
    workingPlaceLogoActive = contentLayouts['header'][headerOptions.placeLogo];
    workingBGGradientActive = contentLayouts['header']
            [headerOptions.backgroundStyle] ==
        backgroundStyles.gradient;
    workingMemberPreviewActive =
        contentLayouts['header'][headerOptions.memberPreview];
    workingInviteButtonActive =
        contentLayouts['header'][headerOptions.inviteButton];
    workingCustomButtonActive =
        contentLayouts['header'][headerOptions.customButton];

    workingBackgroundStyle =
        contentLayouts['header'][headerOptions.backgroundStyle];

    customButtonFocusNode = new FocusNode();
    customButtonActionFocusNode = new FocusNode();
    placeNameFocusNode = new FocusNode();
    taglineFocusNode = new FocusNode();
    gradientOFocusNode = new FocusNode();

    placeNameController = new TextEditingController();
    taglineController = new TextEditingController();
    customButtonLabelController = new TextEditingController();
    customButtonActionController = new TextEditingController();
    gradientOController = new TextEditingController();

    customButtonActionFocusNode.canRequestFocus =
        false; //we don't want to actually be able to write in this one -- this doesnt seem to work
    gradientOFocusNode.canRequestFocus = false;

    //to stop certain focus nodes from getting focus -- this actually works
    gradientOFocusNode.addListener(() {
      unfocus(context);
    });

    customButtonActionFocusNode.addListener(() {
      unfocus(context);
    });
  }

  @override
  void dispose() {
    customButtonFocusNode.dispose();
    customButtonActionFocusNode.dispose();
    placeNameFocusNode.dispose();
    taglineFocusNode.dispose();
    gradientOFocusNode.dispose();

    placeNameController.dispose();
    taglineController.dispose();
    customButtonLabelController.dispose();
    customButtonActionController.dispose();
    gradientOController.dispose();

    super.dispose();

    //free up any used resources here

    //dispose controllers etc
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  _CustomizeHeaderScreenState(); //constructor call

  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
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
                      child: AbsorbPointer(
                          child: buildHeaderPreview(context, 0.9)),
                    ),
                  ),
                ),
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate(_buildList())),
            ],
          ),
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
      buildGradientBackground(),
      buildShowMemberList(),
      buildShowInviteButton(),
      buildShowCustomButton(),
      Container(height: 200, color: Colors.white)
    ];

    return listItems;
  }

  Padding buildShowCustomButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
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
                      Text("Show Custom Button", style: homeTextStyleBold),
                      Text("Define parameters for your custom button here",
                          style:
                              homeSubTextStyle), //should be displayed only if custom button is enabled
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        workingCustomButtonActive = !workingCustomButtonActive;
                      });
                    },
                    icon: Icon(
                      workingCustomButtonActive
                          ? UniconsSolid.toggle_on
                          : UniconsSolid.toggle_off,
                      color: workingCustomButtonActive
                          ? workingColors[WorkingColors.primaryColor]
                          : Colors.grey[400],
                      size: 40.0,
                    ),
                  )
                ],
              ),
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild: _buildCustomButtonBody(),
                  secondChild: Container(height: 0.0),
                  crossFadeState: workingCustomButtonActive
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButtonBody() {
    Widget widget = Padding(
      padding: const EdgeInsets.only(top: 00.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70.0,
            child: TextFormField(
              focusNode: customButtonFocusNode,
              controller: customButtonLabelController,
              maxLength: 15,
              style: homeSubTextStyle,
              onTap: () {
                _requestFocus(customButtonFocusNode);
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (customButtonFocusNode.hasFocus) {
                          customButtonLabelController.clear();
                        }
                      },
                      icon: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: Icon(
                          EvaIcons.closeCircleOutline,
                          color: customButtonFocusNode.hasFocus
                              ? primaryColor
                              : Colors.transparent,
                          size: 22,
                        ),
                      )),
                  contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Button Label',
                  labelStyle: GoogleFonts.heebo(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: customButtonFocusNode.hasFocus ||
                                  customButtonLabelController.text.isNotEmpty
                              ? 16
                              : 12,
                          color: customButtonFocusNode.hasFocus
                              ? workingColors[WorkingColors.primaryColor]
                              : Colors.black54)),
                  alignLabelWithHint: true, //stops it being so high
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300])),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: workingColors[WorkingColors.primaryColor]),
                  ),
                  hintText: '',
                  hintStyle: GoogleFonts.heebo(
                      textStyle: TextStyle(
                          height: 2.5,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.black54))),
            ),
          ),
          Container(
            height: 70.0,
            child: TextFormField(
              focusNode: customButtonActionFocusNode,
              controller: customButtonActionController,
              maxLength: 15,
              style: homeSubTextStyle,
              showCursor: false,
              enableInteractiveSelection: false,
              onTap: () {
                //_requestFocus(customButtonFocusNode);
                unfocus(context);

                //open botton navigation drawer:
                List options = [
                  {
                    "iconData": EvaIcons.calendarOutline,
                    "title": "Book a Service",
                    "onPressed": () {
                      customButtonActionController.text = "Book a service";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.pricetagsOutline,
                    "title": "Buy a Product",
                    "onPressed": () {
                      customButtonActionController.text = "Buy a Product";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.messageCircleOutline,
                    "title": "Send Us a Message",
                    "onPressed": () {
                      customButtonActionController.text = "Send Us a Message";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.linkOutline,
                    "title": "Open URL",
                    "onPressed": () {
                      customButtonActionController.text = "Open URL";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.emailOutline,
                    "title": "Send Email",
                    "onPressed": () {
                      customButtonActionController.text = "Send Email";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.phoneOutline,
                    "title": "Call Phone Number",
                    "onPressed": () {
                      customButtonActionController.text = "Call Phone Number";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  }
                ];

                Map params = {
                  "context": context,
                  "title": "Choose Button Action",
                  "description":
                      "What should the custom button do when the user taps it?",
                  "options": options,
                  "on_close": () {
                    //remove focus from text field
                    print("on_close function called ");
                    unfocus(context);
                  }
                };

                displayNavigationDrawer(context, params);
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    EvaIcons.arrowDownOutline,
                    color: Colors.grey[400],
                    size: 22,
                  ),
                  contentPadding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: customButtonActionController.text.isEmpty
                      ? 'Choose an action'
                      : 'Selected action: ',
                  labelStyle: GoogleFonts.heebo(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: customButtonActionFocusNode.hasFocus ||
                                  customButtonActionController.text.isNotEmpty
                              ? 16
                              : 12,
                          color: customButtonActionFocusNode.hasFocus
                              ? workingColors[WorkingColors.primaryColor]
                              : Colors.black54)),
                  alignLabelWithHint: true, //stops it being so high
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300])),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: workingColors[WorkingColors.primaryColor]),
                  ),
                  counterText: "",
                  hintText: '',
                  hintStyle: GoogleFonts.heebo(
                      textStyle: TextStyle(
                          height: 2.5,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.black54))),
            ),
          ),
        ],
      ),
    );

    return widget;
  }

  Padding buildShowInviteButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Show Invite Button", style: homeTextStyleBold),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingInviteButtonActive = !workingInviteButtonActive;
                  });
                },
                icon: Icon(
                  workingInviteButtonActive
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingInviteButtonActive
                      ? workingColors[WorkingColors.primaryColor]
                      : Colors.grey[400],
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildShowMemberList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Show Member List", style: homeTextStyleBold),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingMemberPreviewActive = !workingMemberPreviewActive;
                  });
                },
                icon: Icon(
                  workingMemberPreviewActive
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingMemberPreviewActive
                      ? workingColors[WorkingColors.primaryColor]
                      : Colors.grey[400],
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildGradientBackground() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: sidePadding, bottom: sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: sidePadding, right: sidePadding),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: sidePadding, right: sidePadding),
                child: Container(
                  height: 50.0,
                  child: Text(
                      "This changes the background of the header to a gradient of your chosen colors. Enabling this background style automatically disables any other specified background style.",
                      style: homeSubTextStyle,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: sidePadding, right: sidePadding),
                child: Divider(
                  thickness: 1.0,
                  color: workingColors[WorkingColors.gradientFirstColor]
                      .withOpacity(0.15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 5.0,
                    left: sidePadding,
                    right: sidePadding),
                child: Text(
                  "Gradient Colors",
                  style: homeSubTextStyleBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: sidePadding, right: sidePadding),
                child: AnimatedContainer(
                  //turn this into animated container
                  duration: Duration(milliseconds: 1500),
                  height: 200,
                  width:
                      MediaQuery.of(context).size.width - (sidePadding * 2.0),
                  decoration: BoxDecoration(
                      gradient: gradientThirdColorEnabled
                          ? getGradient(
                              gradientFirstColor: workingColors[
                                  WorkingColors.gradientFirstColor],
                              gradientSecondColor: workingColors[
                                  WorkingColors.gradientSecondColor],
                              gradientThirdColor: workingColors[
                                  WorkingColors.gradientThirdColor],
                              gradientOrientation: workingGradientOrientation)
                          : getGradient(
                              gradientFirstColor: workingColors[
                                  WorkingColors.gradientFirstColor],
                              gradientSecondColor: workingColors[
                                  WorkingColors.gradientSecondColor],
                              gradientOrientation: workingGradientOrientation),
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
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild:
                      colorPickerContainers[Options.gradientSecondColor],
                  secondChild: Container(height: 0.0),
                  crossFadeState:
                      colorPickerContainers[Options.gradientSecondColor]
                              is SimpleColorPicker
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond),
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 200),
                  firstChild: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: SolidButton(
                        text: "Add third color",
                        width: 150,
                        height: 30,
                        iconData: EvaIcons.plusCircleOutline,
                        onPressed: () {
                          setState(() {
                            gradientThirdColorEnabled = true;
                          });
                        },
                      ),
                    ),
                  ),
                  secondChild: Container(height: 0.0),
                  crossFadeState: gradientThirdColorEnabled
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst),
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild: buildColorRow("Third Color",
                      workingColors[WorkingColors.gradientThirdColor],
                      onTapCallback: () {
                    toggleColorEditor(Options.gradientThirdColor);
                  }, longpressCallback: () {
                    displayPopupColorEditor(Options.gradientThirdColor);
                  }),
                  secondChild: Container(height: 0.0),
                  crossFadeState: gradientThirdColorEnabled
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
              gradientThirdColorEnabled
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      height: colorPickerContainerHeights[
                          Options.gradientThirdColor],
                      child: colorPickerContainers[Options.gradientThirdColor],
                    )
                  : Container(
                      height: 1.0,
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Divider(
                  thickness: 1.0,
                  color: workingColors[WorkingColors.gradientFirstColor]
                      .withOpacity(0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 5.0,
                    left: sidePadding,
                    right: sidePadding),
                child: Text(
                  "Gradient Orientation",
                  style: homeSubTextStyleBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: sidePadding, right: sidePadding, top: 10.0),
                child: Container(
                  height: 70.0,
                  child: TextFormField(
                    focusNode: gradientOFocusNode,
                    controller: gradientOController,
                    maxLength: 15,
                    style: homeSubTextStyle,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    onTap: () {
                      //_requestFocus(customButtonFocusNode);
                      unfocus(context);

                      //open botton navigation drawer:
                      List options = [
                        {
                          "iconData": EvaIcons.arrowForwardOutline,
                          "title": "Horizontal",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.horizontal;

                            gradientOController.text = "Horizontal";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.arrowDownwardOutline,
                          "title": "Vertical",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.vertical;

                            gradientOController.text = "Vertical";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.diagonalArrowRightDownOutline,
                          "title": "Diagonal from Top Left",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.topLeft;

                            gradientOController.text = "Diagonal from Top Left";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.diagonalArrowLeftDown,
                          "title": "Diagonal from Top Right",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.topRight;

                            gradientOController.text =
                                "Diagonal from Top Right";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.diagonalArrowRightUp,
                          "title": "Diagonal from Bottom Left",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.bottomLeft;

                            gradientOController.text =
                                "Diagonal from Bottom Left";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.diagonalArrowLeftUp,
                          "title": "Diagonal from Bottom Right",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.bottomRight;

                            gradientOController.text =
                                "Diagonal from Bottom Right";

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                        {
                          "iconData": EvaIcons.loaderOutline,
                          "title": "Radial",
                          "onPressed": () {
                            workingGradientOrientation =
                                GradientOrientations.radial;

                            //take care of logic here

                            //close drawer
                            Navigator.pop(context);
                          }
                        },
                      ];

                      Map params = {
                        "context": context,
                        "title": "Choose a Gradient Orientation",
                        "options": options,
                        "on_close": () {
                          //remove focus from text field
                          print("on_close function called ");
                        }
                      };

                      displayNavigationDrawer(context, params);
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          EvaIcons.arrowDownOutline,
                          color: Colors.grey[400],
                          size: 22,
                        ),
                        contentPadding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: gradientOController.text.isEmpty
                            ? 'Select gradient orientation'
                            : 'Selected Gradient Orientation:',
                        labelStyle: GoogleFonts.heebo(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: gradientOFocusNode.hasFocus ||
                                        gradientOController.text.isNotEmpty
                                    ? 16
                                    : 12,
                                color: gradientOFocusNode.hasFocus
                                    ? workingColors[WorkingColors.primaryColor]
                                    : Colors.black54)),
                        alignLabelWithHint: true, //stops it being so high
                        border: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.grey[300])),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: workingColors[WorkingColors.primaryColor]),
                        ),
                        counterText: "",
                        hintText: '',
                        hintStyle: GoogleFonts.heebo(
                            textStyle: TextStyle(
                                height: 2.5,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black54))),
                  ),
                ),
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
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);

    bool light = Brightness.light == brightness;

    return FlatButton(
      onPressed: onTapCallback,
      onLongPress: longpressCallback,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 10.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          color: light ? Colors.grey[400] : Colors.transparent,
                          width: 0.5),
                      color: color),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(text, style: homeSubTextStyle),
                ),
              ],
            ),
            Icon(
              EvaIcons.colorPaletteOutline,
              color: light ? Colors.black54 : color,
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
          padding: const EdgeInsets.only(top: sidePadding, bottom: sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: sidePadding, right: sidePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Theme Colors", style: homeTextStyleBold),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: sidePadding, right: sidePadding),
                child: Container(
                  height: 40.0,
                  child: Text(
                      "These are the colors used by buttons and links. When user clicks the color a color selection tool will popup",
                      style: homeSubTextStyle,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),
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
        height: 200,
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
        sidePadding: 0.0,
      );

      if (currentOption == Options.gradientThirdColor) {
        colorPickerContainers[currentOption] = Column(
          children: [
            Expanded(flex: 10, child: colorPickerContainers[currentOption]),
            Flexible(
              flex: 1,
              child: Center(
                child: SolidButton(
                  text: "Remove third color",
                  width: 180,
                  height: 30,
                  iconData: EvaIcons.minusCircleOutline,
                  onPressed: () {
                    toggleColorEditor(Options.gradientThirdColor);
                    setState(() {
                      gradientThirdColorEnabled = false;
                    });
                  },
                ),
              ),
            ),
          ],
        );
        colorPickerContainerHeights[currentOption] = 440;
        colorEditorOpened = true;
        return;
      }
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

    displaySimpleColorPicker(context,
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
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        workingPlaceLogoActive = !workingPlaceLogoActive;
                      });
                    },
                    icon: Icon(
                      workingPlaceLogoActive
                          ? UniconsSolid.toggle_on
                          : UniconsSolid.toggle_off,
                      color: workingPlaceLogoActive
                          ? workingColors[WorkingColors.primaryColor]
                          : Colors.grey[400],
                      size: 40.0,
                    ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: sidePadding, left: sidePadding, right: sidePadding),
              child: Row(
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
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        workingTaglineActive = !workingTaglineActive;
                      });
                    },
                    icon: Icon(
                      workingTaglineActive
                          ? UniconsSolid.toggle_on
                          : UniconsSolid.toggle_off,
                      color: workingTaglineActive
                          ? workingColors[WorkingColors.primaryColor]
                          : Colors.grey[400],
                      size: 40.0,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: sidePadding, right: sidePadding),
              child: Container(
                height: 90.0,
                child: TextFormField(
                  focusNode: taglineFocusNode,
                  controller: taglineController,
                  maxLength: 30,
                  style: homeSubTextStyle,
                  onTap: () {
                    _requestFocus(taglineFocusNode);
                  },
                  decoration: InputDecoration(
                      suffixIcon: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: IconButton(
                            onPressed: () {
                              if (taglineFocusNode.hasFocus) {
                                taglineController.clear();
                              }
                            },
                            icon: Icon(
                              EvaIcons.closeCircleOutline,
                              color: taglineFocusNode.hasFocus
                                  ? primaryColor
                                  : Colors.transparent,
                              size: 22,
                            )),
                      ),
                      contentPadding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Tagline',
                      labelStyle: GoogleFonts.heebo(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: taglineFocusNode.hasFocus ||
                                      taglineController.text.isNotEmpty
                                  ? 16
                                  : 12,
                              color: taglineFocusNode.hasFocus
                                  ? workingColors[WorkingColors.primaryColor]
                                  : Colors.black54)),
                      alignLabelWithHint: true, //stops it being so high
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey[300])),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: workingColors[WorkingColors.primaryColor]),
                      ),
                      hintText: 'Enter a tagline',
                      hintStyle: GoogleFonts.heebo(
                          textStyle: TextStyle(
                              height: 2.5,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black54))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: sidePadding),
              child: buildColorRow(
                "Tagline text Color",
                workingColors[WorkingColors.primaryColor],
                onTapCallback: () {
                  displayPopupColorEditor(Options.primaryColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildPlaceName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: sidePadding, left: sidePadding, right: sidePadding),
              child: Text("Place Name", style: homeTextStyleBold),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: sidePadding, right: sidePadding),
              child: Container(
                height: 90.0,
                child: TextFormField(
                  focusNode: placeNameFocusNode,
                  controller: placeNameController,
                  maxLength: 25,
                  style: homeSubTextStyle,
                  onTap: () {
                    _requestFocus(placeNameFocusNode);
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (placeNameFocusNode.hasFocus) {
                              placeNameController.clear();
                            }
                          },
                          icon: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: Icon(
                              EvaIcons.closeCircleOutline,
                              color: placeNameFocusNode.hasFocus
                                  ? primaryColor
                                  : Colors.transparent,
                              size: 22,
                            ),
                          )),
                      contentPadding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Title',
                      labelStyle: GoogleFonts.heebo(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: placeNameFocusNode.hasFocus ||
                                      placeNameController.text.isNotEmpty
                                  ? 16
                                  : 12,
                              color: placeNameFocusNode.hasFocus
                                  ? workingColors[WorkingColors.primaryColor]
                                  : Colors.black54)),
                      alignLabelWithHint: true, //stops it being so high
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey[300])),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: workingColors[WorkingColors.primaryColor]),
                      ),
                      hintText: 'Enter a place name',
                      hintStyle: GoogleFonts.heebo(
                          textStyle: TextStyle(
                              height: 2.5,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black54))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: sidePadding),
              child: buildColorRow(
                "Title text Color",
                workingColors[WorkingColors.primaryColor],
                onTapCallback: () {
                  displayPopupColorEditor(Options.primaryColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderPreview(BuildContext context, double sizeFactor) {
    Color thirdColor = gradientThirdColorEnabled
        ? workingColors[WorkingColors.gradientThirdColor]
        : null;

    Widget widget = Stack(
      children: [
        headerBuilders['preview_background'](400.0,
            MediaQuery.of(context).size.width - (memberViewPadding * 2.0),
            gradientFirstColor: workingColors[WorkingColors.gradientFirstColor],
            gradientSecondColor:
                workingColors[WorkingColors.gradientSecondColor],
            gradientThirdColor: thirdColor,
            gradientOrientation: workingGradientOrientation,
            backgroundStyle: workingBackgroundStyle),
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
                    child: headerBuilders['header'](context,
                        memberViewMode: true,
                        sizeFactor: sizeFactor,
                        placeLogo: workingPlaceLogoActive,
                        tagLine: workingTaglineActive,
                        memberPreview: workingMemberPreviewActive,
                        customButton: workingCustomButtonActive,
                        inviteButton: workingInviteButtonActive)),
              ),
            )
          ],
        )
      ],
    );
    return widget;
  }
}
