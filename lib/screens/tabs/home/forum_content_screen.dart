import 'package:MTR_flutter/screens/tabs/home/sections/forumPostsSection.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';

List<Widget> buildForumTab(BuildContext context) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */

  List<Widget> widgets = <Widget>[];

  List components = homeTabState[homeTab.forumLayout];

  for (var i = 0; i < components.length; i++) {
    //ADD components to build list
    Widget component = componentMap[components[i]]();

    widgets.add(component);
  }

  return widgets;
}
