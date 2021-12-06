import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/private/tournament_list_ui.dart';
import 'package:hackaton/ui/private/tournament_new_ui.dart';

class HomeUI extends GetResponsiveView {
  final AuthController authController = AuthController.to;
  @override
  Widget builder() {
    return GetBuilder<HomeController>(
      id: "home",
      init: HomeController(),
      builder: (controller) => ScaffoldGeneric(
        title: 'home.title'.tr,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: this.screen.height - 150,
                    ),
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TournamentListUI(),
                        ),
                        TournamentNewUI(),
                      ],
                    ),
                  ),
                  Container(
                    child: TabBar(
                      labelColor: AppThemes.orange,
                      unselectedLabelColor:
                          Theme.of(Get.context!).textTheme.button!.color!,
                      indicatorColor: AppThemes.orange,
                      tabs: [
                        Tab(
                            text: 'home.listTour'.tr,
                            icon: Icon(Icons.account_tree_outlined)),
                        Tab(
                            text: 'home.newTournament'.tr,
                            icon: Icon(Icons.group_add_outlined)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
