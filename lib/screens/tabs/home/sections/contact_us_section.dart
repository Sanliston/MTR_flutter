import 'package:MTR_flutter/state_management/root_template_state.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
