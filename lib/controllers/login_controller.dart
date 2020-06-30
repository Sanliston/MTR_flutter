import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/views/home_screen.dart';

/*This seems to work */

class LoginController {

  BuildContext context;
  String email;
  String password;
  

  LoginController.buildContext(this.context); //constructor that defines context

  bool login(String email, String password){

    var loggedIn = checkDetails(email, password);

    if(loggedIn){
      switchScreen(this.context);
      return true; 
    }else{
      return false;
    }
  }


  Route _createRoute(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },

    );
  }

  bool checkDetails(String email, String password){

    if(email == "sanliston@outlook.com"){
      return true;
    }else{
      return false; 
    }
  }

  void switchScreen(context){
    Navigator.of(context).push(_createRoute());
  }
}