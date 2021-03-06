import 'dart:ui';

import 'package:MTR_flutter/components/advanced_color_picker.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_header/customize_header_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/edit_navigation/edit_navigation_screen.dart';
import 'package:MTR_flutter/screens/tabs/home_tab_screen.dart';
import 'package:MTR_flutter/state_management/customize_page_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/components/buttons.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class ModifyTabScreen extends StatefulWidget {
  final Function callback;
  final tabName;

  ModifyTabScreen({@required this.callback, @required this.tabName});

  @override
  _ModifyTabScreen createState() => _ModifyTabScreen();
}

class _ModifyTabScreen extends State<ModifyTabScreen>
    with TickerProviderStateMixin {
  List<String> _list;
  FocusNode focusNode;
  TextEditingController controller;
  bool notEmpty = false;

  double saveOpacity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list = homeTabList;
    saveOpacity = 0.4;
    focusNode = new FocusNode();
    controller = new TextEditingController();
    controller.addListener(() {
      if (notEmpty != controller.text.isNotEmpty) {
        setState(() {
          notEmpty = controller.text.isNotEmpty;
        });
      }
    });

    controller.text = widget.tabName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          color: bodyBackground,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenHeader(
                  controller: controller,
                  callback: widget.callback,
                  notEmpty: notEmpty,
                  originalName: widget.tabName,
                ),
                Padding(
                  padding: const EdgeInsets.all(sidePadding),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: focusNode.hasFocus ? 70 : 70,
                    child: TextFormField(
                      focusNode: focusNode,
                      controller: controller,
                      maxLength: 30,
                      style: homeSubTextStyle,
                      onTap: () {
                        _requestFocus(focusNode);
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        labelText: 'Tab Name',
                        labelStyle: GoogleFonts.heebo(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: focusNode.hasFocus ||
                                        controller.text.isNotEmpty
                                    ? 16
                                    : 12,
                                color: focusNode.hasFocus
                                    ? primaryColor
                                    : bodyFontColor)),
                        hintText: "Edit name",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  final Function callback;
  final bool notEmpty;
  final originalName;

  const ScreenHeader({
    Key key,
    @required this.controller,
    @required this.callback,
    @required this.originalName,
    @required this.notEmpty,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.25))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 0.0, bottom: 0.0, right: sidePadding),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    EvaIcons.closeOutline,
                    color: bodyFontColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'Rename Tab',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeTextStyleBold,
                ),
              ),
              Flexible(
                flex: 1,
                child: SolidButton(
                  width: 60,
                  backgroundColor:
                      notEmpty ? primaryColor : Colors.grey.withOpacity(0.3),
                  borderColor: Colors.transparent,
                  fontColor: Colors.white,
                  text: "Save",
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      return;
                    }

                    if (controller.text != originalName &&
                        homeTabList.contains(controller.text)) {
                      warn(
                          context: context,
                          message:
                              "A tab with this name already exists. Please choose a different name for your new tab.");

                      return;
                    }

                    int index = homeTabList.indexOf(originalName);

                    if (index == -1) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text("Something went wrong! Please try again.")));
                    }

                    //replace entry at index
                    homeTabList[index] = controller.text;

                    //create new key in contentLayouts with oldKey's value
                    contentLayouts[controller.text] =
                        contentLayouts[originalName];

                    //now remove old key from contentLayouts
                    contentLayouts.remove(originalName);

                    print("homeTabList updated: $homeTabList");
                    print("contentLayouts updated: $contentLayouts");

                    if (null != updateTabController &&
                        null != updatePreviewTabController) {
                      // updateTabController();
                      // updatePreviewTabController();
                      Navigator.pop(context);
                      callback();
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text("Something went wrong! Please try again.")));
                    }
                  },
                ),
              )
            ]),
      ),
    );
  }
}
