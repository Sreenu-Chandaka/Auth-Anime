// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../utils/animations/login_page_animations.dart';
import '../utils/page_routes/fade_page_route.dart';
import './home_page.dart';


class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedLoginPageState();
  }
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(controller: _controller);
  }
}

class _LoginPage extends StatelessWidget {
  late double _deviceHeight;
  late  double _deviceWidth;

  final Color _primaryColor = const Color.fromRGBO(125, 191, 211, 1.0);
  final Color _secondaryColor = const Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController _controller;
  late EnterAnimation _animation;

  _LoginPage({required AnimationController controller}) : _controller = controller {
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: _deviceHeight * 0.60,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.05),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(height: _deviceHeight * 0.10),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.controller,
      builder: (BuildContext _context, Widget? _widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
              _animation.circleSize.value, _animation.circleSize.value, 1),
          child: Container(
            height: _circleD,
            width: _circleD,
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(500),
              image: const DecorationImage(
                image: AssetImage('assets/images/main_avatar.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emailTextField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: const TextField(
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "John.doe@gmail.com",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: const TextField(
        obscureText: true,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext _context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: const BorderSide(color: Colors.white)),
      onPressed: () async {
        await _controller.reverse();
        Navigator.pushReplacement(
          _context,
          FadePageRoute(
            AnimatedHomePage(),
          ),
        );
      },
      child: Text(
        "LOG IN",
        style: TextStyle(
            fontSize: 16, color: _primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
