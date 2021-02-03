import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

class ForumPostsSection extends StatefulWidget {
  List forumPosts;
  ForumPostsSection({Key key, @required this.forumPosts}) : super(key: key);

  @override
  _ForumPostsSectionState createState() =>
      _ForumPostsSectionState(forumPosts: this.forumPosts);
}

class _ForumPostsSectionState extends State<ForumPostsSection>
    with TickerProviderStateMixin {
  /*
For the animation of the list i used this for reference:
https://medium.com/flutter-community/how-to-animate-items-in-list-using-animatedlist-in-flutter-9b1a64e9aa16 

Solved the janky animation issue by combining 2 animations together
*/

  //create your own animation key
  GlobalKey<AnimatedListState> forumPostKey;

  List forumPosts;
  _ForumPostsSectionState({@required this.forumPosts});

  void displayShareMenu(BuildContext context) {
    List options = [
      {
        "title": "Share to read on the app",
        "type": "subtitle",
      },
      {
        "iconData": EvaIcons.messageCircleOutline,
        "title": "Send an SMS",
        "onPressed": () {
          print("****************callback function1 called");
        }
      },
      {
        "iconData": EvaIcons.cloudUploadOutline,
        "title": "Share via social and more",
        "onPressed": () {
          print("****************callback function2 called");
        }
      },
      {
        "iconData": EvaIcons.linkOutline,
        "title": "Copy link",
        "onPressed": () {
          print("****************callback function3 called");
        }
      },
      {"title": "Share web URL", "type": "subtitle"},
      {
        "iconData": EvaIcons.globeOutline,
        "title": "Share post URL",
        "onPressed": () {
          print("****************callback function2 called");
        }
      },
    ];

    Map params = {
      "context": context,
      "description": "Share This Post",
      "options": options
    };

    displayNavigationDrawer(context, params);
  }

  void _onNewPost() {
    print("adding new post");
    Map newPost = {
      'user': 'New Post yooo',
      'title': 'Flocka Bitches',
      'date': '5 months ago',
      'body':
          'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
      'likes': 10,
      'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
    };
    setState(() {
      forumPosts.add(newPost);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    forumPostKey = new GlobalKey<AnimatedListState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,
                  left: sidePadding,
                  right: sidePadding,
                  bottom: 5.0),
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
                          'title': 'Hello this is a new post',
                          'date': '5 months ago',
                          'body':
                              'Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc manLorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man Lorem ipsum etc man',
                          'likes': 10,
                          'comments': {'1': {}, '2': {}, '3': {}, '4': {}}
                        };
                        sharedStateManagement['hometabscreen_setstate'](() {
                          forumPosts.insert(0, newPost);
                        });

                        forumPostKey.currentState.insertItem(0,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(
                              EvaIcons.plusCircleOutline,
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
                              left: BorderSide(
                                  color: Colors.black12, width: 1.0))),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          EvaIcons.searchOutline,
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
          color: darkMode ? bodyBackground : Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: AnimatedList(
              key: forumPostKey,
              initialItemCount: forumPosts.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                Color dividerColor = itemBackground;
                if (0 < index) {
                  dividerColor = darkMode ? bodyBackground : Colors.grey[100];
                }

                return SizeTransition(
                  sizeFactor: animation.drive(CurveTween(
                      curve: Interval(0.0, 0.7, curve: Curves.easeIn))),
                  child: FadeTransition(
                    opacity: animation.drive(CurveTween(
                        curve: Interval(0.7, 1.0, curve: Curves.ease))),
                    child: SlideTransition(
                      position: animation.drive(Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      )),
                      child: Container(
                        color: itemBackground,
                        child: Column(
                          children: [
                            Divider(
                              color: dividerColor,
                              thickness: 2.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      homeSubTextStyleBold), //set a global style to be shared
                                              SizedBox(
                                                  height:
                                                      5), //sized box to create space between
                                              Text(forumPosts[index]['date'],
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              "iconData": EvaIcons.shareOutline,
                                              "onPressed": () {
                                                Navigator.pop(context);
                                                displayShareMenu(context);
                                              }
                                            },
                                            {
                                              "title": "Unfollow",
                                              "iconData":
                                                  EvaIcons.personRemoveOutline,
                                              "onPressed": () {
                                                print(
                                                    "****************callback function2 called");
                                              }
                                            },
                                            {
                                              "title": "Copy Text",
                                              "iconData": EvaIcons.copyOutline,
                                              "onPressed": () {
                                                print(
                                                    "****************callback function3 called");
                                              }
                                            },
                                            {
                                              "title": "Edit Post",
                                              "iconData": EvaIcons.editOutline,
                                              "onPressed": () {
                                                print(
                                                    "****************callback function2 called");
                                              }
                                            },
                                            {
                                              "title": "Pin",
                                              "iconData": EvaIcons.pinOutline,
                                              "onPressed": () {
                                                print(
                                                    "****************callback function3 called");
                                              }
                                            },
                                            {
                                              "title": "Close Comments",
                                              "iconData":
                                                  EvaIcons.closeCircleOutline,
                                              "onPressed": () {
                                                print(
                                                    "****************callback function2 called");
                                              }
                                            },
                                            {
                                              "title": "Delete",
                                              "iconData": EvaIcons.trashOutline,
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

                                          displayNavigationDrawer(
                                              context, params);
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
                                              Container(
                                                width: 35.0,
                                                child: IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  icon: Icon(
                                                    EvaIcons.heartOutline,
                                                    color: bodyFontColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  onPressed: () {
                                                    // do something
                                                  },
                                                ),
                                              ),
                                              new Text(
                                                  forumPosts[index]['likes']
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: forumInteractionsStyle)
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 35.0,
                                                  child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    icon: Icon(
                                                      UniconsLine.comment,
                                                      color: bodyFontColor
                                                          .withOpacity(0.3),
                                                    ),
                                                    onPressed: () {
                                                      // do something
                                                    },
                                                  ),
                                                ),
                                                new Text(
                                                    forumPosts[index]
                                                            ['comments']
                                                        .length
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style:
                                                        forumInteractionsStyle)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          UniconsLine.upload,
                                          color: Colors.black26,
                                        ),
                                        onPressed: () {
                                          displayShareMenu(context);
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
        ),
      ],
    );
  }
}
