import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/ui/components/list_card_details.dart';

class HomeUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //print('user.name: ' + user?.value?.name);
    return GetBuilder<HomeController>(
      id: "home",
      init: HomeController(),
      builder: (controller) => ScaffoldGeneric(
        title: 'home.title'.tr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GridResponsive(
              xs: 2,
              sm: 2,
              md: 2,
              lg: 2,
              xl: 2,
              children: [
                FormInputFieldWithIcon(
                  controller: controller.nombreParticipanteController,
                  iconPrefix: Icons.person,
                  labelText: 'home.namePlayer'.tr,
                  validator: Validator().notEmpty,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.nombreParticipanteController.text = value!,
                ),
                IconButton(
                  onPressed: () {
                    controller.addPlayer();
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
            ListCardDetails(
              list: controller.currentParticipantes,
              //onPressed: controller.removePlayer(),
            ),
            Column(
              children: [],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      PrimaryButton(
                          labelText: 'home.createNewTournament'.tr,
                          onPressed: () async =>
                              await controller.createNewTournament())
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoTabBar(items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group_add_outlined),
                    //activeIcon: HomeUI(),
                    tooltip: 'home.newTournament'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_tree_outlined),
                    tooltip: 'home.listTour'.tr,
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
