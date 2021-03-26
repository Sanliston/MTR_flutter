//this class will act as a config file for when each template is instantiated
import 'dart:ui';

import 'package:MTR_flutter/screens/templates/navigation_systems/navigation_system.dart';
import 'package:MTR_flutter/state_management/root_template_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

enum LogoShape {
  square,
  circle,
}

class BasicScreenTemplateConfig {
  //idea is to have all these values but for them to have defaults too
  //essentially turning home_state into a class

  List<String> subScreenList; //equivalent to homeTabList
  Map<String, List<sections>> subScreenContent;
  HeaderOptions headerOptions;
  NavigationSystem navigationSystem; //will need to figure this out

  BasicScreenTemplateConfig(
      {this.subScreenList,
      this.subScreenContent,
      this.headerOptions,
      this.navigationSystem}) {
    this.subScreenList =
        null != this.subScreenList ? this.subScreenList : ["default"];
    this.subScreenContent = null != this.subScreenContent
        ? this.subScreenContent
        : {
            "default": [
              sections.announcements,
              sections.membersPreview,
              sections.upcoming,
              sections.contactUs
            ]
          };
    this.headerOptions =
        null != this.headerOptions ? this.headerOptions : new HeaderOptions();
  }
}

class HeaderOptions {
  bool landingPageActive;
  Color titleColor;
  String titleText;
  double titleFontSize;
  Color headerFontColor;
  Color toolBarIconColor;
  bool blurredAppBar;
  bool tagLine;
  String tagLineText;
  Color tagLineColor;
  bool placeLogo;
  bool memberPreview;
  bool inviteButton;
  Color inviteButtonColor;
  Color inviteButtonTextColor;
  bool customButton;
  Color customButtonColor;
  Color customButtonTextColor;
  String customButtonText;
  String layout;
  bool blurEffect;
  LogoShape logoShape;
  double logoRadius;
  Color solidBackgroundColor;
  backgroundStyles backgroundStyle;
  LinearGradient backgroundGradient;
  double shadowHeight;
  Color appBarColor;
  Color tabBarColor;
  Color diagonalBarColor;
  bool diagonalBarShadow;
  Color diagonalBarShadowColor;
  double diagonalBarShadowBlurRadius;
  double diagonalBarShadowLift;
  double diagonalBarMaxOpacity;
  bool topLeftBar;
  bool topRightBar;
  bool bottomLeftBar;
  bool bottomRightBar;
  Color topLeftBarColor;
  Color topRightBarColor;
  Color bottomLeftBarColor;
  Color bottomRightBarColor;

  final LinearGradient defaultGradient = LinearGradient(
    //selected by function not manually -- code here is placeholder
    //maybe in future versions you can have an advanced tool for users to create gradients [done]
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      gradientColor1,
      gradientColor2,
    ],
  );

  //default values are set in the constructor
  HeaderOptions(
      {this.landingPageActive = false,
      this.titleColor = Colors.white,
      this.titleText = "Your new screen",
      this.titleFontSize = 30,
      this.headerFontColor = Colors.grey,
      this.toolBarIconColor = Colors.white,
      this.blurredAppBar = true,
      this.tagLine = true,
      this.tagLineText = "Write something here",
      this.tagLineColor = Colors.white,
      this.placeLogo = true,
      this.memberPreview = true,
      this.inviteButton = true,
      this.inviteButtonColor = Colors.white,
      this.inviteButtonTextColor = Colors.white,
      this.customButton = true,
      this.customButtonColor = Colors.white,
      this.customButtonTextColor = Colors.white,
      this.customButtonText = "Custom",
      this.layout = "default",
      this.blurEffect = false,
      this.logoShape = LogoShape.square,
      this.logoRadius = 10.0,
      this.solidBackgroundColor,
      this.backgroundStyle = backgroundStyles.video,
      this.backgroundGradient,
      this.shadowHeight = 0.0,
      this.appBarColor,
      this.tabBarColor,
      this.diagonalBarColor, //depreciated i think,
      this.diagonalBarShadow = true,
      this.diagonalBarShadowColor = Colors.black54,
      this.diagonalBarShadowBlurRadius = 15.0,
      this.diagonalBarShadowLift = 0.75,
      this.diagonalBarMaxOpacity = 1.0,
      this.topLeftBar = false,
      this.topRightBar = true,
      this.bottomLeftBar = false,
      this.bottomRightBar = false,
      this.topLeftBarColor,
      this.topRightBarColor,
      this.bottomRightBarColor,
      this.bottomLeftBarColor}) {
    //for the non constant values
    this.solidBackgroundColor = null != this.solidBackgroundColor
        ? this.solidBackgroundColor
        : primaryColor;

    this.appBarColor =
        null != this.appBarColor ? this.appBarColor : primaryColor;

    this.tabBarColor =
        null != this.tabBarColor ? this.tabBarColor : primaryColor;

    this.diagonalBarColor =
        null != this.diagonalBarColor ? this.diagonalBarColor : primaryColor;

    this.topLeftBarColor =
        null != this.topLeftBarColor ? this.topLeftBarColor : primaryColor;

    this.topRightBarColor =
        null != this.topRightBarColor ? this.topRightBarColor : primaryColor;

    this.bottomLeftBarColor = null != this.bottomLeftBarColor
        ? this.bottomLeftBarColor
        : primaryColor;

    this.bottomRightBarColor = null != this.bottomRightBarColor
        ? this.bottomRightBarColor
        : primaryColor;

    this.backgroundGradient = null != this.backgroundGradient
        ? this.backgroundGradient
        : LinearGradient(
            //selected by function not manually -- code here is placeholder
            //maybe in future versions you can have an advanced tool for users to create gradients [done]
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              gradientColor1,
              gradientColor2,
            ],
          );
  }
}
