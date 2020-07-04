import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';

/*This screen will have several tabs:
  Home
  Forum
  Groups
  Members
  Events
  Services
  Pricing
  Content 
  
  And it will also be housed in a SliverAppBar.
  
  For now, I will use this approach:
  https://gist.github.com/X-Wei/ed1ce793482789c8e9632592b79458f7

  But in the future we can take an approach like this:
  https://medium.com/@diegoveloper/flutter-collapsing-toolbar-sliver-app-bar-14b858e87abe
  */


class HomeTabScreen extends StatefulWidget {

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(
      length: 8,
      vsync: this,
    );
  }

  @override
  Widget build (BuildContext context){

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            title: Text("More Than Rubies"),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Text"),
                      Text("Text")
                    ],
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Forum'),
                Tab(text: 'Groups'),
                Tab(text: 'Members'),
                Tab(text: 'Events'),
                Tab(text: 'Services'),
                Tab(text: 'Pricing'),
                Tab(text: 'Content'),
              ],
              controller: controller,
            )
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: controller,
              children: <Widget> [
                Center(child: Text("Home")),
                Center(child: Text("Forum")),
                Center(child: Text("Groups")),
                Center(child: Text("Members")),
                Center(child: Text("Events")),
                Center(child: Text("Services")),
                Center(child: Text("Pricing")),
                Center(child: Text("Content")),
              ]
            )
          )
        ]
      )
    );
  }
}
