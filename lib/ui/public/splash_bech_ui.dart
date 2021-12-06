import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hackaton/ui/public/viewers_ui.dart'; 
import 'package:page_transition/page_transition.dart';

class SplashBechUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return AnimatedSplashScreen(
            splash: Image.asset("assets/images/splash.png", ) ,
            splashIconSize: 380.0, 
            nextScreen: ViewersUI(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.fade,
            duration: 3000, 
            backgroundColor: Colors.deepPurpleAccent,
    );  
  }
 
}
