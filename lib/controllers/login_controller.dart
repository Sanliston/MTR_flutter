import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/home_screen.dart';
import 'package:MTR_flutter/screens/login_screen.dart';


class LoginController {

  BuildContext context;
  String email;
  String password;
  final screen;
  

  LoginController.buildContext(this.context, this.screen); //constructor that defines context

  void login(String email, String password, Function callback){

    bool emailValid = checkEmailExists(email);
    bool passwordValid = checkPassword(email, password);

    if(!emailValid || !passwordValid){
      callback(emailValid, passwordValid);

    }else{
      switchScreen(context, this.screen);
    }
    
  }


  bool signup(){
    switchScreen(this.context, this.screen);
    return true;
  }


  Route _createRoute(screen){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },

    );
  }

  bool checkEmailExists(String email){

    /*
      logic for logging in will go here 

      This will be where you will call model, which wil make calls to API etc for loggin in. 

    
    */

    if(email == "sanliston@outlook.com"){
      return true;
    }else{
      return false; 
    }
  }

   bool checkPassword(String email, String password){

    /*
      logic for logging in will go here 

      This will be where you will call model, which wil make calls to API etc for loggin in. 

    
    */

    if(email == "sanliston@outlook.com" && password == "catman"){
      return true;
    }else{
      return false; 
    }
  }

  void switchScreen(context, screen){
    Navigator.of(context).push(_createRoute(screen));
  }
}