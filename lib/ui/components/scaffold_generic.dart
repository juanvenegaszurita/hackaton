import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/ui/components/menu.dart';

class ScaffoldGeneric extends GetResponsiveView {
  ScaffoldGeneric({
    required this.body,
    this.title = "",
    this.maxWidth = 1200,
    this.border = false,
    this.backgroundColor,
    this.backgroundColorAppBar,
    this.colorTitle,
    this.alignmentTitle = Alignment.center,
    this.elevationTitle = 4.0,
    this.isMenu = true,
    this.isAppBarActions = true,
  });
  final String title;
  final Widget body;
  final double maxWidth;
  final bool border;
  final Color? backgroundColor;
  final Color? backgroundColorAppBar;
  final Color? colorTitle;
  final AlignmentGeometry alignmentTitle;
  final double elevationTitle;
  final bool isMenu;
  final bool isAppBarActions;

  @override
  Widget builder() {
    double width = screen.isDesktop ? maxWidth : screen.width;
    return Scaffold(
      drawer: isMenu ? Menu() : null,
      backgroundColor: backgroundColor != null
          ? backgroundColor
          //: ThemeController().getThemeModeFromString().scaffoldBackgroundColor,
          : ThemeData().scaffoldBackgroundColor,
      appBar: AppBar(
        actions: isAppBarActions
            ? [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    /* Get.to(page) */
                  },
                  tooltip: 'settings.title'.tr,
                ),
              ]
            : [],
        backgroundColor: backgroundColorAppBar != null
            ? backgroundColorAppBar
            //: ThemeService().themeData.appBarTheme.backgroundColor,
            : ThemeData().appBarTheme.backgroundColor,
        elevation: elevationTitle,
        title: Center(
          child: Container(
            alignment: alignmentTitle,
            width: width,
            child: Text(
              title,
              style: TextStyle(
                color: colorTitle != null
                    ? colorTitle
                    //: ThemeService().themeData.appBarTheme.color,
                    : ThemeData().appBarTheme.backgroundColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          decoration: border
              ? BoxDecoration(border: Border.all(color: Colors.black))
              : BoxDecoration(),
          width: width,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}