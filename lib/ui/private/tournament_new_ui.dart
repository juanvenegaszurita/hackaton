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
                  GridResponsive(
                    xs: 2,
                    sm: 2,
                    md: 2,
                    lg: 2,
                    xl: 2,
                    paddingTop: 2.5,
                    children: [
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          } else {
                            return controller.listaParticipantes.where((word) =>
                                word.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()));
                          }
                        },
                        optionsViewBuilder:
                            (context, Function(String) onSelected, options) {
                          return Material(
                            elevation: 2,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);

                                return ListTile(
                                  title: Text(option.toString()),
                                  onTap: () {
                                    onSelected(option.toString());
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: options.length,
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          controller.nombreParticipanteController =
                              textEditingController;
                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            onEditingComplete: onFieldSubmitted,
                            decoration: InputDecoration(
                              labelText: 'home.namePlayer'.tr,
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: Validator().notEmpty,
                            keyboardType: TextInputType.text,
                            onSaved: (value) => controller
                                .nombreParticipanteController.text = value!,
                          );
                        },
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
