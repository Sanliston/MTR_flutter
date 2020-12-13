import 'package:MTR_flutter/utilities/utility_imports.dart';

class HomeUpcoming extends StatelessWidget {
  const HomeUpcoming({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
