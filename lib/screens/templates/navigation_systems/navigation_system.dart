import 'package:MTR_flutter/utilities/utility_imports.dart';

abstract class NavigationSystem extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget navigationBar; //to represent the navigation menu
  final Widget navigationView; // to represent the view
  final ChangeNotifier navigationController; //to represent the controller

  const NavigationSystem(
      {Key key,
      this.navigationBar,
      this.navigationView,
      this.navigationController})
      : super(key: key);
}
