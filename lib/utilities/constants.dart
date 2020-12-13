import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/services.dart';

//global parameters and styles - these can all be changed via settings by the user

const double sidePadding = 15.0;
const Color iconColor = Colors.redAccent;

//login screen parameters and styles

const login_bg_color = const Color(0xFF2d82fe);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
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
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.redAccent));

final homeSubtitleTextStyleAccent = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.redAccent));

final homeTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black87));

final homeTextStyleBold = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87));

final homeTextStyleBoldWhite = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white));

final homeSubTextStyle = GoogleFonts.heebo(
    textStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black54));

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
