import 'dart:ui';

import 'package:MTR_flutter/components/navigation_drawer.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/state_management/root_template_state.dart';
import 'package:MTR_flutter/components/buttons.dart';
import 'package:intl/intl.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({
    Key key,
  }) : super(key: key);

  void displayMemberOptions(BuildContext context, GlobalKey key, int index) {
    //format followers etc
    final formatter = new NumberFormat("#,###", "en_US");
    String followingCount = formatter.format(membersList[index]["following"]);
    String followerCount = formatter.format(membersList[index]["followers"]);

    //figure out if person follows user or not
    bool followsYou = true;

    Widget followsYouWidget = Container(height: 1.0);

    if (followsYou) {
      followsYouWidget = Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          padding:
              EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
          child: Text("Follows you",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                  color: Colors.white)),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4)),
          ),
        ),
      );
    }

    double profilePictureHeight = 100;
    double profilePictureWidth = 100;
    double opacity = 0.6;
    Color borderColor = darkNight;
    Color statusColor = Colors.green[400];
    double containerHeight = 270.0;
    Widget status = Container(height: 1.0);

    if (membersList[index]["online"]) {
      containerHeight = 300.0;
      status = Text("Active now",
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12, color: statusColor));
    }

    Widget memberBackgrounndImage = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(membersList[index]['profile_image']),
          fit: BoxFit.cover,
        ),
      ),
      child: null /* add child content here */,
    );

    Widget memberProfilePicture = Container(
        width: profilePictureWidth,
        height: profilePictureHeight,
        decoration: new BoxDecoration(
            border: Border.all(
                color: Colors.white.withOpacity(opacity), width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
            image: new DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(membersList[index]['profile_image']),
            )));

    Widget customContainer = Wrap(children: <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FlatButton(
          onPressed: () {
            print("Navigator pop yo");
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 350.0,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: profilePictureHeight / 2,
                        child: Container(
                            height: containerHeight,
                            width: 300,
                            decoration: BoxDecoration(
                              color: darkMode
                                  ? itemBackground.withOpacity(0.8)
                                  : Colors.white.withOpacity(opacity),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: sidePadding,
                                  right: sidePadding,
                                  top: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, bottom: 0.0),
                                          child: Text(
                                              membersList[index]["username"],
                                              style: homeTextStyleBold),
                                        ),
                                        followsYouWidget
                                      ],
                                    ),
                                  ),
                                  status,
                                  Divider(
                                    color: darkNight.withOpacity(0.2),
                                    thickness: 0.6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                followingCount,
                                                style: homeSubTextStyleBold,
                                              ),
                                              Text(
                                                "  following",
                                                style: homeSubTextStyle,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              followerCount,
                                              style: homeSubTextStyleBold,
                                            ),
                                            Text(
                                              "  followers",
                                              style: homeSubTextStyle,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                      color: darkNight.withOpacity(0.2),
                                      thickness: 0.6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SolidButton(
                                            text: "Follow",
                                            iconData: EvaIcons.personAddOutline,
                                            width: 110),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SolidButton(
                                            text: "Message",
                                            iconData:
                                                EvaIcons.messageCircleOutline,
                                            width: 110),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: TransparentButton(
                                        text: "Profile",
                                        width: 100,
                                        iconData: EvaIcons.personOutline),
                                  )
                                ],
                              ),
                            )),
                      ),
                      memberProfilePicture,
                    ],
                  ),
                )
              ]),
        ),
      )
    ]);
    Map params = {"context": context, "custom_container": customContainer};

    displayNavigationDrawer(context, params);
  }

  void displayAdminOptions(BuildContext context) {}

  Widget buildMemberInfo(int index, BuildContext context) {
    //TODO get information here on whether user is following this person or not
    bool following = false;

    Widget followButton = TransparentButton(
      text: "Follow",
      onPressed: () {
        //follow code here
      },
    );

    if (following) {
      followButton = SolidButton(
        text: "Following",
        onPressed: () {
          //unfollow code here
        },
      );
    }

    //figure out if person follows user or not
    bool followsYou = true;

    Widget followsYouWidget = Container(height: 1.0);

    if (followsYou) {
      followsYouWidget = Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          padding:
              EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
          child: Text("Follows you",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                  color: Colors.white)),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4)),
          ),
        ),
      );
    }

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

    GlobalKey key = GlobalKey();
    Widget widget = FlatButton(
        key: key,
        onPressed: () {
          displayMemberOptions(context, key, index);
        },
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            image: NetworkImage(
                                membersList[index]['profile_image']),
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(membersList[index]['username'],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style:
                              homeSubTextStyleBold), //set a global style to be shared
                      SizedBox(height: 5),
                      role,
                      followsYouWidget //sized box to create space between
                    ],
                  )
                ],
              ),
              followButton
            ],
          ),
        ));

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: darkMode
              ? EdgeInsets.symmetric(horizontal: 10.0)
              : EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: membersList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Color dividerColor = darkMode ? itemBackground : Colors.white;
            if (0 < index) {
              dividerColor = darkMode ? bodyBackground : Colors.grey[100];
            }

            return Container(
              color: itemBackground,
              child: Column(
                children: [
                  Divider(
                    color: dividerColor,
                    thickness: darkMode ? 5.0 : 1.0,
                  ),
                  buildMemberInfo(index, context)
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
