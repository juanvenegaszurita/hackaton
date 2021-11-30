import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/components/list_card_details.dart'; 

class TournamentNewUI extends StatelessWidget { 
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => ScaffoldGeneric(
        isMenu: false,
        isAppBarActions: false,
        title: 'home.newTournament'.tr,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.0), 
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridResponsive(xs: 2, sm: 2, md: 2, lg: 2, xl: 2, children: [
                    Text("Cantidad de Equipos ", style: TextStyle(fontSize: 20)),
                    Text(
                      controller.currentnroEquipos.toString(),
                      style: TextStyle(fontSize: 35, color: Colors.orange),
                    ),
                  ]),
                  Slider(
                    value: controller.currentnroEquipos,
                    min: 0,
                    max: 100,
                    divisions: controller.currentDivision,
                    label: controller.currentnroEquipos.round().toString(),
                    onChanged: (double value) {
                      controller.setNroEquipos(value);
                    },
                  ),
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
                          if (_formKey.currentState!.validate()) {
                            controller.addPlayer();
                          }
                        },
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                  ListCardDetails(
                    list: controller.currentParticipantes,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}