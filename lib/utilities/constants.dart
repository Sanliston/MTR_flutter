import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/services.dart';

//global parameters and styles - these can all be changed via settings by the user

const double sidePadding = 15.0;

//bright red and orange theme
// const Color primaryColor = Color(0xFFFF416C);
// const Color secondaryColor = Color(0xFFFF4B2B);
// const Color accentColor = Color(0xFFFF4B2B);

const Color primaryColor = Color(0xFFbc4e9c);
const Color secondaryColor = Color(0xFFf80759);
const Color accentColor = Color(0xFFC06C84);
const Color iconColor = primaryColor;

//Global Colors -- for dev -- future colors will be set in a themes file
const Color darkNight = Color(0xFF263238);

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
final double avatarWidth = 40.0;
final double avatarHeight = 40.0;
final double avatarRadius = 60.0;

final homeSubtitleTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87));

final homeLinkTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: primaryColor));

final homeSubtitleTextStyleAccent = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: primaryColor));

final homeTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black87));

final homeTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87));

final homeTextStyleBoldWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white));

final homeTextStyleBoldWhiteSmall = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 9, color: Colors.white));

final homeTextStyleWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white));

final homeSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black54));

final homeSubTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54));

final homeSubTextStyleLight = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54));

final warningSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 12, color: Colors.red));

final warningTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.red));

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

//Forum tab styles
final forumTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black87));

final forumInteractionsStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54));

//group tab values
final double memberAvatarWidth = 20.0;
final double memberAvatarHeight = 20.0;
final double memberAvatarRadius = 10.0;

final groupsSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black54));

final groupsSubTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black54));

//customize screen values
const double memberViewPadding = 30.0;
final customizeButtonText = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 10, color: Colors.white));
