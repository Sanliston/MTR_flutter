import 'dart:ui';

import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/home_customize_screen.dart';
import 'package:MTR_flutter/screens/templates/navigation_systems/navigation_system.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/rendering.dart';

class HomeTabBar extends NavigationSystem {
  const HomeTabBar(
      {Key key,
      @required List<String> tabs,
      @required this.controller,
      @required Color tabBarSelectedFontColor,
      @required Color tabBarUnselectedFontColor,
      @required Function tabControllerCb,
      @required Color selectedTabBarColor,
      @required TabBarStyle selectedTabBarStyle,
      bool preview: false,
      ScrollController scrollController})
      : _tabs = tabs,
        _tabBarSelectedFontColor = tabBarSelectedFontColor,
        _tabBarUnselectedFontColor = tabBarUnselectedFontColor,
        _tabControllerCB = tabControllerCb,
        _selectedTabBarColor = selectedTabBarColor,
        _selectedTabBarStyle = selectedTabBarStyle,
        _scrollController = scrollController,
        _preview = preview,
        super(key: key);

  final List<String> _tabs;
  final TabController controller;
  final Color _tabBarSelectedFontColor;
  final Color _tabBarUnselectedFontColor;
  final Color _selectedTabBarColor;
  final TabBarStyle _selectedTabBarStyle;
  final Function _tabControllerCB;
  final ScrollController _scrollController;
  final bool _preview;

  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

  @override
  _HomeTabBarState createState() => _HomeTabBarState(
      tabs: this._tabs,
      controller: this.controller,
      tabBarSelectedFontColor: this._tabBarSelectedFontColor,
      tabBarUnselectedFontColor: this._tabBarUnselectedFontColor,
      tabControllerCb: this._tabControllerCB,
      selectedTabBarColor: this._selectedTabBarColor,
      selectedTabBarStyle: this._selectedTabBarStyle,
      scrollController: this._scrollController,
      key: this.key);
}

class _HomeTabBarState extends State<HomeTabBar> with TickerProviderStateMixin {
  List<String> _tabs;
  TabController controller;
  ScrollController scrollController;
  Color _tabBarSelectedFontColor;
  Color _tabBarUnselectedFontColor;
  Color _selectedTabBarColor;
  Color _unselectedTabBarColor;
  TabBarStyle _selectedTabBarStyle;
  TabBarStyle _unselectedTabBarStyle;
  Function _tabControllerCB;
  List<Widget> tabList;
  bool _flexExpanded;
  int unselectedTabBarsBuilt = 0;
  bool tabBarVisible;
  ScrollDirection lastScrollDirection;

  _HomeTabBarState(
      {Key key,
      @required List<String> tabs,
      @required this.controller,
      @required Color tabBarSelectedFontColor,
      @required Color tabBarUnselectedFontColor,
      @required Function tabControllerCb,
      @required Color selectedTabBarColor,
      @required TabBarStyle selectedTabBarStyle,
      this.scrollController})
      : _tabs = tabs,
        _tabBarSelectedFontColor = tabBarSelectedFontColor,
        _tabBarUnselectedFontColor = tabBarUnselectedFontColor,
        _tabControllerCB = tabControllerCb,
        _selectedTabBarColor = selectedTabBarColor,
        _selectedTabBarStyle = selectedTabBarStyle;

  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

  _toggleHomeTabBar({bool expanded}) {
    if (_flexExpanded == expanded) {
      //acts as a litmus test, to stop the rest executing
      return;
    }

    print("toggletoolbaricon color called");

    Color newIconColor = null != expanded && expanded
        ? Colors.white
        : contentLayouts['header'][headerOptions.toolBarIconColor];

    TabBarStyle newSelectedTabBarStyle = selectedTabBarStyle;
    TabBarStyle newUnselectedTabBarStyle = unselectedTabBarStyle;
    Color newSelectedTabBarColor = selectedTabBarColor;
    Color newUnselectedTabBarColor = unselectedTabBarColor;
    Color newTabBarSelectedFontColor = tabBarSelectedFontColor;
    Color newTabBarUnselectedFontColor = tabBarUnselectedFontColor;

    if (!_flexExpanded) {
      newSelectedTabBarStyle = cSelectedTabBarStyle;
      newUnselectedTabBarStyle = cUnselectedTabBarStyle;
      newSelectedTabBarColor = cSelectedTabBarColor;
      newUnselectedTabBarColor = cUnselectedTabBarColor;
      newTabBarSelectedFontColor = cTabBarSelectedFontColor;
      newTabBarUnselectedFontColor = cTabBarUnselectedFontColor;
    }

    // if (_selectedTabBarStyle == newSelectedTabBarStyle) {
    //   return;
    // }

    setState(() {
      _selectedTabBarStyle = newSelectedTabBarStyle;
      _unselectedTabBarStyle = newUnselectedTabBarStyle;
      _selectedTabBarColor = newSelectedTabBarColor;
      _unselectedTabBarColor = newUnselectedTabBarColor;
      _tabBarSelectedFontColor = newTabBarSelectedFontColor;
      _tabBarUnselectedFontColor = newTabBarUnselectedFontColor;

      _flexExpanded = expanded;

      print("set state unselected tabbar style: $_unselectedTabBarStyle");
    });
  }

  void onTabDrag(int index) {
    String name = _tabs[index];

    print("====/=====/=== HomeTabBar ontabdrag called, name: $name");
    if ("AddTabButton" == name) {
      //stop event execution
      int index = controller.previousIndex;
      setState(() {
        controller.index = index;
      });
    }
  }

  void tabIndexChangeListener() {
    print("========/=======/====//=== index change listener called ");

    if (controller.indexIsChanging) {
      //--
    } else if (controller.index != controller.previousIndex) {
      // Tab Changed swiping to a new tab
      onTabDrag(controller.index);
      print("====/====/===== HomeTabBar index changed via swiper");
    }
  }

  @override
  initState() {
    super.initState();

    _tabBarSelectedFontColor = cTabBarSelectedFontColor;
    _tabBarUnselectedFontColor = cTabBarUnselectedFontColor;
    _unselectedTabBarColor = cUnselectedTabBarColor;
    _selectedTabBarColor = cSelectedTabBarColor;
    _selectedTabBarStyle = cSelectedTabBarStyle;
    _unselectedTabBarStyle = cUnselectedTabBarStyle;

    _flexExpanded = true;

    print(
        "##############################Tabs own initstate called, controller length: ${controller.length}");

    //add controller event listeners for swipe event
    controller.addListener(tabIndexChangeListener);

    //create tab list
    // tabList = _tabs.map((String name) {
    //   //only called at initial build
    //   //to force rebuild, set state and put dependant variable in here?: Yes
    //   //the variable is _currentTabIndex

    //   //if index is current index remove styling

    //   Widget widget = Tab(
    //     child: Container(
    //       decoration: buildSelectedTabStyle(
    //           color: _unselectedTabBarColor,
    //           tabBarStyle: _unselectedTabBarStyle),
    //       child: Align(
    //         alignment: Alignment.center,
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    //           child: Text(name),
    //         ),
    //       ),
    //     ),
    //   );

    //   if ("AddTabButton" == name) {
    //     widget = Icon(
    //       EvaIcons.plusCircle,
    //       color: Colors.white,
    //     );
    //   }

    //   return widget;
    // }).toList();

    toggleHomeTabBar = _toggleHomeTabBar;
    tabBarVisible = true;

    // if (null != scrollController) {
    //   scrollController.addListener(scrollDirectionListener);
    // }

    // controller.addListener(tabScrollListener);
  }

  void scrollDirectionListener() {
    ScrollDirection direction = scrollController.position.userScrollDirection;

    if (direction == lastScrollDirection || _flexExpanded) {
      return;
    }

    print("============user scroll direction: $direction");

    bool visible = true;

    if (ScrollDirection.reverse == direction) {
      visible = false;
    } else {
      visible = true;
    }

    setState(() {
      tabBarVisible = visible;
    });

    lastScrollDirection = direction;
  }

  void tabScrollListener() {
    if (!tabBarVisible) {
      setState(() {
        tabBarVisible = true;
      });
    }
  }

  @override
  dispose() {
    super.dispose();

    // if (null != scrollController) {
    //   //remove listener
    //   scrollController.removeListener(scrollDirectionListener);
    // }

    // controller.removeListener(tabScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // if (_flexExpanded) {
    //   return buildTabBar(context);
    // }

    Widget tabBar;

    tabBar = buildToolBarStyle(context: context, toolBarStyle: toolBarStyle);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      leadingTabButton
          ? Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    leadingTabButtonAction();
                  },
                  child: Icon(
                    leadingTabButtonIcon,
                    color: _tabBarUnselectedFontColor,
                  ),
                ),
              ),
            )
          : Container(),
      _tabs.length > 1
          ? Expanded(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedCrossFade(
                    firstChild: AnimatedOpacity(
                        opacity: tabBarVisible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: buildToolBarStyle(
                            context: context, toolBarStyle: toolBarStyle)),
                    secondChild: buildToolBarStyle(
                        context: context, toolBarStyle: cToolBarStyle),
                    crossFadeState: _flexExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 50),
                  ),
                ],
              ),
            )
          : Container(height: 40),
      isAdmin && !widget._preview
          ? Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => HomeCustomizeScreen()));
                  },
                  child: Icon(
                    EvaIcons.plusCircle,
                    color: _tabBarUnselectedFontColor,
                  ),
                ),
              ),
            )
          : Container()
    ]);
  }

  Widget buildToolBarStyle({BuildContext context, ToolBarStyle toolBarStyle}) {
    Widget tabBar;
    switch (toolBarStyle) {
      case ToolBarStyle.material:
        tabBar = buildTabBar(context);
        break;

      case ToolBarStyle.rounded:
        tabBar = Padding(
          padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5, bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: buildTabBar(context)),
                ),
              )),
        );
        break;

      case ToolBarStyle.roundedFrosted:
        tabBar = Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: Container(
                      //needs to be this height so it covers screen and doesnt cut in half when transitioning
                      color: tabBarBlurOverlayColor
                          .withOpacity(tabBarBlurOverlayOpacity),
                      child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: tabBarBlurOverlayColor),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5, bottom: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: buildTabBar(context)),
                            ),
                          ))))),
        );
        break;

      case ToolBarStyle.rectangle:
        tabBar = Padding(
          padding: const EdgeInsets.only(
              left: sidePadding * 2, right: sidePadding * 2),
          child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5, bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: buildTabBar(context)),
                ),
              )),
        );
        break;

      case ToolBarStyle.halfTop:
        tabBar = Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0),
          child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: halfTopBorderRadius, color: halfTopColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(halfTopRadius),
                  child: Container(
                      decoration:
                          BoxDecoration(borderRadius: halfTopBorderRadius),
                      child: buildTabBar(context)),
                ),
              )),
        );
        break;

      default:
        buildTabBar(context);
    }
    return tabBar;
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      physics: BouncingScrollPhysics(),
      labelPadding:
          EdgeInsets.only(top: 0.0, bottom: 0.0, left: 5.0, right: 5.0),
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      tabs: _tabs.map((String name) {
        //only called at initial build
        //to force rebuild, set state and put dependant variable in here?: Yes
        //the variable is _currentTabIndex

        //if index is current index remove styling

        Widget widget = Tab(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              // decoration: buildUnselectedTabStyle(
              //     color: _unselectedTabBarColor,
              //     tabBarStyle: _unselectedTabBarStyle),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(name),
                ),
              ),
            ),
          ),
        );

        if ("AddTabButton" == name) {
          widget = Icon(
            EvaIcons.plusCircle,
            color: Colors.white,
          );
        }

        return widget;
      }).toList(),
      controller: (() {
        //self executing function (functiondefinedhere)() <-- parentheses invoke it
        if (_tabs.length != controller.length) {
          controller = new TabController(length: _tabs.length, vsync: this);
          controller.addListener(() {
            print(
                "=====/=====/===/====new tab controller event listener called");
            //_tabControllerCB();
          });
        }

        return controller;
      })(),
      labelColor: _tabBarSelectedFontColor,
      unselectedLabelColor: _tabBarUnselectedFontColor,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
      indicatorColor: _tabBarSelectedFontColor,
      indicator: buildSelectedTabStyle(
          color: _selectedTabBarColor, tabBarStyle: _selectedTabBarStyle),
      onTap: (index) {
        print("ontap called");
        String name = _tabs[index];

        if ("AddTabButton" == name) {
          print("Add tab button detetced");
          //stop event execution
          int index = controller.previousIndex;
          setState(() {
            controller.index = index;
          });

          _tabControllerCB(index);

          //do stuff with button here
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => HomeCustomizeScreen()));
        }

        if (widget._preview) {
          _tabControllerCB(index);
        }
      },
    );
  }

  buildSelectedTabStyle({Color color, TabBarStyle tabBarStyle}) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: color);

    switch (tabBarStyle) {
      case TabBarStyle.halfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.inverseHalfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.border:
        return BorderTabIndicator(color: color, strokeWidth: 5.0);
        break;

      case TabBarStyle.fullRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color);
        break;

      case TabBarStyle.traditional:
        return UnderlineTabIndicator(
            borderSide: BorderSide(color: color, width: 4.0));
        break;

      case TabBarStyle.dot:
        return CircleTabIndicator(color: color, radius: 5.0);
        break;

      case TabBarStyle.bubble:
        return BubbleTabIndicator(color: color);
        break;

      case TabBarStyle.square:
        return BubbleTabIndicator(color: color, bubbleRadius: 5.0);
        break;

      case TabBarStyle.hoverLine:
        return LineTabIndicator(color: color, bubbleRadius: 5.0);
        break;

      case TabBarStyle.gradientBubble:
        return GradientBubbleTabIndicator(color: color, strokeWidth: 5.0);
        break;
    }

    return decoration;
  }

  buildUnselectedTabStyle({Color color, TabBarStyle tabBarStyle}) {
    // if (_tabs.length >= unselectedTabBarsBuilt) {
    //   return null;
    // }

    // unselectedTabBarsBuilt++;

    var decoration = BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: color);

    switch (tabBarStyle) {
      case TabBarStyle.halfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.inverseHalfRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: color);
        break;

      case TabBarStyle.border:
        return BorderTabIndicator(color: color, strokeWidth: 5.0);
        break;

      case TabBarStyle.fullRound:
        decoration = BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color);
        break;

      case TabBarStyle.traditional:
        return UnderlineTabIndicator(
            borderSide: BorderSide(color: color, width: 4.0));
        break;

      case TabBarStyle.dot:
        return CircleTabIndicator(color: color, radius: 5.0);
        break;

      case TabBarStyle.bubble:
        return BubbleTabIndicator(color: color);
        break;

      case TabBarStyle.square:
        return BubbleTabIndicator(color: color, bubbleRadius: 5.0);
        break;

      case TabBarStyle.hoverLine:
        return LineTabIndicator(color: color, bubbleRadius: 5.0);
        break;

      case TabBarStyle.gradientBubble:
        return GradientBubbleTabIndicator(color: color, strokeWidth: 5.0);
        break;
    }

    return decoration;
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5.0);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class BubbleTabIndicator extends Decoration {
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;

  BubbleTabIndicator(
      {this.color = Colors.grey,
      this.indicatorHeight = 30.0,
      this.bubbleRadius = 20.0});
  @override
  _BubbleTabPainter createBoxPainter([VoidCallback onChanged]) {
    return new _BubbleTabPainter(this, onChanged,
        color: this.color,
        indicatorHeight: this.indicatorHeight,
        bubbleRadius: this.bubbleRadius);
  }
}

class _BubbleTabPainter extends BoxPainter {
  final BubbleTabIndicator decoration;
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;

  _BubbleTabPainter(this.decoration, VoidCallback onChanged,
      {this.color = Colors.blue, this.indicatorHeight, this.bubbleRadius})
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = Offset(offset.dx,
            (configuration.size.height / 2) - (indicatorHeight / 2) + 0) &
        Size(configuration.size.width, indicatorHeight);
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(bubbleRadius)), paint);
  }
}

class LineTabIndicator extends Decoration {
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;

  LineTabIndicator(
      {this.color = Colors.grey,
      this.indicatorHeight = 30.0,
      this.bubbleRadius = 20.0});
  @override
  _LineTabPainter createBoxPainter([VoidCallback onChanged]) {
    return new _LineTabPainter(this, onChanged,
        color: this.color,
        indicatorHeight: this.indicatorHeight,
        bubbleRadius: this.bubbleRadius);
  }
}

class _LineTabPainter extends BoxPainter {
  final LineTabIndicator decoration;
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;

  _LineTabPainter(this.decoration, VoidCallback onChanged,
      {this.color = Colors.blue, this.indicatorHeight, this.bubbleRadius})
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    final widthSubtract = 20.0;

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = Offset(
            offset.dx + widthSubtract / 2, (configuration.size.height - 10)) &
        Size(configuration.size.width - widthSubtract, 5.0);
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(bubbleRadius)), paint);
  }
}

//=======Experimental Buttons ==========//
class BorderTabIndicator extends Decoration {
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;
  final double strokeWidth;
  final double borderWidth;

  BorderTabIndicator(
      {this.color = Colors.grey,
      this.indicatorHeight = 30.0,
      this.bubbleRadius = 20.0,
      this.strokeWidth = 2.0,
      this.borderWidth = 2.5});
  @override
  _BorderTabPainter createBoxPainter([VoidCallback onChanged]) {
    return new _BorderTabPainter(this, onChanged,
        color: this.color,
        gradient: getGradient(),
        radius: this.bubbleRadius,
        strokeWidth: this.strokeWidth,
        indicatorHeight: this.indicatorHeight,
        bubbleRadius: this.bubbleRadius,
        borderWidth: this.borderWidth);
  }
}

class _BorderTabPainter extends BoxPainter {
  final BorderTabIndicator decoration;
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;
  final Gradient gradient;
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final double borderWidth;

  _BorderTabPainter(this.decoration, VoidCallback onChanged,
      {this.color = Colors.blue,
      this.indicatorHeight,
      this.bubbleRadius,
      this.gradient,
      this.radius,
      this.strokeWidth,
      this.borderWidth = 2.5})
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // create outer rectangle equals size
    Rect outerRect = Offset(
            offset.dx - borderWidth,
            ((configuration.size.height / 2) - indicatorHeight / 2) -
                borderWidth) &
        Size(configuration.size.width + borderWidth * 2,
            indicatorHeight + borderWidth * 2);
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Offset(offset.dx + 0,
            ((configuration.size.height / 2) - indicatorHeight / 2) + 0) &
        Size(configuration.size.width, indicatorHeight);

    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class GradientBubbleTabIndicator extends Decoration {
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;
  final double strokeWidth;
  final double borderWidth;

  GradientBubbleTabIndicator(
      {this.color = Colors.grey,
      this.indicatorHeight = 25.0,
      this.bubbleRadius = 30.0,
      this.strokeWidth = 2.0,
      this.borderWidth = 2.5});
  @override
  _GradientBubbleTabPainter createBoxPainter([VoidCallback onChanged]) {
    return new _GradientBubbleTabPainter(this, onChanged,
        color: this.color,
        gradient: getGradient(),
        radius: this.bubbleRadius,
        strokeWidth: this.strokeWidth,
        indicatorHeight: this.indicatorHeight,
        bubbleRadius: this.bubbleRadius,
        borderWidth: this.borderWidth);
  }
}

class _GradientBubbleTabPainter extends BoxPainter {
  final GradientBubbleTabIndicator decoration;
  final Color color;
  final double indicatorHeight;
  final double bubbleRadius;
  final Gradient gradient;
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final double borderWidth;

  _GradientBubbleTabPainter(this.decoration, VoidCallback onChanged,
      {this.color = Colors.blue,
      this.indicatorHeight,
      this.bubbleRadius,
      this.gradient,
      this.radius,
      this.strokeWidth,
      this.borderWidth = 2.5})
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // create outer rectangle equals size
    Rect outerRect = Offset(
            offset.dx - borderWidth,
            ((configuration.size.height / 2) - indicatorHeight / 2) -
                borderWidth) &
        Size(configuration.size.width + borderWidth * 2,
            indicatorHeight + borderWidth * 2);
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Offset(offset.dx + 0,
            ((configuration.size.height / 2) - indicatorHeight / 2) + 0) &
        Size(configuration.size.width, indicatorHeight);

    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    // Path path2 = Path()..addRRect(innerRRect);
    // var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path1, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    @required double strokeWidth,
    @required double radius,
    @required Gradient gradient,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {@required double strokeWidth,
      @required double radius,
      @required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
