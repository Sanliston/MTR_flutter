import 'package:MTR_flutter/utilities/utility_imports.dart';

class AnnoucementsSection extends StatelessWidget {
  final List announcements;

  const AnnoucementsSection({Key key, @required this.announcements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      color: Colors.grey.withOpacity(0.30),
                      spreadRadius: 1,
                      blurRadius: 9,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
