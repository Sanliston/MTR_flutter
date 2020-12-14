import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/home_state.dart';

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
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 0.5))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          'Customize',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: homeTextStyleBold,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Done',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: homeLinkTextStyle,
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
                          automaticallyImplyLeading: false,
                          bottom: TabBar(
                            tabs: myTabs,
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: myTabs.map((Tab tab) {
                          //place relevant tab widgets here
                          final String label = tab.text.toLowerCase();
                          return Center(
                            child: Text(
                              'This is the $label tab',
                              style: const TextStyle(fontSize: 36),
                            ),
                          );
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
