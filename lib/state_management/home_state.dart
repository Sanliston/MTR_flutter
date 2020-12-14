import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/forum_posts_section.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/announcements_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_preview_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/UpcomingSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/contact_us_section.dart';

//home tab tabs persistence when switching to messages or profile etc - init state gets called when you return to home after switching to messages or profile
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

List<Map> membersList = [
  {
    "username": "Jane Ipsum",
    "role": "Owner",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Bebe Rxha",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Claire Jojo",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Bebe Reha",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Yolo oi",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Bebe Reha",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Yolo oi",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Bebe Reha",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  },
  {
    "username": "Yolo oi",
    "role": "Member",
    "profile_image": "https://randomuser.me/api/portraits/women/69.jpg",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ]
  }
];

//functions to build components
Widget buildHomeAnnouncements() {
  return new AnnoucementsSection(
    announcements: announcements,
  );
}

Widget buildMembersPreviewSection() {
  return new MembersPreviewSection(
    membersShortlist: membersShortlist,
  );
}

Widget buildUpcomingSection() {
  return new UpcomingSection();
}

Widget buildContactUsSection() {
  return new ContactUsSection();
}

Widget buildForumPostsSection() {
  return new ForumPostsSection(forumPosts: forumPosts);
}

Widget buildMembersSection() {
  return new MembersSection();
}

//add any newly created components to this enum
enum components {
  announcements,
  membersPreview,
  upcoming,
  contactUs,
  forumPosts,
  members
}

Map componentMap = {
  components.announcements: buildHomeAnnouncements,
  components.membersPreview: buildMembersPreviewSection,
  components.upcoming: buildUpcomingSection,
  components.contactUs: buildContactUsSection,
  components.forumPosts: buildForumPostsSection,
  components.members: buildMembersSection
};

//home tab state
List<String> homeTabList = <String>[
  "Home",
  "test tab",
  "Forum",
  "Groups",
  "Members",
  "Events",
  "Services",
  "Pricing",
  "Content"
];

//decided to use string values in the map, as these can be
//added during runtime allowing for the creation of custom
//tabs with custom layouts
Map contentLayouts = {
  "header": [],
  "default": [
    components.announcements,
    components.membersPreview,
    components.upcoming,
    components.contactUs
  ],
  "Home": [
    components.announcements,
    components.membersPreview,
    components.upcoming,
    components.upcoming
  ],
  "Schedule": [components.announcements],
  "Forum": [components.forumPosts],
  "Groups": [components.forumPosts],
  "Members": [components.membersPreview, components.members],
  "Events": [components.announcements],
  "Services": [components.announcements],
  "Pricing": [components.announcements],
  "test tab": [components.membersPreview]
};
