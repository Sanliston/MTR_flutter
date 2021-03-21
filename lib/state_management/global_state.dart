import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/services.dart';

/*The values set here also act as initial state values
And will naturally change as the application runs.

Be careful which values you set and which you leave unset, as some can break
the application if unset.

TODO: use enums 
*/

Map sharedStateManagement =
    {}; //global Map that other widgets can add and extract data from

bool loggedIn = true;
bool isAdmin = true;
int selectedPageIndex = 1;

//Enum to be used stateCallback
enum screen { login, signup, main, homeTab }
Map stateCallback = {}; //global collection of setState functions

//login_screen.dart states
Map loginScreenState = {};

//signup_screen.dart states
Map signupScreenState = {};

//main_screen.dart states
enum mainScreen { selectedIndex }

Map mainScreenState = {
  mainScreen.selectedIndex: 0
}; //states for main_screen.dart

/*Size factor accounting for different screen heights,
  allows text, button sizes etc, to scale according to screen size
  so you don't end up with large buttons on small devices or small buttons
  on large devices
*/
double sizeFactor = 1.0; //starting value
updateSizeFactor(double screenHeight) {
  //using 844 as the control value
  print("screen height: $screenHeight");

  screenHeight = screenHeight < 700 ? 700 : screenHeight;
  screenHeight = screenHeight > 880 ? 880 : screenHeight;

  sizeFactor = screenHeight / 844.0;
}
