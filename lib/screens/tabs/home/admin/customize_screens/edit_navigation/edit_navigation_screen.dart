import 'dart:ui';

import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_header/customize_header_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/edit_navigation/create_tab_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/edit_navigation/modify_tab_screen.dart';
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

class EditNavigationScreen extends StatefulWidget {
  @override
  _EditNavigationScreen createState() => _EditNavigationScreen();
}

class _EditNavigationScreen extends State<EditNavigationScreen>
    with TickerProviderStateMixin {
  List<String> _list;
  final double listElementHeight = 50;
  final ScrollController scrollController = new ScrollController();
  final ScrollController reorderScrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list = homeTabList;
    reorderScrollController.addListener(() {
      // print("reorderScroll called");

      // reorderScrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void reorderHomeTabList(int oldIndex, int newIndex) {
    String old = _list[oldIndex];
    if (oldIndex > newIndex) {
      for (int i = oldIndex; i > newIndex; i--) {
        _list[i] = _list[i - 1];
      }
      _list[newIndex] = old;
    } else {
      for (int i = oldIndex; i < newIndex - 1; i++) {
        _list[i] = _list[i + 1];
      }
      _list[newIndex - 1] = old;
    }
    setState(() {});
  }

  void displayDeletionWarning(String item) {
    Widget customHeader = Container(
      child: Padding(
        padding: const EdgeInsets.all(sidePadding),
        child: Center(
          child: Text(
            "Are you sure you want to delete the $item Tab?",
            style: homeTextStyleBold,
          ),
        ),
      ),
    );

    Widget customBody = Container(
        child: Padding(
      padding: const EdgeInsets.all(sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SolidButton(
            height: 30,
            text: "Delete",
            onPressed: () {
//delete tab
              //remove item from homeTabList
              homeTabList.remove(item);

              contentLayouts.remove(item);

              Navigator.pop(context);

              setState(() {
                //to refresh tab list
              });

              //inform user of deletion
              NotificationAlertDrawer(
                  context: context,
                  message: "$item Tab has been successfully deleted",
                  backgroundColor: Colors.red);
            },
            backgroundColor: Colors.red[400],
          ),
          SolidButton(
            height: 30,
            text: "Cancel",
            backgroundColor: Colors.grey[350],
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    ));

    Map params = {
      "context": context,
      "custom_header": customHeader,
      "custom_body": customBody
    };

    displayNavigationDrawer(context, params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: bodyBackground,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.25))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.infoOutline,
                            color: bodyFontColor,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          'Edit Navigation Tabs',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: homeTextStyleBold,
                        ),
                        TextButton(
                          onPressed: () {
                            // rebuildHomeCustomizeScreen(context);
                            /*<-- the line above was causing a
                              ScrollController attached to multiple scroll views error.
                              The line below seems to be the better approach
                             */
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Done',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: homeTextStyle,
                          ),
                        )
                      ]),
                ),
              ),
              Flexible(
                  child: Container(
                // height: (_list.length * listElementHeight) + 300,
                child: ImplicitlyAnimatedReorderableList<String>(
                  physics: BouncingScrollPhysics(),
                  items: _list,
                  areItemsTheSame: (a, b) => a == b,
                  onReorderFinished: (item, from, to, newItems) {
                    // Remember to update the underlying data when the list has been
                    // reordered.
                    setState(() {
                      _list
                        ..clear()
                        ..addAll(newItems);
                    });
                  },
                  itemBuilder: (context, itemAnimation, item, index) {
                    // Each item must be wrapped in a Reorderable widget.
                    return Reorderable(
                      // Each item must have an unique key.
                      key: ValueKey(item),
                      // The animation of the Reorderable builder can be used to
                      // change to appearance of the item between dragged and normal
                      // state. For example to add elevation when the item is being dragged.
                      // This is not to be confused with the animation of the itemBuilder.
                      // Implicit animations (like AnimatedContainer) are sadly not yet supported.
                      builder: (context, dragAnimation, inDrag) {
                        final t = dragAnimation.value;
                        final elevation = lerpDouble(0, 2, t);
                        final color = bodyBackground.withOpacity(0.9);

                        return SizeFadeTransition(
                          sizeFraction: 0.7,
                          curve: Curves.easeInOut,
                          animation: itemAnimation,
                          child: Material(
                            color: color,
                            elevation: elevation,
                            type: MaterialType.canvas,
                            child: Handle(
                              delay: const Duration(milliseconds: 150),
                              child: Container(
                                height: 60,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sidePadding),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: sidePadding),
                                        child: Icon(
                                          UniconsLine.draggabledots,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey,
                                            width: 0.25,
                                          ))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0),
                                                              child: Text(
                                                                item,
                                                                style:
                                                                    homeTextStyleBold,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            List options = [
                                                              {
                                                                "iconData": EvaIcons
                                                                    .editOutline,
                                                                "title":
                                                                    "Rename Tab",
                                                                "onPressed":
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);

                                                                  CustomNavigationDrawer(
                                                                      context:
                                                                          context,
                                                                      container:
                                                                          Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                sidePadding,
                                                                            right:
                                                                                sidePadding,
                                                                            bottom:
                                                                                (MediaQuery.of(context).size.height / 2) - 80),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              205,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: bodyBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                              child: ModifyTabScreen(
                                                                                tabName: item,
                                                                                callback: () {
                                                                                  setState(() {
                                                                                    // call set state just to rebuild and update list
                                                                                    NotificationAlertDrawer(context: context, message: "Successfully updated tab");
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                }
                                                              },
                                                              {
                                                                "iconData": EvaIcons
                                                                    .trash2Outline,
                                                                "icon_color":
                                                                    Colors.red,
                                                                "font_color":
                                                                    Colors.red,
                                                                "title":
                                                                    "Delete Tab",
                                                                "onPressed":
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  displayDeletionWarning(
                                                                      item);
                                                                }
                                                              },
                                                            ];

                                                            Map params = {
                                                              "context":
                                                                  context,
                                                              "title":
                                                                  "Edit $item Tab",
                                                              "description":
                                                                  "What would you like to do with this tab?",
                                                              "options": options
                                                            };

                                                            displayNavigationDrawer(
                                                                context,
                                                                params);
                                                          },
                                                          child: Icon(
                                                            EvaIcons
                                                                .moreHorizotnal,
                                                            color:
                                                                bodyFontColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },

                  // Since version 0.2.0 you can also display a widget
                  // before the reorderable items...
                  header: Padding(
                    padding: const EdgeInsets.only(
                        top: sidePadding * 2,
                        left: sidePadding,
                        right: sidePadding,
                        bottom: sidePadding),
                    child: Container(
                      child: Text("Tap, hold & drag to reorder",
                          style: homeTextStyle),
                    ),
                  ),
                  // ...and after. Note that this feature - as the list itself - is still in beta!
                  footer: Padding(
                    padding: const EdgeInsets.only(
                        top: sidePadding * 2,
                        left: sidePadding,
                        right: sidePadding,
                        bottom: sidePadding),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) => CreateTabScreen()));

                        CustomNavigationDrawer(
                            context: context,
                            container: Padding(
                              padding: EdgeInsets.only(
                                  left: sidePadding,
                                  right: sidePadding,
                                  bottom:
                                      (MediaQuery.of(context).size.height / 2) -
                                          80),
                              child: SizedBox(
                                height: 180,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: bodyBackground,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: CreateTabScreen(
                                      callback: () {
                                        setState(() {
                                          // call set state just to rebuild and update list
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      },
                      child: Row(
                        children: [
                          Icon(EvaIcons.plusCircleOutline,
                              color: bodyFontColor),
                          Padding(
                            padding: const EdgeInsets.only(left: sidePadding),
                            child: Container(
                              child:
                                  Text("Add New Tab", style: homeTextStyleBold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // If you want to use headers or footers, you should set shrinkWrap to true
                  shrinkWrap: true,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
