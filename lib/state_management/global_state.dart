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
bool isAdmin = false;
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
