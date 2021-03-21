import 'package:MTR_flutter/state_management/global_state.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/screens/login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'MTR App',
      home: LoginScreen(),
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
    );
  }
}
