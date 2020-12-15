import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_place_card.dart';
import 'package:MTR_flutter/screens/tabs/home/admin/customize_screens/customize_member_view.dart';

class HomeCustomizeScreen extends StatefulWidget {
  @override
  _HomeCustomizeScreenState createState() => _HomeCustomizeScreenState();
}

class _HomeCustomizeScreenState extends State<HomeCustomizeScreen> {
  @override
  void initState() {
    super.initState();

    //state stuff here
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Member View'),
    Tab(text: 'Place Card'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: darkNight,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.0))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.infoOutline,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          'Customize',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: homeTextStyleBoldWhite,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Done',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: homeTextStyleWhite,
                          ),
                        )
                      ]),
                ),
              ),
              Flexible(
                child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(50.0),
                        child: AppBar(
                          backgroundColor: darkNight,
                          automaticallyImplyLeading: false,
                          bottom: TabBar(
                            indicatorColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: myTabs,
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: myTabs.map((Tab tab) {
                          //place relevant tab widgets here
                          final String label = tab.text;

                          Widget widget = Container();

                          switch (label) {
                            case "Member View":
                              widget = new CustomizeMemberView();
                              break;
                            case "Place Card":
                              widget = new CustomizePlaceCard();
                              break;
                          }

                          return widget;
                        }).toList(),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
