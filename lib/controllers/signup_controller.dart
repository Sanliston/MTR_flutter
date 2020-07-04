import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:MTR_flutter/screens/login_screen.dart';


class SignupController {

  BuildContext context;
  final screen;
  

  SignupController.buildContext(this.context, this.screen); //constructor that defines context

  void register(HashMap dataMap, Function callback){


    //see if dataMap contains valid values
    HashMap validMap = new HashMap<String, bool>();

    validMap['fullName'] = dataMap.containsKey('fullName') ? checkNameIsValid(dataMap['fullName']) : false;
    validMap['phoneNumber'] = dataMap.containsKey('phoneNumber') ? checkPhoneIsValid(dataMap['phoneNumber']) : false;
    validMap['email'] = dataMap.containsKey('email') ? checkEmailIsValid(dataMap['email']) : false;
    validMap['password'] = dataMap.containsKey('password') && dataMap.containsKey('passwordConfirmed') ? checkPasswordIsValid(dataMap['password'], dataMap['passwordConfirmed']) : false;


    bool allValid = !validMap.containsValue(false);

    if(allValid){

     switchScreen(context, this.screen);  

    }else{
      callback(validMap);
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

  bool checkNameIsValid(String fullName){
    //TODO: checkNameIsValid

    if(fullName == "test"){
      return true;
    }else{
      return false; 
    }

  }

  bool checkPhoneIsValid(String phoneNumber){
    //TODO: checkPhoneIsValid

    if(phoneNumber == "0000"){
      return true;
    }else{
      return false; 
    } 

  }

  bool checkEmailIsValid(String email){

    /*
      logic for logging in will go here 

      This will be where you will call model, which wil make calls to API etc for loggin in. 

    
    */

    if(email == "test"){
      return true;
    }else{
      return false; 
    }
  }

   bool checkPasswordIsValid(String password, String passwordConfirmed){

    /*
      logic for checking password will go here

    
    */

    //DUMMY LOGIC FOR NOW
    if(password == passwordConfirmed){
      return true;
    }else{
      return false; 
    }
  }

  void switchScreen(context, screen){
    Navigator.of(context).push(_createRoute(screen));
  }
}