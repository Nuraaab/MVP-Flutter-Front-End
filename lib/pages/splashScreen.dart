import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'homeScreen.dart';
class AnimatedSpalshScreen extends StatefulWidget {
  const AnimatedSpalshScreen({Key? key}) : super(key: key);
  @override
  State<AnimatedSpalshScreen> createState() => _AnimatedSpalshScreenState();
}
class _AnimatedSpalshScreenState extends State<AnimatedSpalshScreen> {
  @override
  void initState() {
    super.initState();
    _setLanguage();
  }
  void _setLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', true);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
          splash: Container(
            height: 300,
            child:Lottie.asset('assets/images/splash_icon.json', fit: BoxFit.cover),
          ),
          splashIconSize: 400,
          backgroundColor: Colors.white,
          duration: 2500,
          pageTransitionType: PageTransitionType.topToBottom,
          animationDuration: Duration(seconds: 0),
          nextScreen: HomeScreen()),
    );
  }
}
