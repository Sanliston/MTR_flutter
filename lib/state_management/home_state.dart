import 'package:MTR_flutter/screens/tabs/home/sections/groups_list_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/forum_posts_section.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/announcements_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/members_preview_section.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/UpcomingSection.dart';
import 'package:MTR_flutter/screens/tabs/home/sections/contact_us_section.dart';

/* 
  TODO: Change enums to start with Capital letters
*/

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
    "joined": "Nov 28 2020",
    "followers": 10,
    "following": 200,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Bebe Rxha",
    "role": "Member",
    "profile_image":
        "https://pagesix.com/wp-content/uploads/sites/3/2020/03/bebe-rexha-30.jpg?quality=80&strip=all",
    "joined": "Nov 28 2020",
    "followers": 130002,
    "following": 200,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Kratos",
    "role": "Member",
    "profile_image":
        "https://i1.wp.com/metro.co.uk/wp-content/uploads/2018/12/god-of-war-kratos-dad-jokes-0ddb.png?quality=90&strip=all&zoom=1&resize=644%2C381&ssl=1",
    "joined": "Nov 28 2020",
    "followers": 1000000010020,
    "following": 3,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": false
  },
  {
    "username": "The boy",
    "role": "Member",
    "profile_image": "https://i.ytimg.com/vi/80VpyWccS64/maxresdefault.jpg",
    "joined": "Nov 28 2020",
    "followers": 1030056,
    "following": 218,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": false
  },
  {
    "username": "Boba Fett",
    "role": "Member",
    "profile_image":
        "https://imgix.bustle.com/uploads/image/2020/11/12/62c8f368-f427-4c10-8873-e6ad4d69f51b-boba-fett.jpg?w=1200&h=630&q=70&fit=crop&crop=faces&fm=jpg",
    "joined": "Nov 28 2020",
    "followers": 10500098,
    "following": 5,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Arthur Morgan",
    "role": "Member",
    "profile_image":
        "https://i.pinimg.com/originals/90/09/79/900979ebb3fe7ed2b6c0436a67ef02c3.jpg",
    "joined": "Nov 28 2020",
    "followers": 10,
    "following": 0,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": false
  },
  {
    "username": "Boah",
    "role": "Member",
    "profile_image":
        "https://pm1.narvii.com/7117/a44b941b250670579795af9a87fc18444174ad99r1-1555-2048v2_hq.jpg",
    "joined": "Nov 28 2020",
    "followers": 1,
    "following": 1,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Mando Lorian",
    "role": "Member",
    "profile_image":
        "https://cdn.vox-cdn.com/thumbor/KEKGNFGnAJYBVK5uJCbCpf664Q4=/0x0:3840x1610/1200x800/filters:focal(1613x498:2227x1112)/cdn.vox-cdn.com/uploads/chorus_image/image/68549230/huc2_ff_003159_4661a2c0.0.jpeg",
    "joined": "Nov 28 2020",
    "followers": 14,
    "following": 1,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Mckenzie Davis",
    "role": "Member",
    "profile_image":
        "https://variety.com/wp-content/uploads/2018/03/mackenzie-davis.jpg?w=681&h=383&crop=1",
    "joined": "Nov 28 2020",
    "followers": 389,
    "following": 244,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
  },
  {
    "username": "Sleepy Samurai",
    "role": "Member",
    "profile_image":
        "https://www.sideshow.com/wp/wp-content/uploads/2019/12/Cyberpunk-Keanu.jpg",
    "joined": "Nov 28 2020",
    "followers": 10,
    "following": 200,
    "email": "Jane@outlook.com",
    "subscribed_groups": [
      "The Fallen Order",
      "Band of Bastards",
      "The add ons",
      "Awesome People",
      "Top Secret Crew"
    ],
    "online": true
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

Map sectionStringMap = {
  sections.announcements: "Announcements",
  sections.membersPreview: "Members Preview",
  sections.upcoming: "Upcoming",
  sections.contactUs: "Contact Us",
  sections.forumPosts: "Forum Posts",
  sections.members: "Members",
  sections.groupsList: "Groups List"
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
  titleColor,
  tagLine,
  tagLineColor,
  placeLogo,
  memberPreview,
  inviteButton,
  customButton,
  layout,
  blurEffect,
  logoShape,
  logoRadius,
  backgroundStyle,
  shadowHeight, //0.0 will represent no shadow,
  tabBarColor,
  appBarColor,
  backgroundGradient,
  fullscreenMode,
  diagonalBarColor,
  diagonalBarShadow,
  diagonalBarShadowBlurRadius,
  diagonalBarShadowLift,
  diagonalMaxOpacity,
  landingPageMode,
  topLeftBar,
  topRightBar,
  bottomLeftBar,
  bottomRightBar
}

enum backgroundStyles {
  diagonalLine,
  image,
  imageDiagonalLine,
  solid,
  solidDiagonalLine,
  gradient,
  gradientDiagonalLine,
  video,
  videoDiagonalLine,
  animated,
  animatedDiagonalLine
}

enum landingPageMode {
  active,
  background,
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

//background gradient starting colors
const Color gradientColor1 = primaryColor;
const Color gradientColor2 = secondaryColor;

enum GradientOrientations {
  horizontal,
  vertical,
  diagonal,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight,
  radial
}

const GradientOrientations gradientOrientation = GradientOrientations.diagonal;

Gradient getGradient(
    {Color gradientFirstColor = gradientColor1,
    Color gradientSecondColor = gradientColor2,
    Color gradientThirdColor,
    GradientOrientations gradientOrientation = gradientOrientation}) {
  List<Color> colorsList = [gradientFirstColor, gradientSecondColor];
  List<double> gradientStops = null;
  if (null != gradientThirdColor) {
    colorsList = [
      gradientFirstColor,
      gradientSecondColor,
      gradientSecondColor,
      gradientThirdColor
    ];

    gradientStops = [
      0.00,
      0.45,
      0.55,
      1.0,
    ];
  }

  Gradient gradient = LinearGradient(
      //maybe in future versions you can have an advanced tool for users to create gradients
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: gradientStops,
      colors: colorsList);

  switch (gradientOrientation) {
    case GradientOrientations.vertical:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.topLeft:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.topRight:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.bottomLeft:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.bottomRight:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.radial:
      gradient = RadialGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients

          stops: gradientStops,
          colors: colorsList);
      break;

    default:
  }

  return gradient;
}

//This is immutable and should only be written to when settings are changed by user
/*Maybe defined getters and setters for this to make life easier  - refactor later on*/
Map contentLayouts = {
  "header": {
    headerOptions.fullscreenMode: false,
    headerOptions.titleColor: Colors.white,
    headerOptions.tagLine: true,
    headerOptions.tagLineColor: Colors.white,
    headerOptions.placeLogo: true,
    headerOptions.memberPreview: true,
    headerOptions.inviteButton: true,
    headerOptions.customButton: true,
    headerOptions.layout:
        "default", //idea is to have different layouts, like picture on the left, all centered, etc.
    headerOptions.blurEffect: false,

    headerOptions.logoShape: logoShape.circle,
    headerOptions.logoRadius: 4.0,
    headerOptions.backgroundStyle: backgroundStyles.gradient,
    headerOptions.backgroundGradient: LinearGradient(
      //maybe in future versions you can have an advanced tool for users to create gradients
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        gradientColor1,
        gradientColor2,
      ],
    ),
    headerOptions.shadowHeight: 0.0, //default should be 4.0
    headerOptions.appBarColor: primaryColor,
    headerOptions.tabBarColor: primaryColor,
    headerOptions.diagonalBarColor: primaryColor,
    headerOptions.diagonalBarShadow: true,
    headerOptions.diagonalBarShadowBlurRadius: 15.0,
    headerOptions.diagonalBarShadowLift: 0.75,
    headerOptions.diagonalMaxOpacity: 1.0,
    headerOptions.topLeftBar: false,
    headerOptions.topRightBar: true,
    headerOptions.bottomLeftBar: false,
    headerOptions.bottomRightBar: false,
    headerOptions.landingPageMode: {landingPageMode.active: true}
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

//modalBottomSheet blur settings
bool modalBottomSheetBlur = true;
double mbsSigmaX = 7.0;
double mbsSigmaY = 7.0;

//custom scroll settings
enum CTS {
  tabBackgroundImage,
  appBarBackgroundImage,
  dynamicDiagnonalBar,
}

//only active when headerOptions.backgroundStyle is a diagonal style
Map customTabScrollSettings = {
  CTS.tabBackgroundImage:
      false, //should tabbar be solid(false) or show background image (true)
  CTS.appBarBackgroundImage:
      false, //should appbar be solid(false) or show background image(true) -- overrides dynamic diagonal bar if true
  CTS.dynamicDiagnonalBar:
      false //should diagonal effect fade in (true) or be consistent (false)
};

//function holder for home header build functions
Map<String, Function> headerBuilders = {};

//for toggling main navbar visiblity
Function toggleNavBar = () {};
bool persistentNavBar = false; //whether bottom navbar is always visible?
