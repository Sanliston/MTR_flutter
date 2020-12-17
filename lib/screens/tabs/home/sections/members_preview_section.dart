import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:MTR_flutter/screens/tabs/home/members/members_search_screen.dart';

class MembersPreviewSection extends StatelessWidget {
  final List membersShortlist;

  MembersPreviewSection({Key key, @required this.membersShortlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                              Opacity(
                                opacity: 0.7,
                                child: Container(
                                    width: avatarWidth,
                                    height: avatarHeight,
                                    margin: const EdgeInsets.only(
                                        right: 10, bottom: 5),
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(avatarRadius)),
                                        color: primaryColor),
                                    child: Center(
                                        child: Text(
                                      "+86",
                                      style: homeTextStyleBoldWhite,
                                    ))),
                              ),
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
                    sharedStateManagement['display_invite_menu']();
                  },
                  padding: EdgeInsets.only(
                      top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: primaryColor,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: SizedBox(
                    width: 130.0,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            EvaIcons.personAddOutline,
                            color: primaryColor,
                            size: 14.0,
                          ),
                        ),
                        Text(
                          'Invite Members',
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.heebo(
                              textStyle: TextStyle(
                            color: primaryColor,
                            letterSpacing: 1.5,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
