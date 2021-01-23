import 'dart:collection';

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
  titleColor,
  tagLineColor,
  primaryColor,
  secondaryColor,
  accentColor,
  gradientFirstColor,
  gradientSecondColor,
  gradientThirdColor,
  solidBGColor,
  diagonalColor, //will be removed and replaced by the left and right below
  topLeftBarColor,
  topRightBarColor,
  inviteButtonColor,
  inviteButtonTextColor,
  customButtonColor,
  customButtonTextColor,
}

enum WorkingColors {
  titleColor,
  tagLineColor,
  primaryColor,
  secondaryColor,
  accentColor,
  gradientFirstColor,
  gradientSecondColor,
  gradientThirdColor,
  solidBGColor,
  diagonalColor,
  topLeftBarColor,
  topRightBarColor,
  inviteButtonColor,
  inviteButtonTextColor,
  customButtonColor,
  customButtonTextColor,
}

enum WorkingBackGroundOptions {
  diagonalLine,
  image,
  imageDiagonalLine,
  solid,
  solidDiagonalLine,
  gradient,
  gradientDiagonalLine,
  video,
  videoDiagonalLine,
  animated,
  animetedDiagonalLine
}

void dummyCB() {}

class CustomizeHeaderScreen extends StatefulWidget {
  @override
  _CustomizeHeaderScreenState createState() => _CustomizeHeaderScreenState();
}

class _CustomizeHeaderScreenState extends State<CustomizeHeaderScreen> {
  ScrollController mainScrollController = new ScrollController();
  List list;
  List
      backgroundImageList; //linkedhashmap not necessary as we access using keys so order is dictated by us at access time

  List selectedBackgroundImageList;

//These are not actually used -- TODO REMOVE THEM
  Color workingTitleColor;
  Color workingTagLineColor;

  Color workingPrimaryColor;
  Color workingSecondaryColor;
  Color workingAccentColor;

  Color workingFirstGradientColor;
  Color workingSecondGradientColor;
  Color workingThirdGradientColor;

  Color workingSolidBGColor;

  Color workingInviteButtonColor;
  Color workingInviteButtonTextColor;

  Color workingCustomButtonColor;
  Color workingCustomButtonTextColor;
  String workingCustomButtonText;
  //==============

  GradientOrientations workingGradientOrientation;

  Widget dormantWidget = Container(height: 1.0);
  double containerHeight = 1.0;
  bool colorEditorOpened = false;

  Options activeColorEditor;

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
  bool workingDiagonalBarActive;
  bool workingTLBActive;
  bool workingTRBActive;
  bool workingDiagonalBarShadow;
  bool workingCoverMultiPhoto;
  bool workingLandingPageMode;

  double workingDiagonalBarShadowBlurRadius;
  double workingDiagonalBarShadowLift;
  double workingDBMaxOpacity;

  List<backgroundStyles> diagonalStyles = [
    backgroundStyles.diagonalLine,
    backgroundStyles.imageDiagonalLine,
    backgroundStyles.solidDiagonalLine,
    backgroundStyles.gradientDiagonalLine,
    backgroundStyles.videoDiagonalLine,
    backgroundStyles.animatedDiagonalLine
  ];

  backgroundStyles workingBackgroundStyle;
  Map<backgroundStyles, bool> backgroundToggleStates;

  Duration crossFadeDuration = Duration(milliseconds: 300);

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

    backgroundImageList = [
      "assets/images/home_background.jpg",
      "assets/images/home_background_2.jpg",
      "assets/images/home_background_3.jpg",
    ];

    selectedBackgroundImageList = [
      "assets/images/home_background.jpg",
      "assets/images/home_background_3.jpg",
    ];

    workingColors = {
      WorkingColors.titleColor: contentLayouts['header']
          [headerOptions.titleColor],
      WorkingColors.tagLineColor: contentLayouts['header']
          [headerOptions.tagLineColor],
      WorkingColors.diagonalColor: contentLayouts['header']
          [headerOptions.diagonalBarColor],
      WorkingColors.primaryColor: primaryColor,
      WorkingColors.secondaryColor: secondaryColor,
      WorkingColors.accentColor: accentColor,
      WorkingColors.gradientFirstColor: gradientColor1,
      WorkingColors.gradientSecondColor: gradientColor2,
      WorkingColors.gradientThirdColor: gradientColor3,
      WorkingColors.topLeftBarColor: contentLayouts['header']
          [headerOptions.topLeftBarColor],
      WorkingColors.topRightBarColor: contentLayouts['header']
          [headerOptions.topRightBarColor],
      WorkingColors.inviteButtonColor: contentLayouts['header']
          [headerOptions.inviteButtonColor],
      WorkingColors.inviteButtonTextColor: contentLayouts['header']
          [headerOptions.inviteButtonTextColor],
      WorkingColors.customButtonColor: contentLayouts['header']
          [headerOptions.customButtonColor],
      WorkingColors.customButtonTextColor: contentLayouts['header']
          [headerOptions.customButtonTextColor],
    };

    targetColor = null;

    colorPickerContainers = {
      Options.titleColor: dormantWidget,
      Options.tagLineColor: dormantWidget,
      Options.primaryColor: dormantWidget,
      Options.secondaryColor: dormantWidget,
      Options.accentColor: dormantWidget,
      Options.gradientFirstColor: dormantWidget,
      Options.gradientSecondColor: dormantWidget,
      Options.gradientThirdColor: dormantWidget,
      Options.diagonalColor: dormantWidget,
      Options.topLeftBarColor: dormantWidget,
      Options.topRightBarColor: dormantWidget,
      Options.inviteButtonColor: dormantWidget,
      Options.inviteButtonTextColor: dormantWidget,
      Options.customButtonColor: dormantWidget,
      Options.customButtonTextColor: dormantWidget
    };

    colorPickerContainerHeights = {
      Options.titleColor: 1.0,
      Options.tagLineColor: 1.0,
      Options.primaryColor: 1.0,
      Options.secondaryColor: 1.0,
      Options.accentColor: 1.0,
      Options.gradientFirstColor: 1.0,
      Options.gradientSecondColor: 1.0,
      Options.gradientThirdColor: 1.0,
      Options.topLeftBarColor: 1.0,
      Options.topRightBarColor: 1.0,
      Options.inviteButtonColor: 1.0,
      Options.inviteButtonTextColor: 1.0,
      Options.customButtonColor: 1.0,
      Options.customButtonTextColor: 1.0,
    };

    workingGradientOrientation = currentGradientOrientation;

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
    workingDiagonalBarShadow =
        contentLayouts['header'][headerOptions.diagonalBarShadow];
    workingDiagonalBarShadowBlurRadius =
        contentLayouts['header'][headerOptions.diagonalBarShadowBlurRadius];
    workingDiagonalBarShadowLift =
        contentLayouts['header'][headerOptions.diagonalBarShadowLift];
    workingTLBActive = contentLayouts['header'][headerOptions.topLeftBar];
    workingTRBActive = contentLayouts['header'][headerOptions.topRightBar];

    workingBackgroundStyle =
        contentLayouts['header'][headerOptions.backgroundStyle];
    workingDBMaxOpacity =
        contentLayouts['header'][headerOptions.diagonalMaxOpacity];
    workingLandingPageMode = contentLayouts['header']
        [headerOptions.landingPageMode][landingPageMode.active];

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

    placeNameController.text =
        contentLayouts['header'][headerOptions.titleText];
    taglineController.text =
        contentLayouts['header'][headerOptions.tagLineText];
    customButtonLabelController.text =
        contentLayouts['header'][headerOptions.customButtonText];

    customButtonActionFocusNode.canRequestFocus =
        false; //we don't want to actually be able to write in this one -- this doesnt seem to work
    gradientOFocusNode.canRequestFocus = false;

    backgroundToggleStates = {
      backgroundStyles.diagonalLine: false,
      backgroundStyles.image: false,
      backgroundStyles.imageDiagonalLine: false,
      backgroundStyles.solid: false,
      backgroundStyles.solidDiagonalLine: false,
      backgroundStyles.gradient: false,
      backgroundStyles.gradientDiagonalLine: false,
      backgroundStyles.video: false,
      backgroundStyles.videoDiagonalLine: false,
      backgroundStyles.animated: false,
      backgroundStyles.animatedDiagonalLine: false
    };

    selectWorkingBGOption(
        contentLayouts['header'][headerOptions.backgroundStyle]);
    validateWorkingBGOption();

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

  void selectWorkingBGOption(backgroundStyles selectedOption) {
    //function that updates the workingBackgroundStyle depending on which background switch is on
    bool atleastOneIsTrue = false;

    //validate style
    validateWorkingBGOption(backgroundStyle: selectedOption);

    //toggle all other options off
    for (var backgroundStyle in backgroundStyles.values) {
      if (backgroundStyle == selectedOption) {
        setState(() {
          backgroundToggleStates[selectedOption] =
              !backgroundToggleStates[selectedOption];
        });

        workingDiagonalBarActive = diagonalStyles.contains(selectedOption);

        continue;
      }

      backgroundToggleStates[backgroundStyle] = false;
    }

    if (backgroundToggleStates[selectedOption]) {
      atleastOneIsTrue = true;
    }

    if (!atleastOneIsTrue) {
      //set a default one to true

      setState(() {
        backgroundToggleStates[backgroundStyles.solid] = true;
      });
    }
  }

  backgroundStyles getWorkingBGOption() {
    //function that finds the current active background style and returns it
    for (var backgroundStyle in backgroundStyles.values) {
      if (backgroundToggleStates[backgroundStyle]) {
        return backgroundStyle;
      }
    }

    return null;
  }

  void validateWorkingBGOption({backgroundStyles backgroundStyle}) {
    //checks if current bg option is still valid if not sets default
    backgroundStyle =
        null != backgroundStyle ? backgroundStyle : getWorkingBGOption();

    //if current background is Image check if backgroundImageList is empty, if empty, set other background style
    if (backgroundStyle == backgroundStyles.image ||
        backgroundStyle == backgroundStyles.imageDiagonalLine) {
      //check if backgroundImageList is empty
      bool imageIsEmpty = backgroundImageList.isEmpty;
      // bool selectedImageIsEmpty = selectedBackgroundImageList.isEmpty;

      if (imageIsEmpty) {
        //insert default backgroundImage into list
        setState(() {
          backgroundImageList.add(defaultBackgroundImage);
        });
      }

      // if (selectedImageIsEmpty) {
      //   setState(() {
      //     print("selected Image is empty, setting state");
      //     selectedBackgroundImageList.add(defaultBackgroundImage);
      //   });
      // }
    }
  }

  void toggleDiagonal() {
    //deprecated
    //get current background option
    backgroundStyles currentStyle = getWorkingBGOption();
    backgroundStyles newStyle;

    //this changes the working background depending on if diagonal is selected or not
    switch (currentStyle) {
      case backgroundStyles.diagonalLine:
        newStyle = backgroundStyles.diagonalLine;
        break;

      case backgroundStyles.image:
        newStyle = backgroundStyles.imageDiagonalLine;
        break;

      case backgroundStyles.imageDiagonalLine:
        newStyle = backgroundStyles.image;
        break;

      case backgroundStyles.solid:
        newStyle = backgroundStyles.solidDiagonalLine;
        break;

      case backgroundStyles.solidDiagonalLine:
        newStyle = backgroundStyles.solid;
        break;

      case backgroundStyles.gradient:
        newStyle = backgroundStyles.gradientDiagonalLine;
        break;

      case backgroundStyles.gradientDiagonalLine:
        newStyle = backgroundStyles.gradient;
        break;

      case backgroundStyles.video:
        newStyle = backgroundStyles.videoDiagonalLine;
        break;

      case backgroundStyles.videoDiagonalLine:
        newStyle = backgroundStyles.video;
        break;

      case backgroundStyles.animated:
        newStyle = backgroundStyles.animatedDiagonalLine;
        break;

      case backgroundStyles.animatedDiagonalLine:
        newStyle = backgroundStyles.animated;
        break;
    }

    selectWorkingBGOption(newStyle);
  }

  void saveChanges() {
    /*
    Missing:
      -solid background color, currently primary color
      -
     */

    //validate options before saving so there aren't any null states
    //such as background image without background images being set
    validateWorkingBGOption();

    //This function overrides the home state with all changes
    String header = 'header';
    contentLayouts[header][headerOptions.titleColor] =
        workingColors[WorkingColors.titleColor];
    contentLayouts[header][headerOptions.tagLineColor] =
        workingColors[WorkingColors.tagLineColor];

    primaryColor = workingColors[WorkingColors.primaryColor];
    secondaryColor = workingColors[WorkingColors.secondaryColor];
    accentColor = workingColors[WorkingColors.accentColor];

    gradientColor1 = workingColors[WorkingColors.gradientFirstColor];
    gradientColor2 = workingColors[WorkingColors.gradientSecondColor];
    gradientColor3 = workingColors[WorkingColors.gradientThirdColor];
    currentGradientOrientation = workingGradientOrientation;

    contentLayouts[header][headerOptions.tagLineText] = taglineController.text;
    contentLayouts[header][headerOptions.titleText] = placeNameController.text;
    contentLayouts[header][headerOptions.customButtonText] =
        customButtonLabelController.text;

    contentLayouts[header][headerOptions.customButtonColor] =
        workingColors[WorkingColors.customButtonColor];
    contentLayouts[header][headerOptions.inviteButtonColor] =
        workingColors[WorkingColors.inviteButtonColor];
    contentLayouts[header][headerOptions.customButtonTextColor] =
        workingColors[WorkingColors.customButtonTextColor];
    contentLayouts[header][headerOptions.inviteButtonTextColor] =
        workingColors[WorkingColors.inviteButtonTextColor];

    contentLayouts[header][headerOptions.titleColor] =
        workingColors[WorkingColors.titleColor];
    contentLayouts[header][headerOptions.tagLineColor] =
        workingColors[WorkingColors.tagLineColor];

    contentLayouts[header][headerOptions.tagLine] = workingTaglineActive;
    contentLayouts[header][headerOptions.placeLogo] = workingPlaceLogoActive;
    contentLayouts[header][headerOptions.backgroundStyle] =
        getWorkingBGOption();
    contentLayouts[header][headerOptions.memberPreview] =
        workingMemberPreviewActive;
    contentLayouts[header][headerOptions.inviteButton] =
        workingInviteButtonActive;
    contentLayouts[header][headerOptions.customButton] =
        workingCustomButtonActive;
    contentLayouts[header][headerOptions.diagonalBarShadow] =
        workingDiagonalBarShadow;
    contentLayouts[header][headerOptions.diagonalBarShadowBlurRadius] =
        workingDiagonalBarShadowBlurRadius;
    contentLayouts[header][headerOptions.diagonalBarShadowLift] =
        workingDiagonalBarShadowLift;
    contentLayouts[header][headerOptions.diagonalMaxOpacity] =
        workingDBMaxOpacity;
    contentLayouts[header][headerOptions.topLeftBar] = workingTLBActive;
    contentLayouts[header][headerOptions.topLeftBarColor] =
        workingColors[WorkingColors.topLeftBarColor];
    contentLayouts[header][headerOptions.topRightBarColor] =
        workingColors[WorkingColors.topRightBarColor];
    contentLayouts[header][headerOptions.topRightBar] = workingTRBActive;
    contentLayouts[header][headerOptions.landingPageMode]
        [landingPageMode.active] = workingLandingPageMode;

    contentLayouts[header][headerOptions.appBarColor] =
        workingColors[WorkingColors.primaryColor];

    print("Saved backgroundStyle: $workingBackgroundStyle");
  }

  _CustomizeHeaderScreenState(); //constructor call

  Widget build(BuildContext context) {
    double expandedHeight =
        workingLandingPageMode ? MediaQuery.of(context).size.height * 0.9 : 305;
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
                  //rebuildHomeCustomizeScreen(context);
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      //call controller to make changes to home_state
                      saveChanges();
                      Navigator.pop(context);
                    },
                    child:
                        Center(child: Text('Save', style: homeTextStyleWhite))),
              ]),
          body: CustomScrollView(
            controller: mainScrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: expandedHeight,
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
      buildBGDiagonalLine(),
      buildLandingPageMode(),
      buildPlaceName(),
      buildTagLine(),
      buildPlaceLogo(),
      buildThemeColors(),
      buildCoverPhoto(),
      buildGradientBackground(),
      buildShowMemberList(),
      buildShowInviteButton(),
      buildShowCustomButton(),
      Container(height: 100, color: Colors.transparent)
    ];

    return listItems;
  }

  Padding buildBGDiagonalLine() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              top: sidePadding, bottom: sidePadding, left: 0, right: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      workingDiagonalBarActive = !workingDiagonalBarActive;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Background Diagonal Bars",
                              style: homeTextStyleBold),
                          //should be displayed only if custom button is enabled
                        ],
                      ),
                      Icon(
                        workingDiagonalBarActive
                            ? EvaIcons.chevronUpOutline
                            : EvaIcons.chevronDownOutline,
                        color: Colors.grey[400],
                        size: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                  duration: crossFadeDuration,
                  firstChild: _buildDiagonalBarBody(),
                  secondChild: Container(height: 0.0),
                  crossFadeState: workingDiagonalBarActive
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagonalBarBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Divider(
            thickness: 1.0,
            color: Colors.grey[400].withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Diagonal Bar Shadow", style: homeSubTextStyle),
                  //should be displayed only if custom button is enabled
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingDiagonalBarShadow = !workingDiagonalBarShadow;
                  });
                },
                icon: Icon(
                  workingDiagonalBarShadow
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingDiagonalBarShadow
                      ? workingColors[WorkingColors.primaryColor]
                      : Colors.grey[400],
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
        AnimatedCrossFade(
            duration: crossFadeDuration,
            firstChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shadow Blur Radius: ", style: homeSubTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Slider(
                      value: workingDiagonalBarShadowBlurRadius,
                      activeColor: workingColors[WorkingColors.primaryColor],
                      inactiveColor: Colors.grey[400],
                      min: 0,
                      max: 30,
                      divisions: null,
                      label:
                          workingDiagonalBarShadowBlurRadius.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          workingDiagonalBarShadowBlurRadius = value;
                        });
                      },
                    ),
                  ),
                  Text("Shadow Lift: ", style: homeSubTextStyle),
                  Slider(
                    value: workingDiagonalBarShadowLift,
                    activeColor: workingColors[WorkingColors.primaryColor],
                    inactiveColor: Colors.grey[400],
                    min: 0,
                    max: 20,
                    divisions: null,
                    label: workingDiagonalBarShadowLift.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        workingDiagonalBarShadowLift = value;
                      });
                    },
                  )
                ],
              ),
            ),
            secondChild: Container(height: 0.0),
            crossFadeState: workingDiagonalBarShadow
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Divider(
            thickness: 1.0,
            color: Colors.grey[400].withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Show Top Left Bar", style: homeSubTextStyle),
                  //should be displayed only if custom button is enabled
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingTLBActive = !workingTLBActive;
                  });
                },
                icon: Icon(
                  workingTLBActive
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingTLBActive
                      ? workingColors[WorkingColors.primaryColor]
                      : Colors.grey[400],
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
        AnimatedCrossFade(
            firstChild: Column(
              children: [
                buildColorRow("Top Left Bar Color",
                    workingColors[WorkingColors.topLeftBarColor],
                    onTapCallback: () {
                  toggleColorEditor(Options.topLeftBarColor);
                }, longpressCallback: () {
                  displayPopupColorEditor(Options.topLeftBarColor);
                }),
                AnimatedCrossFade(
                    duration: crossFadeDuration,
                    firstChild: colorPickerContainers[Options.topLeftBarColor],
                    secondChild: Container(height: 0.0),
                    crossFadeState: Options.topLeftBarColor == activeColorEditor
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond)
              ],
            ),
            secondChild: Container(),
            crossFadeState: workingTLBActive
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: crossFadeDuration),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Divider(
            thickness: 1.0,
            color: Colors.grey[400].withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Show Top Right Bar", style: homeSubTextStyle),
                  //should be displayed only if custom button is enabled
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingTRBActive = !workingTRBActive;
                  });
                },
                icon: Icon(
                  workingTRBActive
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingTRBActive
                      ? workingColors[WorkingColors.primaryColor]
                      : Colors.grey[400],
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
        AnimatedCrossFade(
            firstChild: Column(
              children: [
                buildColorRow("Top Right Bar Color",
                    workingColors[WorkingColors.topRightBarColor],
                    onTapCallback: () {
                  toggleColorEditor(Options.topRightBarColor);
                }, longpressCallback: () {
                  displayPopupColorEditor(Options.topRightBarColor);
                }),
                AnimatedCrossFade(
                    duration: crossFadeDuration,
                    firstChild: colorPickerContainers[Options.topRightBarColor],
                    secondChild: Container(height: 0.0),
                    crossFadeState:
                        Options.topRightBarColor == activeColorEditor
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond)
              ],
            ),
            secondChild: Container(),
            crossFadeState: workingTRBActive
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: crossFadeDuration),
        Padding(
          padding: const EdgeInsets.only(
              top: sidePadding, left: sidePadding, right: sidePadding),
          child: Text("Bars Max Opacity: ", style: homeSubTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0, left: sidePadding, right: sidePadding),
          child: Slider(
            value: workingDBMaxOpacity,
            activeColor: workingColors[WorkingColors.primaryColor],
            inactiveColor: Colors.grey[400],
            min: 0,
            max: 1,
            divisions: 10,
            label: workingDBMaxOpacity.toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                workingDBMaxOpacity = value;
              });
            },
          ),
        ),
      ],
    );
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
    bool gradientActive = backgroundToggleStates[backgroundStyles.gradient] ||
        backgroundToggleStates[backgroundStyles.gradientDiagonalLine];
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
                    IconButton(
                      onPressed: () {
                        selectWorkingBGOption(backgroundStyles.gradient);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        gradientActive
                            ? UniconsSolid.toggle_on
                            : UniconsSolid.toggle_off,
                        color: gradientActive
                            ? workingColors[WorkingColors.primaryColor]
                            : Colors.grey[400],
                        size: 40.0,
                      ),
                    )
                  ],
                ),
              ),
              AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: buildGBContent(),
                  crossFadeState: gradientActive
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: crossFadeDuration)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGBContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
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
              top: 10.0, bottom: 5.0, left: sidePadding, right: sidePadding),
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
            width: MediaQuery.of(context).size.width - (sidePadding * 2.0),
            decoration: BoxDecoration(
                gradient: gradientThirdColorEnabled
                    ? getGradient(
                        gradientFirstColor:
                            workingColors[WorkingColors.gradientFirstColor],
                        gradientSecondColor:
                            workingColors[WorkingColors.gradientSecondColor],
                        gradientThirdColor:
                            workingColors[WorkingColors.gradientThirdColor],
                        gradientOrientation: workingGradientOrientation)
                    : getGradient(
                        gradientFirstColor:
                            workingColors[WorkingColors.gradientFirstColor],
                        gradientSecondColor:
                            workingColors[WorkingColors.gradientSecondColor],
                        gradientOrientation: workingGradientOrientation),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        buildColorRow(
            "First Color", workingColors[WorkingColors.gradientFirstColor],
            onTapCallback: () {
          toggleColorEditor(Options.gradientFirstColor);
        }, longpressCallback: () {
          displayPopupColorEditor(Options.gradientFirstColor);
        }),
        AnimatedCrossFade(
            duration: crossFadeDuration,
            firstChild: colorPickerContainers[Options.gradientFirstColor],
            secondChild: Container(height: 0.0),
            crossFadeState: Options.gradientFirstColor == activeColorEditor
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
        buildColorRow(
            "Second Color", workingColors[WorkingColors.gradientSecondColor],
            onTapCallback: () {
          toggleColorEditor(Options.gradientSecondColor);
        }, longpressCallback: () {
          displayPopupColorEditor(Options.gradientSecondColor);
        }),
        AnimatedCrossFade(
            duration: crossFadeDuration,
            firstChild: colorPickerContainers[Options.gradientSecondColor],
            secondChild: Container(height: 0.0),
            crossFadeState: Options.gradientSecondColor == activeColorEditor
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
        AnimatedCrossFade(
            duration: crossFadeDuration,
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
            duration: crossFadeDuration,
            firstChild: buildColorRow(
                "Third Color", workingColors[WorkingColors.gradientThirdColor],
                onTapCallback: () {
              toggleColorEditor(Options.gradientThirdColor);
            }, longpressCallback: () {
              displayPopupColorEditor(Options.gradientThirdColor);
            }),
            secondChild: Container(height: 0.0),
            crossFadeState: gradientThirdColorEnabled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
        AnimatedCrossFade(
            duration: crossFadeDuration,
            firstChild: colorPickerContainers[Options.gradientThirdColor],
            secondChild: Container(height: 0.0),
            crossFadeState: Options.gradientThirdColor == activeColorEditor
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
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
              top: 10.0, bottom: 5.0, left: sidePadding, right: sidePadding),
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
                      workingGradientOrientation = GradientOrientations.topLeft;

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

                      gradientOController.text = "Diagonal from Top Right";

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

                      gradientOController.text = "Diagonal from Bottom Left";

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

                      gradientOController.text = "Diagonal from Bottom Right";

                      //take care of logic here

                      //close drawer
                      Navigator.pop(context);
                    }
                  },
                  {
                    "iconData": EvaIcons.loaderOutline,
                    "title": "Radial",
                    "onPressed": () {
                      workingGradientOrientation = GradientOrientations.radial;

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
        )
      ],
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
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild: colorPickerContainers[Options.primaryColor],
                  secondChild: Container(height: 0.0),
                  crossFadeState: Options.primaryColor == activeColorEditor
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
              buildColorRow("Secondary Color",
                  workingColors[WorkingColors.secondaryColor],
                  onTapCallback: () {
                toggleColorEditor(Options.secondaryColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.secondaryColor);
              }),
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild: colorPickerContainers[Options.secondaryColor],
                  secondChild: Container(height: 0.0),
                  crossFadeState: Options.secondaryColor == activeColorEditor
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
              buildColorRow(
                  "Accent Color", workingColors[WorkingColors.accentColor],
                  onTapCallback: () {
                toggleColorEditor(Options.accentColor);
              }, longpressCallback: () {
                displayPopupColorEditor(Options.accentColor);
              }),
              AnimatedCrossFade(
                  duration: Duration(milliseconds: 500),
                  firstChild: colorPickerContainers[Options.accentColor],
                  secondChild: Container(height: 0.0),
                  crossFadeState: Options.accentColor == activeColorEditor
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
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
      case Options.titleColor:
        targetColor = WorkingColors.titleColor;
        break;

      case Options.tagLineColor:
        targetColor = WorkingColors.tagLineColor;

        break;

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

      case Options.diagonalColor:
        targetColor = WorkingColors.diagonalColor;
        break;

      case Options.topLeftBarColor:
        targetColor = WorkingColors.topLeftBarColor;
        break;

      case Options.topRightBarColor:
        targetColor = WorkingColors.topRightBarColor;
        break;

      case Options.inviteButtonColor:
        targetColor = WorkingColors.inviteButtonColor;
        break;

      case Options.inviteButtonTextColor:
        targetColor = WorkingColors.inviteButtonTextColor;
        break;

      case Options.customButtonColor:
        targetColor = WorkingColors.customButtonColor;
        break;

      case Options.customButtonColor:
        targetColor = WorkingColors.customButtonTextColor;
        break;

      default:
        targetColor = WorkingColors.primaryColor;
    }

    setState(() {
      if (colorEditorOpened && currentOption == previousOption) {
        activeColorEditor = null;
        colorEditorOpened = false;

        return;
      }

      if (previousOption != currentOption || null == activeColorEditor) {
        activeColorEditor = currentOption;
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
        colorPickerContainers[currentOption] = SizedBox(
          height: 440,
          child: Column(
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
          ),
        );
        colorPickerContainerHeights[currentOption] = 440; //deprecated ?
        colorEditorOpened = true;
        return;
      }
      colorPickerContainerHeights[currentOption] = 400; //deprecated ?
      colorEditorOpened = true;
    });
  }

  void displayPopupColorEditor(Options option) {
    WorkingColors selectedColor;

    switch (option) {
      case Options.titleColor:
        selectedColor = WorkingColors.titleColor;
        break;

      case Options.tagLineColor:
        selectedColor = WorkingColors.tagLineColor;

        break;

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

      case Options.topLeftBarColor:
        targetColor = WorkingColors.topLeftBarColor;
        break;

      case Options.topRightBarColor:
        targetColor = WorkingColors.topRightBarColor;
        break;

      case Options.inviteButtonColor:
        targetColor = WorkingColors.inviteButtonColor;
        break;

      case Options.inviteButtonTextColor:
        targetColor = WorkingColors.inviteButtonTextColor;
        break;

      case Options.customButtonColor:
        targetColor = WorkingColors.customButtonColor;
        break;

      case Options.customButtonColor:
        targetColor = WorkingColors.customButtonTextColor;
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
    bool coverPhotoActive = backgroundToggleStates[backgroundStyles.image] ||
        backgroundToggleStates[backgroundStyles.imageDiagonalLine];

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
                      Text("Background Cover Photo", style: homeTextStyleBold),
                      Text("Suggested size: 750x350 px",
                          style: homeSubTextStyle),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      selectWorkingBGOption(backgroundStyles.image);
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      coverPhotoActive
                          ? UniconsSolid.toggle_on
                          : UniconsSolid.toggle_off,
                      color: coverPhotoActive
                          ? workingColors[WorkingColors.primaryColor]
                          : Colors.grey[400],
                      size: 40.0,
                    ),
                  )
                ],
              ),
              AnimatedCrossFade(
                firstChild: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width -
                          (sidePadding * 2.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: CustomReorderableListView(
                            padding: EdgeInsets.only(right: 25.0),
                            scrollDirection: Axis.horizontal,
                            children: buildPhotoList(),
                            onReorder: (oldIndex, newIndex) {
                              String old = backgroundImageList[oldIndex];
                              if (oldIndex > newIndex) {
                                for (int i = oldIndex; i > newIndex; i--) {
                                  backgroundImageList[i] =
                                      backgroundImageList[i - 1];
                                }
                                backgroundImageList[newIndex] = old;
                              } else {
                                for (int i = oldIndex; i < newIndex - 1; i++) {
                                  backgroundImageList[i] = list[i + 1];
                                }
                                backgroundImageList[newIndex - 1] = old;
                              }
                              setState(() {});
                            }),
                      ),
                    ),
                    Text("Tap, hold and drag to reorder",
                        style: homeSubTextStyle)
                  ],
                ),
                secondChild: Container(),
                crossFadeState: backgroundImageList.isNotEmpty
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildPhotoList() {
    List<Widget> photoList = [];
    Widget temp;
    int length = backgroundImageList.length;

    for (int i = 0; i < length; i++) {
      String image = backgroundImageList[i];
      bool selected = selectedBackgroundImageList.contains(image);

      temp = GestureDetector(
        key: GlobalKey(),
        onTap: () {
          backgroundStyles workingBGOption = getWorkingBGOption();

          setState(() {
            //if previously no selected images and diff background style, enable image background
            if (selectedBackgroundImageList.isEmpty &&
                (workingBGOption != backgroundStyles.image ||
                    workingBGOption != backgroundStyles.imageDiagonalLine)) {
              selectWorkingBGOption(backgroundStyles.image);
            }

            if (selected) {
              selectedBackgroundImageList.remove(image);
            } else {
              selectedBackgroundImageList.add(image);
            }

            //if no image selected, set new bg option
            if (selectedBackgroundImageList.isEmpty &&
                (workingBGOption == backgroundStyles.image ||
                    workingBGOption == backgroundStyles.imageDiagonalLine)) {
              selectWorkingBGOption(backgroundStyles.gradient);
            }
          });

          //validate
          validateWorkingBGOption(backgroundStyle: backgroundStyles.image);
        },
        child: Container(
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
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null /* add child content here */,
                ),
              ),
              Positioned(
                top: 5.0,
                left: 5.0,
                child: AnimatedCrossFade(
                    firstChild: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black.withOpacity(0.6)),
                      child: Icon(EvaIcons.checkmarkOutline,
                          color: Colors.white) /* add child content here */,
                    ),
                    secondChild: Container(),
                    crossFadeState: selected
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300)),
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
                      onPressed: () {
                        String displayText = length > 1
                            ? "Are you sure you want to remove this image?"
                            : "You must have atleast one image available.";

                        Widget customHeader = Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0,
                              left: sidePadding,
                              right: sidePadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                displayText,
                                style: homeTextStyleBold,
                                overflow: TextOverflow.visible,
                              ),

                              //button which takes you to user profile
                            ],
                          ),
                        );

                        Widget customBody = Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: sidePadding,
                                right: sidePadding),
                            child: length > 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: sidePadding / 2),
                                        child: SolidButton(
                                          height: 30,
                                          width: 100,
                                          text: "Remove",
                                          backgroundColor: Colors.red,
                                          onPressed: () {
                                            setState(() {
                                              backgroundImageList.remove(image);
                                            });

                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: sidePadding / 2),
                                        child: TransparentButton(
                                          height: 30,
                                          width: 100,
                                          text: "Cancel",
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : Center(
                                    child: TransparentButton(
                                      height: 30,
                                      width: 100,
                                      text: "Dismiss",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ));

                        Map params = {
                          "context": context,
                          "custom_header": customHeader,
                          "custom_body": customBody,
                          "blur": false
                        };

                        displayNavigationDrawer(context, params);
                      }),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  )),
            ],
          ),
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
                                  ? workingColors[WorkingColors.tagLineColor]
                                  : Colors.black54)),
                      alignLabelWithHint: true, //stops it being so high
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey[300])),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: workingColors[WorkingColors.tagLineColor]),
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
                workingColors[WorkingColors.tagLineColor],
                onTapCallback: () {
                  displayPopupColorEditor(Options.tagLineColor);
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
                workingColors[WorkingColors.titleColor],
                onTapCallback: () {
                  toggleColorEditor(Options.titleColor);
                },
              ),
            ),
            AnimatedCrossFade(
                duration: Duration(milliseconds: 500),
                firstChild: colorPickerContainers[Options.titleColor],
                secondChild: Container(height: 0.0),
                crossFadeState: Options.titleColor == activeColorEditor
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond),
          ],
        ),
      ),
    );
  }

  Padding buildLandingPageMode() {
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
              Text("Landing Page Mode", style: homeTextStyleBold),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    workingLandingPageMode = !workingLandingPageMode;
                  });
                },
                icon: Icon(
                  workingLandingPageMode
                      ? UniconsSolid.toggle_on
                      : UniconsSolid.toggle_off,
                  color: workingLandingPageMode
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

  Widget buildHeaderPreview(BuildContext context, double sizeFactor) {
    Color thirdColor = gradientThirdColorEnabled
        ? workingColors[WorkingColors.gradientThirdColor]
        : null;

    double headerBackgroundHeight = workingLandingPageMode
        ? MediaQuery.of(context).size.height * sizeFactor
        : 400;
    double headerHeight = workingLandingPageMode
        ? MediaQuery.of(context).size.height * sizeFactor
        : 280;

    Widget widget = Stack(
      children: [
        headerBuilders['preview_background'](headerBackgroundHeight,
            MediaQuery.of(context).size.width - (memberViewPadding * 2.0),
            gradientFirstColor: workingColors[WorkingColors.gradientFirstColor],
            gradientSecondColor:
                workingColors[WorkingColors.gradientSecondColor],
            gradientThirdColor: thirdColor,
            gradientOrientation: workingGradientOrientation,
            backgroundStyle: getWorkingBGOption(),
            diagonalBarColor: workingColors[WorkingColors.diagonalColor],
            diagonalBarShadow: workingDiagonalBarShadow,
            diagonalBarShadowBlurRadius: workingDiagonalBarShadowBlurRadius,
            diagonalBarShadowLift: workingDiagonalBarShadowLift,
            diagonalMaxOpacity: workingDBMaxOpacity,
            topLeftBar: workingTLBActive,
            topRightBar: workingTRBActive,
            topLeftBarColor: workingColors[WorkingColors.topLeftBarColor],
            topRightBarColor: workingColors[WorkingColors.topRightBarColor]),
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
                      placeLogo: workingPlaceLogoActive,
                      tagLine: workingTaglineActive,
                      memberPreview: workingMemberPreviewActive,
                      customButton: workingCustomButtonActive,
                      inviteButton: workingInviteButtonActive,
                      tagLineColor: workingColors[WorkingColors.tagLineColor],
                      titleColor: workingColors[WorkingColors.titleColor],
                      titleText: placeNameController.text,
                      tagLineText: taglineController.text,
                      customButtonText: customButtonLabelController.text,
                      customButtonColor:
                          workingColors[WorkingColors.customButtonColor],
                      customButtonTextColor:
                          workingColors[WorkingColors.customButtonTextColor],
                      inviteButtonColor:
                          workingColors[WorkingColors.inviteButtonColor],
                      inviteButtonTextColor:
                          workingColors[WorkingColors.inviteButtonTextColor],
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
