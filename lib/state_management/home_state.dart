import 'package:MTR_flutter/screens/tabs/home/sections/forumPostsSection.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/AnnouncementsSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/MembersSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/UpcomingSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/ContactUsSection.dart';

//tab persistence when switching to messages or profile etc - init state gets called when you return after switching to messages or profile
String selectedHomeTab = "home";

//State data
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

List<Map> forumPosts = [
  {
    'user': 'Waka Flocka',
    'title': 'Flocka Bitches',
    'date': '5 months ago',
    'body':
        'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
    'likes': 10,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '1 year ago',
    'body': 'Lorem ipsum etc man',
    'likes': 246,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '20/10/16',
    'body': 'Lorem ipsum etc man',
    'likes': 1000,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
  {
    'user': 'Jane',
    'title': 'Test',
    'date': '20/10/12',
    'body': 'Lorem ipsum etc man',
    'likes': 5678,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
];

//functions to build components
Widget buildHomeAnnouncements() {
  return new AnnoucementsSection(
    announcements: announcements,
  );
}

Widget buildHomeMembers() {
  return new MembersSection(
    membersShortlist: membersShortlist,
  );
}

Widget buildHomeUpcoming() {
  return new UpcomingSection();
}

Widget buildHomeContactUs() {
  return new ContactUsSection();
}

Widget buildForumPosts() {
  return new ForumPostsSection(forumPosts: forumPosts);
}

Map componentMap = {
  "announcements": buildHomeAnnouncements,
  "members": buildHomeMembers,
  "upcoming": buildHomeUpcoming,
  "contact_us": buildHomeContactUs,
  "forum_posts": buildForumPosts
};

//home tab state
enum homeTab {
  headerLayout,
  homeLayout,
  forumLayout,
  groupsLayout,
  membersLayout,
  eventsLayout,
  servicesLayout,
  pricingLayout,
  contentLayout
}

Map homeTabState = {
  homeTab.headerLayout: [],
  homeTab.homeLayout: ["announcements", "members", "upcoming", "contact_us"],
  homeTab.forumLayout: ["forum_posts", "members"]
};
