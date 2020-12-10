import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';

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

//build the home widget Map
List<Widget> buildHomeTab(
    Function setState, BuildContext context, Map sharedStateManagement) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  /*Decided to have each element as an individual item in the list. As opposed to having some nested.
    This is so that it will be easier to add and remove items from the list on the fly. */
  List<Widget> widgets = <Widget>[
    Padding(
      padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 0.0, right: 0.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Announcements',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                Text(
                  'See All',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeLinkTextStyle,
                )
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: announcements.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(
                    top: 0.0, left: 0.0, right: 0.0, bottom: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: avatarWidth,
                              height: avatarHeight,
                              margin:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(avatarRadius)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://randomuser.me/api/portraits/women/69.jpg"),
                                  ))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(announcements[index]['user'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      homeTextStyleBold), //set a global style to be shared
                              SizedBox(
                                  height:
                                      5), //sized box to create space between
                              Text(announcements[index]['date'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: homeSubTextStyle),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                        child: new Text(announcements[index]['body'],
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            style: homeTextStyle),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 0.0, right: 0.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Members',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MemberSearchScreen()));
                  },
                  child: Text(
                    'See All',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: homeLinkTextStyle,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MemberSearchScreen()));
                  },
                  child: Container(
                    height: avatarHeight + 4,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          if (4 == index) {
                            //return container with overlay
                            return Stack(children: [
                              Container(
                                  width: avatarWidth,
                                  height: avatarHeight,
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 5),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(avatarRadius)),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            membersShortlist[index]
                                                ["profile_image"]),
                                      ))),
                              Container(
                                  width: avatarWidth,
                                  height: avatarHeight,
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 5),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(avatarRadius)),
                                      color:
                                          new Color.fromRGBO(255, 0, 0, 0.5)),
                                  child: Center(
                                      child: Text(
                                    "+86",
                                    style: homeTextStyleBoldWhite,
                                  ))),
                            ]);
                          } else {
                            return Container(
                                width: avatarWidth,
                                height: avatarHeight,
                                margin:
                                    const EdgeInsets.only(right: 10, bottom: 5),
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(avatarRadius)),
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          membersShortlist[index]
                                              ["profile_image"]),
                                    )));
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 10.0),
                  child: new Text(
                      "90 members including " +
                          membersShortlist[0]["username"] +
                          ", " +
                          membersShortlist[1]["username"] +
                          " and " +
                          membersShortlist[2]["username"],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                ),
                RaisedButton(
                  elevation: 0.0,
                  onPressed: () {
                    List options = [
                      {
                        "iconData": Icons.chat_bubble_outline,
                        "title": "Send an SMS",
                        "onPressed": () {
                          print("****************callback function1 called");
                        }
                      },
                      {
                        "iconData": Icons.share,
                        "title": "Share via social and more",
                        "onPressed": () {
                          print("****************callback function2 called");
                        }
                      },
                      {
                        "iconData": Icons.link,
                        "title": "Copy link",
                        "onPressed": () {
                          print("****************callback function3 called");
                        }
                      }
                    ];

                    Map params = {
                      "context": context,
                      "title": "Invite Members",
                      "description":
                          "Invite people to join your space on the app",
                      "options": options
                    };

                    sharedStateManagement['display_navigation_drawer'](params);
                  },
                  padding: EdgeInsets.only(
                      top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.red,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'Invite Members',
                    overflow: TextOverflow.visible,
                    style: homeLinkTextStyle,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 0.0, right: 0.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeSubtitleTextStyle,
                ),
                Text(
                  'View Calendar',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: homeLinkTextStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
            child: new Text("Nothing upcoming",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: homeSubTextStyle),
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(
          left: sidePadding, right: sidePadding, bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, right: 0.0, bottom: 10.0),
            child: Text(
              'Contact Us',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: homeSubtitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
            child: Text(
                "This is a great place to tell members about who you are, what you do and what you can offer them.",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: homeTextStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Get in Touch",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                  Text("Test community",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeSubTextStyle)
                ],
              ),
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  print('invite Button Pressed');
                },
                padding: EdgeInsets.only(
                    top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'Message',
                  overflow: TextOverflow.visible,
                  style: homeLinkTextStyle,
                ),
              )
            ],
          ),
          Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("610QEB",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeTextStyle),
                  Text("Invite Code",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: homeSubTextStyle)
                ],
              ),
              RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  print('invite Button Pressed');
                },
                padding: EdgeInsets.only(
                    top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: iconColor,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
              )
            ],
          )
        ],
      ),
    )
  ];

  return widgets;
}
