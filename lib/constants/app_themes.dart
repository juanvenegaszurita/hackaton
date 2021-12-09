import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  /*static final light = ThemeData.light().copyWith();
  static final dark = ThemeData.dark().copyWith(); */

  static const Color orange = Color.fromRGBO(255, 135, 0, 1);
  static const Color dodgerBanco = Color.fromRGBO(16, 6, 73, 1);

  static const Color dodgerBlue = Color.fromRGBO(29, 161, 242, 1);
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);
  static const Color blackPearl = Color.fromRGBO(490, 20, 103, 1);
  static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color nevada = Color.fromRGBO(70, 9, 195, 1);
  static const Color ebonyClay = Color.fromRGBO(0, 0, 62, 1);

  static String font1 = "ProductSans";
  static String font2 = "Roboto";
  //constants color range for light theme

  //constants color range for dark theme
  static const Color _darkPrimaryColor = nevada;

  //Background Colors
  static const Color _darkBackgroundColor = ebonyClay;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor =
      Color.fromRGBO(55, 8, 152, .6);
  static const Color _darkBackgroundAlertColor = blackPearl;
  static const Color _darkBackgroundActionTextColor = white;

  //Text Colors
  static const Color _darkTextColor = Colors.white;

  //Icon Color
  static const Color _darkIconColor = nevada;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 20.0, color: _darkTextColor),
    bodyText1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodyText2: TextStyle(fontSize: 14.0, color: _darkTextColor),
    button: TextStyle(
      fontSize: 15.0,
      color: _darkTextColor,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(fontSize: 16.0, color: _darkTextColor),
    subtitle1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    caption: TextStyle(fontSize: 12.0, color: _darkTextColor),
    headline2: TextStyle(fontSize: 16.0, color: _darkTextColor),
    headline3: TextStyle(fontSize: 14.0, color: _darkTextColor),
    headline4: TextStyle(fontSize: 12.0, color: _darkTextColor),
    headline5: TextStyle(fontSize: 10.0, color: _darkTextColor),
    overline: TextStyle(fontSize: 14.0, color: _darkTextColor),
    subtitle2: TextStyle(fontSize: 14.0, color: _darkTextColor),
  );

  //the dark theme
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: dodgerBanco,
      iconTheme: IconThemeData(color: _darkTextColor),
      toolbarTextStyle: TextStyle(
        fontSize: 14.0,
        color: _darkTextColor,
      ),
      titleTextStyle: TextStyle(
        fontSize: 15.0,
        color: _darkTextColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: orange,
      primaryVariant: _darkBackgroundColor,
      secondary: nevada,
      surface: dodgerBanco,
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(color: Colors.white),
      backgroundColor: _darkBackgroundAlertColor,
      actionTextColor: _darkBackgroundActionTextColor,
    ),
    iconTheme: IconThemeData(
      color: _darkIconColor, //_darkIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: _darkBackgroundAppBarColor,
      textStyle: TextStyle(
        color: white,
      ),
    ),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      buttonColor: orange,
      //textTheme: ButtonTextTheme.normal,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(orange),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(color: Colors.white, decorationColor: Colors.white),
        ),
      ),
    ),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(color: _darkIconColor),
      //labelStyle: TextStyle(color: nevada),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: orange.withAlpha(50), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: orange, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: orange),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _darkInputFillColor,
      focusColor: _darkBorderActiveColor,
    ),
    dialogBackgroundColor: ebonyClay,
    dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
        color: white,
      ),
      backgroundColor: ebonyClay,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: orange,
        ),
      ),
    ),
  );
}
