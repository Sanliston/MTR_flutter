import 'package:MTR_flutter/blur_on_scroll.dart';
import 'package:MTR_flutter/core_overrides/custom_reorderable_list.dart';
import 'package:MTR_flutter/fade_on_scroll.dart';
import 'package:MTR_flutter/state_management/home_state.dart';
import 'package:flutter/rendering.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

class CustomizeHeaderScreen extends StatefulWidget {
  @override
  _CustomizeHeaderScreenState createState() => _CustomizeHeaderScreenState();
}

class _CustomizeHeaderScreenState extends State<CustomizeHeaderScreen> {
  ScrollController mainScrollController = new ScrollController();
  List list;
  @override
  void initState() {
    super.initState();

    list = [
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
      "assets/images/home_background.jpg",
    ];

    //state stuff here
  }

  @override
  void dispose() {
    super.dispose();

    //free up any used resources here
  }

  _CustomizeHeaderScreenState(); //constructor call

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            title: Text('Customize Header', style: homeTextStyleBoldWhite),
            centerTitle: true,
            backgroundColor: darkNight,
            leading: IconButton(
              icon: const Icon(EvaIcons.closeOutline),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    //call controller to make changes to home_state
                  },
                  child:
                      Center(child: Text('Save', style: homeTextStyleWhite))),
            ]),
        body: CustomScrollView(
          controller: mainScrollController,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 305.0,
              floating: false,
              pinned: false,
              snap: false,
              elevation: 50,
              backgroundColor: darkNight,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: FadeOnScroll(
                  scrollController: mainScrollController,
                  zeroOpacityOffset: 300,
                  fullOpacityOffset: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0,
                        left: memberViewPadding,
                        right: memberViewPadding),
                    child:
                        AbsorbPointer(child: buildHeaderPreview(context, 0.9)),
                  ),
                ),
              ),
            ),
            new SliverList(delegate: new SliverChildListDelegate(_buildList())),
          ],
        ),
      ),
    );
  }

  List _buildList() {
    List<Widget> listItems = [
      buildPlaceName(),
      buildTagLine(),
      buildPlaceLogo(),
      buildCoverPhoto()
    ];

    return listItems;
  }

  Padding buildCoverPhoto() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cover Photo", style: homeTextStyleBold),
                      Text("Suggested size: 750x350 px",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    EvaIcons.plusCircleOutline,
                    color: Colors.greenAccent,
                    size: 25.0,
                  )
                ],
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - (sidePadding * 2.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: CustomReorderableListView(
                      padding: EdgeInsets.only(right: 25.0),
                      scrollDirection: Axis.horizontal,
                      children: buildPhotoList(),
                      onReorder: (oldIndex, newIndex) {
                        String old = list[oldIndex];
                        if (oldIndex > newIndex) {
                          for (int i = oldIndex; i > newIndex; i--) {
                            list[i] = list[i - 1];
                          }
                          list[newIndex] = old;
                        } else {
                          for (int i = oldIndex; i < newIndex - 1; i++) {
                            list[i] = list[i + 1];
                          }
                          list[newIndex - 1] = old;
                        }
                        setState(() {});
                      }),
                ),
              ),
              Text("Tap, hold and drag to reorder", style: homeSubTextStyle)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildPhotoList() {
    List<Widget> photoList = [];
    Widget temp;

    for (var i = 0; i < list.length; i++) {
      temp = Container(
        key: GlobalKey(),
        height: 70,
        margin: EdgeInsets.only(left: 0, right: 0),
        width: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  image: DecorationImage(
                    image: AssetImage(list[i]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null /* add child content here */,
              ),
            ),
            Container(
                height: 15,
                width: 15,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      EvaIcons.closeOutline,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    onPressed: null),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                )),
          ],
        ),
      );

      photoList.add(temp);
    }

    return photoList;
  }

  Padding buildPlaceLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Place Logo", style: homeTextStyleBold),
                      Text("Suggested size: 200x200 px",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: Colors.greenAccent,
                    size: 40.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home_background.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null /* add child content here */,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child:
                              Text("Replace Logo", style: homeSubTextStyleBold),
                        ),
                      ],
                    ),
                    Icon(
                      EvaIcons.editOutline,
                      color: Colors.greenAccent,
                      size: 25.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTagLine() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tagline", style: homeTextStyleBold),
                      Text("Add a short tagline to describe your place",
                          style: homeSubTextStyle),
                    ],
                  ),
                  Icon(
                    UniconsSolid.toggle_on,
                    color: Colors.greenAccent,
                    size: 40.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tagline", style: homeSubTextStyle),
                    Container(
                      height: 35.0,
                      child: TextFormField(
                        style: homeTextStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a tagline'),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[400], width: 1.0))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("14/25", style: homeTextStyle)],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPlaceName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Place Name", style: homeTextStyleBold),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title", style: homeSubTextStyle),
                    Container(
                      height: 35.0,
                      child: TextFormField(
                        style: homeTextStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a place name'),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[400], width: 1.0))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("14/20", style: homeTextStyle)],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderPreview(BuildContext context, double sizeFactor) {
    Widget widget = Stack(
      children: [
        headerBuilders['preview_background'](400.0,
            MediaQuery.of(context).size.width - (memberViewPadding * 2.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CustomizeHeaderScreen()));
              },
              padding: EdgeInsets.zero,
              child: AbsorbPointer(
                child: SizedBox(
                    height: 280.0,
                    child: headerBuilders['header'](context,
                        memberViewMode: true, sizeFactor: sizeFactor)),
              ),
            )
          ],
        )
      ],
    );
    return widget;
  }
}
