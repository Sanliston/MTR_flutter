import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:MTR_flutter/screens/login_screen.dart';
import 'package:MTR_flutter/controllers/signup_controller.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool fullNameValid = true;
  bool phoneNumberValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  int loginAttempts = 0;

  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  FocusNode _passwordFocus = new FocusNode();
  FocusNode _passwordConfirmFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(() {
      //scroll to show Widget here
    });

    _passwordConfirmFocus.addListener(() {
      //scroll to show widget here
    });

    //stateCallback declaration
    stateCallback['signup_screen'] = setState;
  }

  void isValid(HashMap<String, bool> validMap) {
    setState(() {
      if (!validMap.containsKey('fullName') || !validMap['fullName']) {
        this.fullNameValid = false;
      } else {
        this.fullNameValid = true;
      }

      if (!validMap.containsKey('phoneNumber') || !validMap['phoneNumber']) {
        this.phoneNumberValid = false;
      } else {
        this.phoneNumberValid = true;
      }

      if (!validMap.containsKey('email') || !validMap['email']) {
        this.emailValid = false;
      } else {
        this.emailValid = true;
      }

      if (!validMap.containsKey('password') || !validMap['password']) {
        this.passwordValid = false;
      } else {
        this.passwordValid = true;
      }
    });

    //set state
  }

  Widget _buildFullNameTF() {
    TextStyle textStyle = kLabelStyle;
    String text = "Full Name";

    if (!fullNameValid) {
      text = "Full name is invalid";
      textStyle = kLabelStyleRed;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: new TextField(
            controller: fullNameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberTF() {
    TextStyle textStyle = kLabelStyle;
    String text = "Phone No";

    if (!phoneNumberValid) {
      text = "Phone No is invalid";
      textStyle = kLabelStyleRed;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: new TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    TextStyle textStyle = kLabelStyle;
    String text = "Email";
    //Logic here
    if (!emailValid) {
      textStyle = kLabelStyleRed;
      text = "Invalid Email";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: new TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    TextStyle textStyle = kLabelStyle;
    String text = "Password";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: TextField(
            focusNode: _passwordConfirmFocus,
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTF() {
    TextStyle textStyle = kLabelStyle;
    String text = "Confirm Password";
    //Logic here
    if (!passwordValid) {
      textStyle = kLabelStyleRed;
      text = "Passwords don't match";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: TextField(
            focusNode: _passwordFocus,
            controller: passwordConfirmController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRegisterBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () {
          print('Register Button Pressed');

          //create HashMap -- are there better data types for this?
          HashMap dataMap = new HashMap<String, String>();

          //get fullname from form
          dataMap['fullName'] = fullNameController.text;

          //get phone number from form
          dataMap['phoneNumber'] = phoneNumberController.text;

          //get email from form
          dataMap['email'] = emailController.text;

          //get password from form
          dataMap['password'] = passwordController.text;

          //get confirmed password
          dataMap['passwordConfirmed'] = passwordConfirmController.text;

          Widget screen = MainScreen();
          SignupController signupController =
              new SignupController.buildContext(context, screen);
          signupController.register(dataMap, isValid);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 0.0),
        Text(
          'Sign up with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Signup with Facebook'),
            AssetImage('assets/logos/facebook.jpg'),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage('assets/logos/google.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInBtn() {
    //purpose of this is to switch back to login screen
    return GestureDetector(
      onTap: () {
        print('Sign in Button Pressed');

        Widget screen = LoginScreen();
        SignupController signupController =
            new SignupController.buildContext(context, screen);
        signupController.switchScreen(context, screen);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              padding: new EdgeInsets.only(
                  top: 30.0, left: 30.0, right: 30.0, bottom: 0.0),
              color: login_bg_color,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: _buildFullNameTF()),
                      Expanded(flex: 2, child: _buildPhoneNumberTF()),
                      Expanded(flex: 2, child: _buildEmailTF()),
                      Expanded(flex: 2, child: _buildPasswordTF()),
                      Expanded(flex: 2, child: _buildConfirmPasswordTF()),
                      Expanded(flex: 2, child: _buildRegisterBtn(context)),
                      Expanded(flex: 1, child: _buildSignInBtn())
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
