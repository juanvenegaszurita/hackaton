import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/components/list_card_details.dart';

class TournamentNewUI extends GetResponsiveView {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    double screenWidth = screen.isDesktop ? 1200 : screen.width;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  GridResponsive(
                    xs: 2,
                    sm: 2,
                    md: 2,
                    lg: 2,
                    xl: 2,
                    children: [
                      Text("Cantidad de Equipos ",
                          style: TextStyle(fontSize: 20)),
                      Text(
                        controller.currentnroEquipos.toString(),
                        style: TextStyle(fontSize: 35, color: Colors.orange),
                      ),
                    ],
                  ),
                  Slider(
                    value: controller.currentnroEquipos.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: controller.currentDivision,
                    label: controller.currentnroEquipos.round().toString(),
                    onChanged: (double value) {
                      controller.setNroEquipos(value.toInt());
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth - 120,
                        child: FormInputFieldWithIcon(
                          controller: controller.nombreParticipanteController,
                          iconPrefix: Icons.person,
                          labelText: 'home.namePlayer'.tr,
                          validator: Validator().name,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => null,
                          onSaved: (value) => controller
                              .nombreParticipanteController.text = value!,
                        ),
                      ),
                      Container(
                        width: 100,
                        child: IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.addPlayer();
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: screen.height - 380,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(Get.context!)
                            .inputDecorationTheme
                            .enabledBorder!
                            .borderSide
                            .color,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListCardDetails(
                      list: controller.currentParticipantes,
                    ),
                  ),
                ],
              ),
            ),
            PrimaryButton(
              labelText: 'home.createNewTournament'.tr,
              onPressed: () async => await controller.createNewTournament(),
            ),
          ],
        ),
      ),
    );
  }
}
