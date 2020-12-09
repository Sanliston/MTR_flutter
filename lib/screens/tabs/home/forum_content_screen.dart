import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';

/*
For the animation of the list i used this for reference:
https://medium.com/flutter-community/how-to-animate-items-in-list-using-animatedlist-in-flutter-9b1a64e9aa16 

Solved the janky animation issue by combining 2 animations together
*/

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

//reverse the list

List<Widget> buildForumTab(
    Function setState, BuildContext context, Map sharedStateManagement) {
  /*List will hold certain information:
    number of entries in List
    List of widgets in order of how they will be displayed */
  List<Widget> widgets = <Widget>[
    //this container may need to be built as it will most likely contain dynamic elements
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 15.0, left: sidePadding, right: sidePadding, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'General Discussions',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: homeSubtitleTextStyle,
              ),
              Text(
                'Following',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: homeLinkTextStyle,
              )
            ],
          ),
        ),
        Divider(thickness: 1),
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, left: 0.0, right: 0.0, bottom: 10.0),
          child: SizedBox(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    print(
                        "##########################################adding new post using setState");
                    Map newPost = {
                      'user': 'New Post 3',
                      'title': 'Flocka Bitches',
                      'date': '5 months ago',
                      'body':
                          'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
                      'likes': 10,
                      'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
                    };
                    setState(() {
                      forumPosts.insert(0, newPost);
                    });

                    sharedStateManagement['forum_post_key']
                        .currentState
                        .insertItem(0,
                            duration: const Duration(milliseconds: 500));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: iconColor,
                        ),
                      ),
                      Text(
                        'Create New Post',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: homeSubtitleTextStyle,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.black12, width: 1.0))),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.search,
                      color: iconColor,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
    Container(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
        child: AnimatedList(
          key: sharedStateManagement['forum_post_key'],
          initialItemCount: forumPosts.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index, Animation animation) {
            Color dividerColor = Colors.white;
            if (0 < index) {
              dividerColor = Colors.grey[100];
            }

            print("Dividerthickness: $dividerColor");
            return SizeTransition(
              sizeFactor: animation.drive(
                  CurveTween(curve: Interval(0.0, 0.7, curve: Curves.easeIn))),
              child: FadeTransition(
                opacity: animation.drive(
                    CurveTween(curve: Interval(0.7, 1.0, curve: Curves.ease))),
                child: SlideTransition(
                  position: animation.drive(Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  )),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(
                          color: dividerColor,
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: avatarWidth,
                                          height: avatarHeight,
                                          margin: const EdgeInsets.only(
                                              right: 15, bottom: 5),
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      avatarRadius)),
                                              image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://randomuser.me/api/portraits/women/69.jpg"),
                                              ))),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(forumPosts[index]['user'],
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  forumTextStyleBold), //set a global style to be shared
                                          SizedBox(
                                              height:
                                                  5), //sized box to create space between
                                          Text(forumPosts[index]['date'],
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: homeSubTextStyle),
                                        ],
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: iconColor,
                                    ),
                                    onPressed: () {
                                      List options = [
                                        {
                                          "title": "Share",
                                          "onPressed": () {
                                            print(
                                                "****************callback function1 called");
                                          }
                                        },
                                        {
                                          "title": "Unfollow",
                                          "onPressed": () {
                                            print(
                                                "****************callback function2 called");
                                          }
                                        },
                                        {
                                          "title": "Copy Text",
                                          "onPressed": () {
                                            print(
                                                "****************callback function3 called");
                                          }
                                        },
                                        {
                                          "title": "Edit Post",
                                          "onPressed": () {
                                            print(
                                                "****************callback function2 called");
                                          }
                                        },
                                        {
                                          "title": "Pin",
                                          "onPressed": () {
                                            print(
                                                "****************callback function3 called");
                                          }
                                        },
                                        {
                                          "title": "Close Comments",
                                          "onPressed": () {
                                            print(
                                                "****************callback function2 called");
                                          }
                                        },
                                        {
                                          "title": "Delete",
                                          "onPressed": () {
                                            print(
                                                "****************callback function3 called");
                                          }
                                        }
                                      ];

                                      Map params = {
                                        "context": context,
                                        "title": "Post Options",
                                        "options": options
                                      };

                                      sharedStateManagement[
                                          'display_navigation_drawer'](params);
                                      // do something
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 0.0),
                                child: new Text(forumPosts[index]['title'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: homeSubtitleTextStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 5.0),
                                child: new Text(forumPosts[index]['body'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: homeTextStyle),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.all(0),
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.black26,
                                            ),
                                            onPressed: () {
                                              // do something
                                            },
                                          ),
                                          new Text(
                                              forumPosts[index]['likes']
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.visible,
                                              style: forumInteractionsStyle)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.all(0),
                                            icon: Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.black26,
                                            ),
                                            onPressed: () {
                                              // do something
                                            },
                                          ),
                                          new Text(
                                              forumPosts[index]['comments']
                                                  .length
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.visible,
                                              style: forumInteractionsStyle)
                                        ],
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.black26,
                                    ),
                                    onPressed: () {
                                      List options = [
                                        {
                                          "title": "Share to read on the app",
                                          "type": "subtitle",
                                        },
                                        {
                                          "iconData": Icons.chat_bubble_outline,
                                          "title": "Send an SMS",
                                          "onPressed": () {
                                            print(
                                                "****************callback function1 called");
                                          }
                                        },
                                        {
                                          "iconData": Icons.share,
                                          "title": "Share via social and more",
                                          "onPressed": () {
                                            print(
                                                "****************callback function2 called");
                                          }
                                        },
                                        {
                                          "iconData": Icons.link,
                                          "title": "Copy link",
                                          "onPressed": () {
                                            print(
                                                "****************callback function3 called");
                                          }
                                        },
                                        {
                                          "title": "Share web URL",
                                          "type": "subtitle"
                                        },
                                        {
                                          "iconData": Icons.linear_scale,
                                          "title": "Share post URL",
                                          "onPressed": () {
                                            print(
                                                "****************callback function2 called");
                                          }
                                        },
                                      ];

                                      Map params = {
                                        "context": context,
                                        "description": "Share This Post",
                                        "options": options
                                      };

                                      sharedStateManagement[
                                          'display_navigation_drawer'](params);
                                      // do something
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    )
  ];

  return widgets;
}
