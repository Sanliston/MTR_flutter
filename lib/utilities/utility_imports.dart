//File for importing lots of files at once to whichever files imports this file: https://stackoverflow.com/questions/55579092/how-to-avoid-writing-an-import-for-every-single-file-in-dart-flutter
export 'package:flutter/material.dart';
export 'package:MTR_flutter/utilities/constants.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:MTR_flutter/state_management/global_state.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:unicons/unicons.dart';

//function for rebuilding main screen
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MTR_flutter/screens/main_screen.dart';

void rebuildMainScreen(BuildContext context) {
  /*this approach fixes the issue with the customTabScroll no longer calling
                            callback set in widget.scrollController.position.isScrollingNotifier.addListener(snap);

                            Issue is fixed by just rebuilding main screen
                            */

  //remove customize screen from navigation history and goes back to main screen
  Navigator.pop(context);

  //removes main screen from navigation history and goes back to login screen
  Navigator.pop(context);

  //reopens the main screen again as a new screen - so back button goes back to login screen now
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MainScreen()));
}

String getColorHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

Color getHexColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

void unfocus(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}
