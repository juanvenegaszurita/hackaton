import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/ui/components/menu.dart';
import 'package:hackaton/ui/private/settings_ui.dart';

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
      backgroundColor: backgroundColor != null ? backgroundColor : null,
      //: ThemeData().scaffoldBackgroundColor,
      appBar: AppBar(
        actions: isAppBarActions
            ? [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Get.to(SettingsUI());
                  },
                  tooltip: 'settings.title'.tr,
                ),
              ]
            : [],
        backgroundColor:
            backgroundColorAppBar != null ? backgroundColorAppBar : null,
        //: ThemeData().appBarTheme.backgroundColor,
        elevation: elevationTitle,
        title: Center(
          child: Container(
            alignment: alignmentTitle,
            width: width,
            child: Text(
              title,
              style: TextStyle(
                color: colorTitle != null ? colorTitle : null,
                //: ThemeData().appBarTheme.backgroundColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/footer-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            decoration: border
                ? BoxDecoration(border: Border.all(color: Colors.black))
                : BoxDecoration(
                    /*  image: DecorationImage(
                      image: AssetImage("assets/images/banner-bg-2.png"),
                      fit: BoxFit.cover,
                    ), */
                    ),
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
      ),
    );
  }
}
