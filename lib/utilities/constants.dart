import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/services.dart';

//global parameters and styles - these can all be changed via settings by the user

const double sidePadding = 15.0;
double buttonHeight = 32.0 * sizeFactor;
double buttonFontSize = 14.0 * sizeFactor;

double largeFontSize = 18 * sizeFactor;
double normalFontSize = 15 * sizeFactor;
double subtitleFontSize = 15 * sizeFactor;
double subFontSize = 13 * sizeFactor;
double smallFontSize = 9 * sizeFactor;

double navOptionFontSize = 14 * sizeFactor;

//bright red and orange theme
// const Color primaryColor = Color(0xFFFF416C);
// const Color secondaryColor = Color(0xFFFF4B2B);
// const Color accentColor = Color(0xFFFF4B2B);

//the best blue gradient yet
// const Color primaryColor = Color(0xFF3494E6);
// const Color secondaryColor = Color(0xFFEC6EAD);
// const Color accentColor = Color(0xFF3494E6);
// const Color iconColor = primaryColor;

//passion red gradient
// const Color primaryColor = Color(0xFF200122);
// const Color secondaryColor = Color(0xFF6f0000);
// const Color accentColor = primaryColor;
// const Color iconColor = primaryColor;

//Global Colors -- for dev -- future colors will be set in a themes file

//login screen parameters and styles

const login_bg_color = const Color(0xFF2d82fe);

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kLabelStyleRed = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final tabTextStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

//home screen parameters and styles
double avatarWidth = 40.0;
double avatarHeight = 40.0;
double avatarRadius = 60.0;

final fontColor = Colors.black87;

final homeSubtitleTextStyle = darkMode
    ? dHomeSubtitleTextStyle
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: subtitleFontSize,
            color: fontColor));

final homeLinkTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: subtitleFontSize,
        color: primaryColor));

final homeSubtitleTextStyleAccent = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: subtitleFontSize,
        color: primaryColor));

final homeTextStyle = darkMode
    ? dHomeTextStyle
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: normalFontSize,
            color: fontColor));

final homeTextStyleBold = darkMode
    ? dHomeTextStyleBold
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: normalFontSize,
            color: fontColor));

final homeTextStyleBoldWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: normalFontSize,
        color: Colors.white));

final homeTextStyleBoldWhiteSmall = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: smallFontSize,
        color: Colors.white));

final homeTextStyleWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: normalFontSize,
        color: Colors.white));

final homeSubTextStyle = darkMode
    ? dHomeSubTextStyle
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: subFontSize,
            color: fontColor));

final homeSubTextStyleBold = darkMode
    ? dHomeSubTextStyleBold
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: subFontSize,
            color: fontColor));

final homeSubTextStyleLight = darkMode
    ? dHomeSubTextStyleLight
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: subFontSize,
            color: fontColor));

final homeSubTextStyleFocused = darkMode
    ? dHomeSubTextStyleFocused
    : GoogleFonts.heebo(
        textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: subFontSize,
            color: fontColor));

final warningSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: subFontSize,
        color: Colors.red));

final warningTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: normalFontSize,
        color: Colors.red));

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [
    BoxShadow(
      color: Colors.transparent,
      blurRadius: 0.0,
      offset: Offset(0, 0),
    ),
  ],
);

final inputTransparentDecorationStyle = BoxDecoration(
  color: Colors.transparent,
  border: Border.all(width: 1.0, color: Colors.white),
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [
    BoxShadow(
      color: Colors.transparent,
      blurRadius: 0.0,
      offset: Offset(0, 0),
    ),
  ],
);

//dark mode font styles
final dFontColor = Colors.white;

final dHomeSubtitleTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: dFontColor));

final dHomeLinkTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: primaryColor));

final dHomeSubtitleTextStyleAccent = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: primaryColor));

final dHomeTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: dFontColor));

final dHomeTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: dFontColor));

final dHomeTextStyleBoldWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white));

final dHomeTextStyleBoldWhiteSmall = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 9, color: Colors.white));

final dHomeTextStyleWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white));

final dHomeSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 12, color: dFontColor));

final dHomeSubTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: dFontColor));

final dHomeSubTextStyleLight = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: dFontColor));

final dHomeSubTextStyleFocused = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: dFontColor));

//Forum tab styles
final forumTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black87));

final forumInteractionsStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: darkMode ? dFontColor.withOpacity(0.4) : Colors.black54));

//group tab values
final double memberAvatarWidth = 20.0;
final double memberAvatarHeight = 20.0;
final double memberAvatarRadius = 10.0;

final groupsSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: darkMode ? dFontColor : Colors.black54));

final groupsSubTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: darkMode ? dFontColor : Colors.black54));

//customize screen values
const double memberViewPadding = 30.0;
final customizeButtonText = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 10, color: Colors.white));
