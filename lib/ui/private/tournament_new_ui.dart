import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';

class TournamentNewUI extends GetResponsiveView {
  final AuthController authController = AuthController.to;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    double screenWidth = screen.isDesktop ? 1200 : screen.width;
    return GetBuilder<HomeController>(
      id: "home",
      init: HomeController(),
      builder: (controller) => Form(
        key: controller.formKey,
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        width: 180,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppThemes.orange),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.removeEquipo();
                            },
                            icon: Icon(
                              Icons.remove,
                              color: AppThemes.orange,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        child: Text(
                          controller.currentnroEquipos.toString(),
                          style: TextStyle(fontSize: 35, color: Colors.orange),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppThemes.orange),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.addEquipos();
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppThemes.orange,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        width: screenWidth - 120,
                        child: Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            } else {
                              return controller.listaParticipantes.where(
                                (word) => word.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase(),
                                    ),
                              );
                            }
                          },
                          optionsViewBuilder: (
                            context,
                            Function(String) onSelected,
                            options,
                          ) {
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
                          fieldViewBuilder: (
                            context,
                            textEditingController,
                            focusNode,
                            onFieldSubmitted,
                          ) {
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
                              validator: Validator().name,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                print(value);
                                controller.nombreParticipanteController.text =
                                    value!;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppThemes.orange),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.addPlayer();
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppThemes.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 8, top: 8),
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
                      child: Container(
                        height: 500,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: controller.currentParticipantes
                                .map(
                                  (nombreParticipante) => CardGeneric(
                                    border: true,
                                    color: AppThemes.nevada,
                                    height: 80,
                                    body: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              nombreParticipante,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 26,
                                              color: Colors.orange,
                                            ),
                                            onPressed: () =>
                                                controller.removePlayer(
                                              nombreParticipante,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )),
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
