import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/private/tournament_list_ui.dart';
import 'package:hackaton/ui/private/tournament_new_ui.dart';

class HomeUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
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
                      maxHeight: 1000,
                    ),
                    child: TabBarView(
                      children: [TournamentListUI(), TournamentNewUI()],
                    ),
                  ),
                  Container(
                    child: TabBar(
                      labelColor: Theme.of(context).appBarTheme.backgroundColor,
                      unselectedLabelColor:
                          Theme.of(context).textTheme.button!.color!,
                      indicatorColor:
                          Theme.of(context).appBarTheme.backgroundColor,
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
