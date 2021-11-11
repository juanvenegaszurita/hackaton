import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/ui/components/components.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "home",
      init: HomeController(),
      builder: (controller) => ScaffoldGeneric(
        body: Column(
          children: [
            Text('home'),
          ],
        ),
      ),
    );
  }
}
