import 'package:flutter/material.dart';
import 'package:hackaton/constants/constants.dart';
/* import 'package:hackaton/ui/public/public.dart'; */
import 'package:hackaton/ui/private/private.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: listMenu(),
      ),
    );
  }

  List<Widget> listMenu() {
    final List<Map<String, dynamic>> listMenuData = [
      {"title": "home.title".tr, "page": HomeUI()},
      {"title": 'login.updateProfileTitle'.tr, "page": UpdateProfileUI()},
    ];

    final List<Widget> listMenu = [
      DrawerHeader(
        decoration: BoxDecoration(
          color: AppThemes.dodgerBanco,
        ),
        child: Text('Menú'),
      )
    ];

    listMenuData.forEach((menu) {
      listMenu.add(ListTile(
        title: Text(menu['title']),
        onTap: () {
          Get.to(menu['page']);
        },
      ));
    });

    listMenu.add(ListTile(
      title: Text('settings.signOut'.tr,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        AuthController.to.signOut();
      },
    ));
    return listMenu;
  }
}
