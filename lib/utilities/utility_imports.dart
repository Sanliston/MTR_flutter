//File for importing lots of files at once to whichever files imports this file: https://stackoverflow.com/questions/55579092/how-to-avoid-writing-an-import-for-every-single-file-in-dart-flutter
export 'package:flutter/material.dart';
export 'package:MTR_flutter/utilities/constants.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:MTR_flutter/state_management/global_state.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:unicons/unicons.dart';
export 'package:MTR_flutter/state_management/home_state.dart';

//function for rebuilding main screen
import 'dart:io';

import 'package:MTR_flutter/components/buttons.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/home_customize_screen.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  //hopefully this gets updated values from home_state
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MainScreen()));
}

void rebuildHomeCustomizeScreen(BuildContext context) {
  /*this approach fixes the issue with the customTabScroll no longer calling
                            callback set in widget.scrollController.position.isScrollingNotifier.addListener(snap);

                            Issue is fixed by just rebuilding main screen
                            */

  //remove customize screen from navigation history and goes back to main screen
  Navigator.pop(context);

  //removes main screen from navigation history and goes back to login screen
  Navigator.pop(context);

  //reopens the main screen again as a new screen - so back button goes back to login screen now
  //hopefully this gets updated values from home_state
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeCustomizeScreen()));
}

void doubleNavigatorPop({BuildContext context, Widget screen}) {
  //remove customize screen from navigation history and goes back to main screen
  Navigator.pop(context);

  //removes main screen from navigation history and goes back to login screen
  Navigator.pop(context);

  //reopens the main screen again as a new screen - so back button goes back to login screen now
  //hopefully this gets updated values from home_state
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
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

Future<File> getImageFromGallery(
    {double maxWidth = 750, double maxHeight = 750, bool crop = true}) async {
  PickedFile pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );

  File file;

  if (null != pickedFile) {
    file = File(pickedFile.path);
  }

  if (crop) {
    file = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            statusBarColor: primaryColor,
            toolbarTitle: 'Crop your Image',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }

  return file;
}

Future<File> getImageFromCamera(
    {double maxWidth = 750, double maxHeight = 750, bool crop = true}) async {
  PickedFile pickedFile = await ImagePicker().getImage(
    source: ImageSource.camera,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );

  File file;

  if (null != pickedFile) {
    file = File(pickedFile.path);
  }

  if (crop) {
    file = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            statusBarColor: primaryColor,
            toolbarTitle: 'Crop your Image',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }

  return file;
}

void warn({@required BuildContext context, @required String message}) {
  TextOverflow overflow = TextOverflow.visible;
  int maxlines = 3;

  Widget customHeader = Padding(
    padding: const EdgeInsets.only(
        top: 5.0, bottom: 5.0, left: sidePadding, right: sidePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 4 * sidePadding,
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: homeSubTextStyle,
              overflow: overflow,
              maxLines: maxlines,
              softWrap: true,
            ),
          ),
        ),

        //button which takes you to user profile
      ],
    ),
  );

  Widget customBody = Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: sidePadding, right: sidePadding),
      child: Center(
        child: SolidButton(
          height: 30,
          width: 100,
          backgroundColor: Colors.red,
          fontColor: Colors.white,
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
}
