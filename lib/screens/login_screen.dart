import 'package:MTR_flutter/components/background_video.dart';
import 'package:flutter/services.dart';
import 'package:MTR_flutter/screens/main_screen.dart';
import 'package:MTR_flutter/screens/signup_screen.dart';
import 'package:MTR_flutter/controllers/login_controller.dart';
import 'package:MTR_flutter/utilities/utility_imports.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool emailValid = true;
  bool passwordValid = true;
  int loginAttempts = 0;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);

    //stateCallback declaration
    stateCallback['login_screen'] = setState;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  void _onFocusChange() {
    debugPrint("*******************Focus: " + _focus.hasFocus.toString());
  }

  void isValid(bool email, bool password) {
    setState(() {
      if (!email) {
        this.emailValid = false;
      } else {
        this.emailValid = true;
      }

      if (!password) {
        this.passwordValid = false;
      } else {
        this.passwordValid = true;
      }

      if (!email || !password) {
        this.loginAttempts++;
        print("Login attempts: $loginAttempts");
      }
    });

    //set state
  }

  Widget _buildEmailTF() {
    TextStyle textStyle = homeTextStyleWhite;
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
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: inputTransparentDecorationStyle,
          height: 60.0,
          child: new TextField(
            controller: emailController,
            focusNode: _focus,
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
              hintStyle: homeTextStyleWhite,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    TextStyle textStyle = homeTextStyleWhite;
    String text = "Password";
    //Logic here
    if (!passwordValid) {
      textStyle = kLabelStyleRed;
      text = "Invalid Password";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: textStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: inputTransparentDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: homeTextStyleWhite,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter your Password',
                hintStyle: homeTextStyleWhite),
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
          style: homeTextStyleWhite,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: homeTextStyleWhite,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      height: 30,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () {
          print('Login Button Pressed');

          //get email from form
          String emailInput = emailController.text;

          //get password from form
          String passwordInput = passwordController.text;

          Widget screen = MainScreen();
          LoginController loginController =
              new LoginController.buildContext(context, screen);
          loginController.login(emailInput, passwordInput, isValid);
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Sign in with',
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
              color: Colors.transparent,
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
          _buildSocialBtn(() => print('Login with Facebook'),
              AssetImage('assets/logos/facebook.jpg')),
          _buildSocialBtn(() => print('Login with Google'),
              AssetImage('assets/logos/google.jpg')),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');

        Widget screen = SignUpScreen();
        LoginController loginController =
            new LoginController.buildContext(context, screen);
        loginController.signup();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                  child: VideoPlayerScreen(
                autoPlay: true,
                loop: true,
                videoSource: "assets/videos/background_video_3.mp4",
              )),
              Container(
                padding: new EdgeInsets.all(30.0),
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(flex: 5, child: _buildEmailTF()),
                    Expanded(flex: 5, child: _buildPasswordTF()),
                    Expanded(flex: 1, child: _buildForgotPasswordBtn()),
                    Expanded(flex: 2, child: _buildRememberMeCheckbox()),
                    Expanded(flex: 5, child: _buildLoginBtn(context)),
                    Expanded(flex: 3, child: _buildSignInWithText()),
                    Expanded(flex: 4, child: _buildSocialBtnRow()),
                    Expanded(flex: 1, child: _buildSignupBtn()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
