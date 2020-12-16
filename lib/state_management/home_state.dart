import 'package:MTR_flutter/screens/tabs/home/sections/groups_list_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/forum_posts_section.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/announcements_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_preview_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/UpcomingSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/contact_us_section.dart';

//home tab tabs persistence when switching to messages or profile etc - init state gets called when you return to home after switching to messages or profile
String selectedHomeTab = "home";

//State data -- currently populated for development
//in production these will be populated from API and cache
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

List<Map> groupsList = [
  {
    'name': 'The Fallen Order',
    'security': 'public',
    'members': [
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
      }
    ],
    'recent_activity': {
      'username': 'James',
      'action': 'posted',
      'post_title': 'I\'m sick of these damn Siths'
    }
  },
  {
    'name': 'Band of Bastards',
    'security': 'public',
    'members': [
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
      }
    ],
    'recent_activity': {
      'username': 'Smith',
      'action': 'liked',
      'post_title': 'That group name needs to be changed'
    }
  },
  {
    'name': 'The add ons',
    'security': 'private',
    'members': [
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
      }
    ],
    'recent_activity': {
      'username': 'Jordan',
      'action': 'replied to',
      'post_title':
          'This is a super super super long long long long question question question question you should not be able to see this part?'
    }
  },
  {
    'name': 'Awesome People',
    'security': 'public',
    'members': [
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
      }
    ],
    'recent_activity': null
  },
  {
    'name': 'Top Secret Crew',
    'security': 'private',
    'members': [
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
      }
    ],
    'recent_activity': {
      'username': 'Jordan',
      'action': 'replied to',
      'post_title': 'Is this the assassins creed?'
    }
  }
];

//functions to build sections
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

Widget buildGroupsListSection() {
  return new GroupsListSection();
}

//add any newly created sections to this enum
enum sections {
  announcements,
  membersPreview,
  upcoming,
  contactUs,
  forumPosts,
  members,
  groupsList
}

Map sectionMap = {
  sections.announcements: buildHomeAnnouncements,
  sections.membersPreview: buildMembersPreviewSection,
  sections.upcoming: buildUpcomingSection,
  sections.contactUs: buildContactUsSection,
  sections.forumPosts: buildForumPostsSection,
  sections.members: buildMembersSection,
  sections.groupsList: buildGroupsListSection
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

List<String> homeAdminTabList = <String>[
  "Home",
  "Forum",
  "Groups",
  "Members",
  "AddTabButton"
];

//decided to use string values in the map, as these can be
//added during runtime allowing for the creation of custom
//tabs with custom layouts
//NOTE: tab names here have to match those in homeTabList (excluding header and default)
enum headerOptions {
  tagLine,
  placeLogo,
  memberPreview,
  inviteButton,
  customButton,
  layout,
  blurEffect,
  logoShape,
  logoRadius
}

enum headerLayouts {
  left,
  centered,
  right,
}

enum logoShape {
  square,
  circle,
}

Map contentLayouts = {
  "header": {
    headerOptions.tagLine: true,
    headerOptions.placeLogo: true,
    headerOptions.memberPreview: true,
    headerOptions.inviteButton: true,
    headerOptions.customButton: true,
    headerOptions.layout:
        "default", //idea is to have different layouts, like picture on the left, all centered, etc.
    headerOptions.blurEffect: false,
    headerOptions.logoShape: logoShape.square,
    headerOptions.logoRadius: 4.0
  },
  "default": [
    sections.announcements,
    sections.membersPreview,
    sections.upcoming,
    sections.contactUs
  ],
  "Home": [
    sections.announcements,
    sections.membersPreview,
    sections.upcoming,
    sections.upcoming
  ],
  "Schedule": [sections.announcements],
  "Forum": [sections.forumPosts],
  "Groups": [sections.groupsList],
  "Members": [sections.membersPreview, sections.members],
  "Events": [sections.announcements],
  "Services": [sections.announcements],
  "Pricing": [sections.announcements],
  "test tab": [sections.membersPreview],
  "Content": [
    sections.announcements,
    sections.membersPreview,
    sections.upcoming,
    sections.upcoming
  ]
};

//function holder for home header build functions
Map<String, Function> headerBuilders = {};
