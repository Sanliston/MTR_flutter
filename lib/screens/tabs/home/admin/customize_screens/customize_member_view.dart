import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_header/customize_header_screen.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/components/buttons.dart';

class CustomizeMemberView extends StatefulWidget {
  @override
  _CustomizeMemberView createState() => _CustomizeMemberView();
}

class _CustomizeMemberView extends State<CustomizeMemberView>
    with TickerProviderStateMixin {
  final double sizeFactor = 0.9;
  List<String> _tabs;
  TabController mVcontroller;
  String currentTab;
  Widget contentSection;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  bool landingPage;

  @override
  void initState() {
    _tabs = homeTabList;
    mVcontroller = TabController(
      length: _tabs.length,
      vsync: this,
    );

    int length = _tabs.length;
    landingPage = contentLayouts['header'][headerOptions.landingPageMode]
        [landingPageMode.active];

    print("tab length: $length");

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> buildPreview(BuildContext context, String tab) {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

    if (null == contentLayouts[tab]) {
      tab = "default";
    }

    List<Widget> widgets = <Widget>[];

    List components = contentLayouts[tab];

    for (var i = 0; i < components.length; i++) {
      //ADD components to build list
      Widget component = sectionMap[components[i]]();

      widgets.add(component);
    }

    return widgets;
  }

  Widget buildHeaderPreview(BuildContext context, {double headerHeight = 400}) {
    print("header preview being rebuilt in member view, ");
    Widget widget = Stack(
      children: [
        headerBuilders['preview_background'](headerHeight,
            MediaQuery.of(context).size.width - (memberViewPadding * 2.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: landingPage
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CustomizeHeaderScreen()))
                    .then((value) => setState(() {
                          print(
                              "set state called in customize member view, landingPage value $landingPage");
                          landingPage = contentLayouts['header'][
                              headerOptions
                                  .landingPageMode][landingPageMode
                              .active]; //setting this as this value doesn't seem to auto update after return
                        }));
              },
              padding: EdgeInsets.zero,
              child: AbsorbPointer(
                child: SizedBox(
                    height: 280.0,
                    child: headerBuilders['header'](context,
                        memberViewMode: true, sizeFactor: sizeFactor)),
              ),
            ),
            buildTabBarPreview()
          ],
        )
      ],
    );
    return widget;
  }

  SizedBox buildTabBarPreview() {
    return SizedBox(
      height: 39.0,
      child: TabBar(
        labelPadding:
            EdgeInsets.only(top: 0.0, bottom: 0.0, left: 5.0, right: 5.0),
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        tabs: _tabs.map((String name) {
          Widget widget = Tab(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.transparent, width: 1)),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(name),
                ),
              ),
            ),
          );

          if ("AddTabButton" == name) {
            widget = Icon(
              EvaIcons.plusCircle,
              color: Colors.redAccent,
            );
          }

          return widget;
        }).toList(),
        controller: mVcontroller,
        labelColor: contentLayouts['header'][headerOptions.appBarColor],
        unselectedLabelColor: Colors.black54,
        indicatorColor: contentLayouts['header'][headerOptions.appBarColor],
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        onTap: (index) {
          _currentIndex.value = index;
          print("tab clicked current tab: $currentTab");
        },
      ),
    );
  }

  void displayEditDrawer(BuildContext context, String sectionName) {
    Widget customHeader = Padding(
      padding: const EdgeInsets.only(
          top: 0.0, bottom: 5.0, left: sidePadding, right: sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            sectionName + " Section",
            style: homeTextStyleBold,
            overflow: TextOverflow.visible,
          ),

          //button which takes you to user profile
          TransparentButton(
            text: "Manage Bookings",
            onPressed: () {},
          )
        ],
      ),
    );

    Widget customBody = Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 0.0, right: 0.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: avatarWidth,
                    height: avatarHeight,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                    ),
                    child: Icon(
                      EvaIcons.arrowUpwardOutline,
                      color: primaryColor,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    "Move Up",
                    style: homeSubTextStyle,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: avatarWidth,
                    height: avatarHeight,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                    ),
                    child: Icon(
                      EvaIcons.arrowDownwardOutline,
                      color: primaryColor,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    "Move Down",
                    style: homeSubTextStyle,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: avatarWidth,
                    height: avatarHeight,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                    ),
                    child: Icon(
                      EvaIcons.copyOutline,
                      color: primaryColor,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    "Duplicate",
                    style: homeSubTextStyle,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: avatarWidth,
                    height: avatarHeight,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                    ),
                    child: Icon(
                      EvaIcons.fileAddOutline,
                      color: primaryColor,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    "Copy to tab",
                    style: homeSubTextStyle,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: avatarWidth,
                    height: avatarHeight,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.redAccent),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                    ),
                    child: Icon(
                      EvaIcons.trash2Outline,
                      color: Colors.redAccent,
                      size: 18.0,
                    ),
                  ),
                  Text(
                    "Remove",
                    style: warningSubTextStyle,
                    overflow: TextOverflow.visible,
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: SizedBox(
                width: 140.0,
                child: SolidButton(
                    text: "Edit Section",
                    iconData: EvaIcons.edit,
                    height: 35.0)),
          )
        ],
      ),
    );

    Map params = {
      "context": context,
      "custom_header": customHeader,
      "custom_body": customBody,
      "blur": false
    };

    displayNavigationDrawer(context, params);
  }

  /*to do the fancy little buttons we will be taking a unique approach using stacks and lists
  
    There are 2 parts to this:
    -The header and the tab bar. This can be regarded as one self contained unit.
    -The 'Add section' area and immediate component preview underneath. This can be regarded as one unit

    The reason is that they don't contain elements that hang outside of their bounds. So can be
    put into a List builder and look fine.

    The individual units however will need to be carefully constructed:

    header and tab bar unit:
    -padding at top
    -

  */

  @override
  Widget build(BuildContext context) {
    double headerHeight =
        landingPage ? MediaQuery.of(context).size.height * sizeFactor : 290;
    double smallButtonHeight = 24.0;

    return Container(
      color: darkMode ? darkNight.withOpacity(0.8) : darkNight,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildFirstSection(smallButtonHeight, headerHeight, context),
              ValueListenableBuilder(
                builder: (BuildContext context, int value, Widget child) {
                  // This builder will only get called when the _counter
                  // is updated.
                  String currentTab = homeTabList[_currentIndex.value];
                  return buildContentSection(
                      context, currentTab, headerHeight, smallButtonHeight);
                },
                valueListenable: _currentIndex,
              )
            ]),
      ),
    );
  }

  Padding buildFirstSection(
      double smallButtonHeight, double headerHeight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(alignment: Alignment.topCenter, children: [
        Padding(
          padding: EdgeInsets.only(
              left: memberViewPadding,
              right: memberViewPadding,
              top: smallButtonHeight / 2),
          child: Container(
            height: headerHeight + 30.0,
            color: Colors.white,
            child: buildHeaderPreview(context, headerHeight: headerHeight),
          ),
        ),
        SizedBox(
          height: 1.0,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: DashedLine(topOffset: 12.0),
          ),
        ),
        Positioned(
          top: headerHeight,
          child: SizedBox(
            height: 1.0,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: DashedLine(topOffset: 0.0),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SmallButton(
                height: smallButtonHeight,
                iconData: EvaIcons.edit,
                text: 'Edit Header'),
          ),
        ),
        Positioned(
          top: headerHeight - smallButtonHeight / 2,
          left: 0, //300 - (buttonHeight/2)
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SmallButton(
                height: smallButtonHeight,
                iconData: EvaIcons.edit,
                text: 'Edit Navigation Tabs'),
          ),
        )
      ]),
    );
  }

  Widget buildContentSection(BuildContext context, String currentTab,
      double headerHeight, double smallButtonHeight) {
    print("build content section called");
    //this builds the content section depending on the selected tab
    List<Widget> contentList = buildTab(context, currentTab);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: contentList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Widget widget = Container();
          sections component = contentLayouts[currentTab][index];
          print("component: $component");
          String sectionName = sectionStringMap[component];

          Color sectionStripBase = darkMode ? bodyBackground : Colors.white;
          Color sectionStripTop = darkMode ? itemBackground : Colors.blue[100];

          if (index >= contentList.length - 1) {
            widget = Stack(alignment: Alignment.topCenter, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: memberViewPadding,
                    right: memberViewPadding,
                    top: 20.0),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(-0.9, -0.7),
                        stops: [0.0, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 1],
                        colors: [
                          sectionStripBase,

                          sectionStripBase,
                          sectionStripTop,
                          sectionStripTop,
                          sectionStripBase,

                          sectionStripBase,
                          sectionStripTop,
                          sectionStripTop,
                          //red
                          //orange
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    child: SmallButton(
                        height: smallButtonHeight,
                        iconData: EvaIcons.edit,
                        text: 'Add section'),
                  )
                ]),
              ),
              SizedBox(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: DashedLine(topOffset: 2.0),
                ),
              ),
            ]);
          }

          return Column(
            children: [
              Stack(alignment: Alignment.topCenter, children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: memberViewPadding,
                      right: memberViewPadding,
                      top: 20.0,
                      bottom: 10.0),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(-0.9, -0.5),
                          stops: [0.0, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 1],
                          colors: [
                            sectionStripBase,
                            sectionStripTop,
                            sectionStripBase,
                            sectionStripTop,
                            sectionStripBase,
                            sectionStripTop,
                            sectionStripBase,
                            sectionStripTop,

                            //red
                            //orange
                          ],
                          tileMode: TileMode.repeated,
                        ),
                      ),
                      height: 60.0,
                    ),
                    Positioned(
                      top: 20.0,
                      child: SmallButton(
                          height: smallButtonHeight,
                          iconData: EvaIcons.edit,
                          text: 'Add section'),
                    )
                  ]),
                ),
                SizedBox(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: DashedLine(topOffset: 2.0),
                  ),
                ),
              ]),
              Stack(alignment: Alignment.topCenter, children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: memberViewPadding,
                      right: memberViewPadding,
                      top: 12.0),
                  child: Container(
                      color: bodyBackground,
                      child: FlatButton(
                          onPressed: () {
                            displayEditDrawer(context, sectionName);
                          },
                          padding: EdgeInsets.zero,
                          child: AbsorbPointer(child: contentList[index]))),
                ),
                SizedBox(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: DashedLine(topOffset: 12.0),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SmallButton(
                      height: smallButtonHeight,
                      iconData: EvaIcons.edit,
                      text: 'Edit $sectionName',
                      onPressed: () {
                        displayEditDrawer(context, sectionName);
                      },
                    ),
                  ),
                ),
              ]),
              widget
            ],
          );
        });
  }

  List<Widget> buildTab(BuildContext context, String tab) {
    /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

    /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

    if (null == contentLayouts[tab]) {
      tab = "default";
    }

    List<Widget> widgets = <Widget>[];

    List components = contentLayouts[tab];

    for (var i = 0; i < components.length; i++) {
      //ADD components to build list
      Widget component = sectionMap[components[i]]();

      widgets.add(component);
    }

    print("build tab called");

    return widgets;
  }
}
