import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';

List<Widget> buildMembersTab(BuildContext context) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  List<Widget> widgets = <Widget>[
    /*This item is a button that looks like a search field, but when clicked will take the 
      user a new page which allows them to search for members. This will happen seamlessly to
      make it look like the user is still on the same page*/
    MembersSection(),
  ];

  return widgets;
}
