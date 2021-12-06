import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hackaton/constants/app_themes.dart';
import 'package:hackaton/ui/ui.dart'; 
import 'package:page_transition/page_transition.dart';

class SplashBechUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return AnimatedSplashScreen(
            splash: Image.asset("assets/images/splash.png", ) ,
            splashIconSize: 380.0, 
            nextScreen: LoginUi(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.fade,
            duration: 3000, 
            backgroundColor: AppThemes.dodgerBanco,
    );  
  }
 
}
