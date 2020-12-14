import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

//build the home widget Map
List<Widget> buildHomeTab(BuildContext context) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

  List<Widget> widgets = <Widget>[];

  List components = contentLayouts["home"];

  for (var i = 0; i < components.length; i++) {
    //ADD components to build list
    Widget component = componentMap[components[i]]();

    widgets.add(component);
  }

  return widgets;
}
