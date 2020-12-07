import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';

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

Widget buildMemberInfo(int index) {
  Widget role = new Container(
    height: 0.0,
    width: 0.0,
  );

  if (null != membersList[index]['role']) {
    role = Text(membersList[index]['role'],
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: homeSubTextStyle);
  }

  Widget widget = new Padding(
    padding:
        const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: avatarWidth,
                height: avatarHeight,
                margin: const EdgeInsets.only(right: 15, bottom: 5),
                decoration: new BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(avatarRadius)),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(membersList[index]['profile_image']),
                    ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(membersList[index]['username'],
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style:
                        forumTextStyleBold), //set a global style to be shared
                SizedBox(height: 5),
                role //sized box to create space between
              ],
            )
          ],
        ),
      ],
    ),
  );

  return widget;
}

List<Widget> buildMembersTab() {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */

  List<Widget> widgets = <Widget>[
    /*This item is a button that looks like a search field, but when clicked will take the 
      user a new page which allows them to search for members. This will happen seamlessly to
      make it look like the user is still on the same page*/
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FlatButton(
          onPressed: () {
            print('search button pressed');
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 0.0, right: 0.0, bottom: 10.0),
            child: SizedBox(
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.search,
                          color: iconColor,
                        ),
                      ),
                      Text(
                        'Search ' + membersList.length.toString() + ' Members',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: homeTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(thickness: 1),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: membersList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Color dividerColor = Colors.white;
            if (0 < index) {
              dividerColor = Colors.grey[100];
            }

            print("Dividerthickness: $dividerColor");
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Divider(
                    color: dividerColor,
                    thickness: 1.0,
                  ),
                  buildMemberInfo(index)
                ],
              ),
            );
          },
        )
      ],
    ),
  ];

  return widgets;
}
