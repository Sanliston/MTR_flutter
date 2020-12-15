import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/home_state.dart';

class GroupsListSection extends StatelessWidget {
  const GroupsListSection({
    Key key,
  }) : super(key: key);

  Widget _buildGroupDivider(int index) {
    Widget widget = new Container();
    var recentActivity = groupsList[index]['recent_activity'];

    if (null != recentActivity) {
      widget = new Divider(
        color: Colors.grey[100],
        thickness: 2.0,
      );
    }

    return widget;
  }

  Widget _buildGroupRecents(int index) {
    Widget widget = new Container();
    var recentActivity = groupsList[index]['recent_activity'];

    var groupsListIndexName = groupsList[index]['name'];

    print("index: $index");
    print("recentActivity: $recentActivity");
    print("groupsListIndexName: $groupsListIndexName");

    if (null != recentActivity) {
      IconData icon = UniconsLine.comment_message;

      switch (recentActivity['action']) {
        case "replied to":
          icon = UniconsLine.comment_message;
          break;

        case "liked":
          icon = UniconsLine.comment_heart;
          break;

        case "posted":
          icon = UniconsLine.chat;
          break;

        default:
          icon = UniconsLine.comment_message;
      }
      widget = new Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 5.0, right: 20.0, bottom: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                icon,
                color: Colors.redAccent,
              ),
            ),
            new Text(
                groupsList[index]['recent_activity']['username'] +
                    " " +
                    groupsList[index]['recent_activity']['action'] +
                    ": ",
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: groupsSubTextStyleBold),
            Flexible(
              child: new Text(
                  groupsList[index]['recent_activity']['post_title'],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: groupsSubTextStyle),
            ),
          ],
        ),
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Container(
            margin: const EdgeInsets.only(
                top: 0.0, left: 0.0, right: 0.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: sidePadding, right: sidePadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: iconColor,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                  Text(
                    'Create Group',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: homeSubtitleTextStyle,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupsList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(
                    top: 0.0, left: 0.0, right: 0.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 70.0,
                              height: 70.0,
                              margin:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://randomuser.me/api/portraits/women/69.jpg"),
                                  ))),
                          Container(
                            height: 90.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(groupsList[index]['name'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        homeTextStyleBold), //set a global style to be shared//sized box to create space between
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(groupsList[index]['security'] + " - ",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: homeSubTextStyle),
                                    Text(
                                        groupsList[index]['members']
                                                .length
                                                .toString() +
                                            " Members",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: homeSubTextStyle),
                                  ],
                                ),
                                Container(
                                  height: memberAvatarHeight + 4,
                                  width: 140.0,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 4,
                                      itemBuilder: (BuildContext context,
                                          int memberIndex) {
                                        if (3 == memberIndex) {
                                          //return container with overlay
                                          return Stack(children: [
                                            Container(
                                                width: memberAvatarWidth,
                                                height: memberAvatarHeight,
                                                margin: const EdgeInsets.only(
                                                    right: 5, bottom: 5),
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                avatarRadius)),
                                                    image: new DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          groupsList[index][
                                                                      'members']
                                                                  [memberIndex][
                                                              "profile_image"]),
                                                    ))),
                                            Container(
                                                width: memberAvatarWidth,
                                                height: memberAvatarHeight,
                                                margin: const EdgeInsets.only(
                                                    right: 5, bottom: 5),
                                                decoration: new BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            memberAvatarRadius)),
                                                    color: new Color.fromRGBO(
                                                        255, 0, 0, 0.5)),
                                                child: Center(
                                                    child: Text(
                                                  "+" +
                                                      (groupsList[index][
                                                                      'members']
                                                                  .length -
                                                              memberIndex)
                                                          .toString(),
                                                  style: homeTextStyleBoldWhite,
                                                ))),
                                          ]);
                                        } else {
                                          return Container(
                                              width: memberAvatarWidth,
                                              height: memberAvatarHeight,
                                              margin: const EdgeInsets.only(
                                                  right: 5, bottom: 5),
                                              decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          memberAvatarRadius)),
                                                  image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        groupsList[index]
                                                                    ['members']
                                                                [memberIndex]
                                                            ["profile_image"]),
                                                  )));
                                        }
                                      }),
                                ) //sized box to create space between
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    _buildGroupDivider(index),
                    _buildGroupRecents(index),
                  ],
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
        ),
      ],
    );
  }
}
