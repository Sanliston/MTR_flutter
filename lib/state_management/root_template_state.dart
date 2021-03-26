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
    'title': 'What does this term mean?',
    'date': '5 months ago',
    'body':
        'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
    'likes': 10,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
  {
    'user': 'Jane',
    'title': 'Hello World',
    'date': '1 year ago',
    'body': 'What makes you happy?',
    'likes': 246,
    'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
  },
  {
    'user': 'Jane',
    'title': 'Help',
    'date': '20/10/16',
    'body': 'I need advice',
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
      'post_title': 'I\'m happy I made it here'
    }
  },
  {
    'name': 'Band of Good fellows',
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

//darkMode toggle
bool darkMode = false;

//core colors

//good green combo
// Color primaryColor = Color(0xFF56ab2f);
// Color secondaryColor = Color(0xFFa8e063);

//good pink combo
// Color primaryColor = Color(0xFFec008c);
// Color secondaryColor = Color(0xFFfc6767);

// //good purple combo
// Color primaryColor = Color(0xFF8360c3);
// Color secondaryColor = Color(0xFF2ebf91);

//good blue combo
Color primaryColor = Color(0xFF0082c8);
Color secondaryColor = Color(0xFF667db6);

//good orange combo (good for non shadow clean look)
// Color primaryColor = Color(0xFFff5e62);
// Color secondaryColor = Color(0xFFff9966);

//good orange for no shadow style
// Color primaryColor = Color(0xFFD66D75);
// Color secondaryColor = Color(0xFFE29587);

//good purple combo
// Color primaryColor = Color(0xFF9D50BB);
// Color secondaryColor = Color(0xFF6E48AA);

//MTR default colors
// Color primaryColor = Color(0xFFCB356B);
// Color secondaryColor = Color(0xFFBD3F32);

Color accentColor = primaryColor;
Color iconColor = primaryColor;
Color darkNight = darkMode ? Color(0xFF232931) : Color(0xFF263238);

//base background color to be used by main body
Color bodyBackground = darkMode ? darkNight : Colors.white;
Color itemBackground = darkMode ? Color(0xFF393e46) : Colors.white;
Color bodyFontColor = darkMode ? dFontColor : fontColor;

//default background Image
String defaultBackgroundImage;

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
  "Forum",
  "Groups",
  "Members",
  "Events",
  "Services",
  "Pricing",
  "Content"
];

// List<String> homeAdminTabList = <String>[
//   "Home",
//   "Forum",
//   "Groups",
//   "Members",
//   "AddTabButton"
// ];

//decided to use string values in the map, as these can be
//added during runtime allowing for the creation of custom
//tabs with custom layouts
//NOTE: tab names here have to match those in homeTabList (excluding header and default)
enum headerOptions {
  titleColor,
  titleText,
  titleFontSize,
  headerFontColor,
  toolBarIconColor,
  tagLine,
  tagLineText,
  tagLineColor,
  placeLogo,
  memberPreview,
  inviteButton,
  inviteButtonColor,
  inviteButtonTextColor,
  customButton,
  customButtonColor,
  customButtonTextColor,
  customButtonText,
  layout,
  blurEffect,
  blurredAppBar,
  logoShape,
  logoRadius,
  solidBackgroundColor,
  backgroundStyle,
  shadowHeight, //0.0 will represent no shadow,
  tabBarColor,
  appBarColor,
  backgroundGradient,
  fullscreenMode,
  diagonalBarColor,
  diagonalBarShadow,
  diagonalBarShadowColor,
  diagonalBarShadowBlurRadius,
  diagonalBarShadowLift,
  diagonalMaxOpacity,
  landingPageMode,
  topLeftBar,
  topRightBar,
  bottomLeftBar,
  bottomRightBar,
  topLeftBarColor,
  topRightBarColor,
  bottomLeftBarColor,
  bottomRightBarColor
}

/*TODO - 
remove non diagonal settings, as going forward all backgrounds will be diagonal 
They will be differentiated by how many diagonal bars are active,
this will also allow the auto scroll to work with any background

*/
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
Color gradientColor1 = primaryColor;
Color gradientColor2 = secondaryColor;
Color gradientColor3 = accentColor;
bool gradientColor3Active = false;

enum GradientOrientations {
  horizontal,
  vertical,
  reverseVertical,
  diagonal,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight,
  radial,
  nav,
  navFade,
  blurFade
}

GradientOrientations currentGradientOrientation = GradientOrientations.diagonal;

Gradient getGradient(
    {Color gradientFirstColor,
    Color gradientSecondColor,
    Color gradientThirdColor,
    GradientOrientations gradientOrientation,
    double angle}) {
  print("in getGradient first color: $gradientFirstColor");
  gradientFirstColor =
      null != gradientFirstColor ? gradientFirstColor : gradientColor1;
  gradientSecondColor =
      null != gradientSecondColor ? gradientSecondColor : gradientColor2;
  gradientOrientation = null != gradientOrientation
      ? gradientOrientation
      : currentGradientOrientation;

  print("get gradient called, orientation: $gradientOrientation");

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

    case GradientOrientations.reverseVertical:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.navFade:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [
            0.00,
            0.20,
            0.75,
            1.0,
          ],
          colors: colorsList = [
            gradientFirstColor,
            gradientFirstColor,
            gradientSecondColor,
            gradientThirdColor
          ]);
      break;

    case GradientOrientations.diagonal:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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

    case GradientOrientations.nav:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          stops: gradientStops,
          colors: colorsList);
      break;

    case GradientOrientations.blurFade:
      gradient = LinearGradient(
          //maybe in future versions you can have an advanced tool for users to create gradients
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            0.0,
            0.4,
            0.6,
            1.0,
          ],
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
    headerOptions.fullscreenMode: false, // deprecated, use landingPageMode
    headerOptions.titleColor: Colors.white,
    headerOptions.titleText: "More Than Rubies",
    headerOptions.titleFontSize: 30,
    headerOptions.headerFontColor: Colors.grey[100],
    headerOptions.toolBarIconColor: Colors.white,
    headerOptions.blurredAppBar: true,
    headerOptions.tagLine: true,
    headerOptions.tagLineText: "App coming soon.",
    headerOptions.tagLineColor: Colors.white,
    headerOptions.placeLogo: true,
    headerOptions.memberPreview: true,
    headerOptions.inviteButton: true,
    headerOptions.inviteButtonColor: Colors.white,
    headerOptions.inviteButtonTextColor: Colors.white,
    headerOptions.customButton: true,
    headerOptions.customButtonColor: Colors.white,
    headerOptions.customButtonTextColor: Colors.white,
    headerOptions.customButtonText: "custom",

    headerOptions.layout:
        "default", //idea is to have different layouts, like picture on the left, all centered, etc.
    headerOptions.blurEffect: false,

    headerOptions.logoShape: logoShape.square,
    headerOptions.logoRadius: 10.0,
    headerOptions.solidBackgroundColor: primaryColor,
    headerOptions.backgroundStyle: backgroundStyles.video,
    headerOptions.backgroundGradient: LinearGradient(
      //selected by function not manually -- code here is placeholder
      //maybe in future versions you can have an advanced tool for users to create gradients [done]
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
    headerOptions.diagonalBarShadowColor: Colors.black54,
    headerOptions.diagonalBarShadowBlurRadius: 15.0,
    headerOptions.diagonalBarShadowLift: 0.75,
    headerOptions.diagonalMaxOpacity: 1.0,
    headerOptions.topLeftBar: false,
    headerOptions.topRightBar: true,
    headerOptions.bottomLeftBar: false,
    headerOptions.bottomRightBar: false,
    headerOptions.topLeftBarColor: primaryColor,
    headerOptions.topRightBarColor: primaryColor,
    headerOptions.bottomLeftBarColor: primaryColor,
    headerOptions.bottomRightBarColor: primaryColor,
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
  "Members": [
    sections.membersPreview,
    sections.members,
    sections.forumPosts,
    sections.contactUs,
    sections.announcements
  ],
  "Events": [sections.announcements],
  "Services": [sections.announcements],
  "Pricing": [sections.announcements],
  "Content": [
    sections.announcements,
    sections.membersPreview,
    sections.upcoming,
    sections.upcoming
  ]
};

Map headerSettings = contentLayouts['header'];

//decided to start handling settings outside of the Map above, which tbh is a monstrosity

enum TabBarStyle {
  halfRound,
  fullRound,
  traditional,
  bubble,
  square,
  dot,
  hoverLine,
  inverseHalfRound,
  border,
  unicornBorder,
  gradientBubble,
  gradientSquare,
}

//These are the expanded tabbar , i.e default
TabBarStyle selectedTabBarStyle = TabBarStyle.bubble;
TabBarStyle unselectedTabBarStyle = TabBarStyle
    .traditional; //this will just overlap under the selected style -- doesnt disappear
Color selectedTabBarColor = primaryColor;
Color unselectedTabBarColor = primaryColor;
Color tabBarSelectedFontColor = Colors.white;
Color tabBarUnselectedFontColor = Colors.black38;
Color tabBarGlowColor = primaryColor;
bool tabBarBlurGlow = false;
bool tabBarLabelGlow = false;
bool tabBarBlurHue = false;
bool tabBarSolidAppBar = true;
Color tabBarBlurOverlayColor =
    darkMode ? Colors.black38 : Colors.grey[300].withOpacity(0.4);
double tabBarBlurOverlayOpacity = 0.4;
double tabBarBlurSigma =
    15.0; //the AppBarStyle and ToolBarStyle are best when this is 0.0
/*If the tabBarBlurSigma is more than zero then the whole Appbar and toolbar will
background will be blurred

Thus the AppBar and ToolBar styles will only work if headerOptions.blurredAppBar: true
Otherwise they'll have solid background.

To activate traditional background blur. set AppBarStyle and ToolBarStyle to material
 */

//these are the collapsed tabbar styles
TabBarStyle cSelectedTabBarStyle = TabBarStyle.bubble;
TabBarStyle cUnselectedTabBarStyle = TabBarStyle
    .bubble; //this will just overlap under the selected style -- doesnt disappear
Color cSelectedTabBarColor = Colors.white;
Color cUnselectedTabBarColor = primaryColor;
Color cTabBarSelectedFontColor = primaryColor;
Color cTabBarUnselectedFontColor = Colors.white;
Color cTabBarGlowColor = primaryColor;

Color toolBarExpandedFontColor = primaryColor.withOpacity(0.1);
Color toolBarFontColor = Colors.white;

bool collapsableToolBar =
    false; //if true also collapses toolbar when user scrolls up

bool hideTabBarWhenScroll = false;

enum AppBarStyle {
  //style for the top part that contains the title and icons when collapsed
  material,
  materialFrosted,
  rounded, //works but needs more fixing
  roundedTop,
  roundedBottom,
  roundedLeft,
  roundedRight,
  rectangle,
  halfTop //to be used only with ToolBarStyle halfTop
}
enum ToolBarStyle {
  //style for the part that contains the tab bar
  material,
  traditional,
  rounded,
  roundedFrosted,
  rectangle,
  halfTop, //looks funny with trailing tab icons
}

AppBarStyle appBarStyle = AppBarStyle.material;
ToolBarStyle toolBarStyle = ToolBarStyle.material;

AppBarStyle cAppBarStyle =
    AppBarStyle.halfTop; //not implemented -- probably will not be
ToolBarStyle cToolBarStyle = ToolBarStyle.material; //implemented

CollapseMode appBarCollapseMode = CollapseMode.parallax;

double appBarTitleFontSize = 24.0 * sizeFactor;

enum BodyStyle {
  auto, //hands over control to toolBarStyle
  material,
  halfTop, //not to be necessarily used with the toolbar & appbar half top styles, but works well

}

BodyStyle bodyStyle = BodyStyle.material;
Color halfTopColor =
    primaryColor; //Color of the tab and the body back background behind the radius
double halfTopRadius = 25;
BorderRadius halfTopBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(halfTopRadius),
    topRight: Radius.circular(halfTopRadius));
bool halfTopBodyShadow = false;
Color halfTopBodyShadowColor = Colors.black45;
bool halfTopInnerBodyShadow = false;
Color halfTopInnerBodyShadowColor = Colors.black26;
bool bodyHalfTopFixed = false;

//app bar expanded icons color - icons at top, back button + notifications button
Color toolBarExpandedIconsColor = Colors.transparent;

//modalBottomSheet blur settings
bool modalBottomSheetBlur = true;
double mbsSigmaX = 7.0;
double mbsSigmaY = 7.0;

//bottom Nav Bar Blur sigma
double bottomNavSigma = 15.0;

//custom scroll settings
enum CTS {
  tabBackgroundImage,
  appBarBackgroundImage,
  dynamicDiagnonalBar,
}

//only active when headerOptions.backgroundStyle is a diagonal style
Map customTabScrollSettings = {
  //needs to be false for blurred tabbar to work
  CTS.tabBackgroundImage:
      false, //should tabbar be solid(false) or show background image (true)
  CTS.appBarBackgroundImage:
      false, //should appbar be solid(false) or show background image(true) -- overrides dynamic diagonal and also covers tabbar bar if true
  CTS.dynamicDiagnonalBar:
      false //should diagonal effect fade in (true) or be consistent (false)
};

//function holder for home header build functions
Map<String, Function> headerBuilders = {};

//for toggling main navbar visiblity
Function toggleNavBar = () {};
bool persistentNavBar = true; //whether bottom navbar is always visible?
bool blurredNavBar = true;

//for toggling appToolBarIconColors
Function toggleTBIconColors = () {};
Function toggleHomeTabBar = () {};

//Homestate object containing values

//trailing elements in the tab bar
bool leadingTabButton = true;
IconData leadingTabButtonIcon = UniconsLine.cell;
Function leadingTabButtonAction = () {
  print("action clicked");
};
Function customTabScrollUpdate = () {};

//Images high res and low res for memory management

List<Map> homeBackgroundImageList = [
  {"data": "assets/images/home_background.jpg", "type": "asset"},
  {"data": "assets/images/home_background_2.jpg", "type": "asset"},
  {"data": "assets/images/home_background_3.jpg", "type": "asset"},
];
Map homeBackgroundImage = {
  "data": "assets/images/home_background.jpg",
  "type": "asset"
};

Map homePlaceImage = {
  "data": "assets/images/profile_images/default_user.png",
  "type": "asset"
};

//home tab controller juggling
Function updateTabController;
Function updatePreviewTabController;

//home header text blur background

//home header values changed during runtime
enum HOMETABRT {
  screenHeight,
  headerHeight,
  heightFactor,
  minimumHeight,
  maximumheight
}

Map runtimeHome = {
  HOMETABRT.screenHeight: 844,
  HOMETABRT.headerHeight: 350,
  HOMETABRT.heightFactor: 0.5,
  HOMETABRT.minimumHeight: 340,
  HOMETABRT.maximumheight: 350
};
