import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/components/announcements.dart';
import 'package:MTR_flutter/screens/tabs/home/components/members.dart';
import 'package:MTR_flutter/screens/tabs/home/components/upcoming.dart';
import 'package:MTR_flutter/screens/tabs/home/components/contact_us.dart';

/*This screen will be made of tabs: Home, Inbox, and Personal 
  link: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html 
  */

//can be dynamically changed, yay
List<Map> announcements = [
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '5 months ago',
    'body':
        'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man'
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '1 year ago',
    'body': 'Lorem ipsum etc man'
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '20/10/16',
    'body': 'Lorem ipsum etc man'
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '20/10/12',
    'body': 'Lorem ipsum etc man'
  },
];

List<Map> membersShortlist = [
  {
    "username": "Jane Ipsum",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
  },
  {
    "username": "Bebe Rxha",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
  },
  {
    "username": "Claire Jojo",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
  },
  {
    "username": "Bebe Reha",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
  },
  {
    "username": "Yolo oi",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg"
  },
];

Widget buildHomeAnnouncements() {
  return new HomeAnnoucements(
    announcements: announcements,
  );
}

Widget buildHomeMembers() {
  return new HomeMembers(
    membersShortlist: membersShortlist,
  );
}

Widget buildHomeUpcoming() {
  return new HomeUpcoming();
}

Widget buildHomeContactUs() {
  return new HomeContactUs();
}

//build the home widget Map
List<Widget> buildHomeTab(BuildContext context) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */
  Map componentMap = {
    "announcements": buildHomeAnnouncements,
    "members": buildHomeMembers,
    "upcoming": buildHomeUpcoming,
    "contact_us": buildHomeContactUs
  };

  List<Widget> widgets = <Widget>[];

  List components = homeTabState[homeTab.bodyLayout];

  for (var i = 0; i < components.length; i++) {
    //ADD components to build list
    Widget component = componentMap[components[i]]();

    widgets.add(component);
  }

  return widgets;
}
