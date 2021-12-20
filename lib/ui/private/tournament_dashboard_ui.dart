import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/tournament_dashboard_controller.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';

class TournamentDashboardUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentDashboardController>(
      init: TournamentDashboardController(),
      id: "tournamentDashboard",
      builder: (controller) => ScaffoldGeneric(
        isMenu: false,
        isAppBarActions: false,
        title: 'tournamentDashboard.title'.tr,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            tournamentsDetail(context, controller),
            FormVerticalSpace(),
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: TabBar(
                      labelColor: AppThemes.orange,
                      unselectedLabelColor:
                          Theme.of(context).textTheme.button!.color!,
                      indicatorColor: AppThemes.orange,
                      tabs: [
                        Tab(text: 'tournamentDashboard.tabGraphic'.tr),
                        Tab(text: 'tournamentDashboard.tabList'.tr),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 1000,
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 50,
                    ),
                    child: TabBarView(
                      children: [
                        GraphCompetenceTournament(controller: controller),
                        ListCompetenceTournament(controller: controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FormVerticalSpace(),
          ],
        ),
      ),
    );
  }

  tournamentsDetail(
    BuildContext context,
    TournamentDashboardController controller,
  ) {
    bool isLogin = (AuthController.to.firebaseUser.value?.uid != null);

    return Column(
      children: [
        GridResponsive(
          xl: 2,
          lg: 2,
          md: 1,
          sm: 1,
          xs: 1,
          paddingBottom: 2.5,
          paddingLeft: 2.5,
          paddingRight: 2.5,
          paddingTop: 2.5,
          children: [
            FormInputFieldWithIcon(
              enabled: isLogin,
              controller: controller.nombreController,
              iconPrefix: Icons.app_registration,
              labelText: 'tournamentDashboard.name'.tr,
              validator: Validator().name,
              keyboardType: TextInputType.text,
              onChanged: (value) => null,
              onSaved: (value) => controller.nombreController.text = value!,
            ),
            FormInputFieldWithIcon(
              enabled: isLogin,
              controller: controller.nombreJuegoController,
              iconPrefix: Icons.gamepad_outlined,
              labelText: 'tournamentDashboard.gameName'.tr,
              validator: Validator().name,
              keyboardType: TextInputType.text,
              onChanged: (value) => null,
              onSaved: (value) =>
                  controller.nombreJuegoController.text = value!,
            ),
          ],
        ),
        GridResponsive(
          lg: 2,
          paddingBottom: 2.5,
          paddingLeft: 2.5,
          paddingRight: 2.5,
          paddingTop: 2.5,
          children: [
            FormInputFieldWithIconClick(
              enable: isLogin,
              onTap: () => isLogin ? _selectDate(context, controller) : null,
              iconPrefix: Icons.calendar_today,
              labelTextPrefix: 'tournamentDashboard.date'.tr,
              labelText: controller.currentFecha,
            ),
            FormInputFieldWithIconClick(
              enable: isLogin,
              onTap: () => isLogin ? _selectTime(context, controller) : null,
              iconPrefix: Icons.timer,
              labelTextPrefix: 'tournamentDashboard.hour'.tr,
              labelText: controller.currentHora,
            ),
            FormInputFieldWithIcon(
              enabled: isLogin,
              controller: controller.ubicacionController,
              iconPrefix: Icons.location_on,
              labelText: 'tournamentDashboard.location'.tr,
              validator: Validator().notEmpty,
              keyboardType: TextInputType.text,
              onChanged: (value) => null,
              onSaved: (value) => controller.ubicacionController.text = value!,
            ),
            FormInputFieldWithIcon(
              enabled: false,
              controller: controller.nroEquiposController,
              iconPrefix: Icons.format_list_numbered,
              labelText: 'tournamentDashboard.numEquipment'.tr,
              validator: Validator().number,
              keyboardType: TextInputType.number,
              onChanged: (value) => null,
              onSaved: (value) => controller.nroEquiposController.text = value!,
            ),
          ],
        ),
        GridResponsive(
          xl: 1,
          lg: 1,
          md: 1,
          sm: 1,
          xs: 1,
          children: [
            FormInputFieldWithIcon(
              enabled: isLogin,
              controller: controller.detalleController,
              iconPrefix: Icons.details,
              labelText: 'tournamentDashboard.detail'.tr,
              validator: Validator().notEmpty,
              keyboardType: TextInputType.multiline,
              onChanged: (value) => null,
              onSaved: (value) => controller.detalleController.text = value!,
              minLines: 3,
            ),
          ],
        ),
        if (isLogin) FormVerticalSpace(),
        if (isLogin)
          GridResponsive(
            xl: 1,
            lg: 1,
            md: 1,
            sm: 1,
            xs: 1,
            children: [
              PrimaryButton(
                labelText: 'tournamentDashboard.saved'.tr,
                onPressed: () async =>
                    await controller.tournamentService.updateTournament(
                  controller.currentId,
                  controller.getTournamentModel(),
                ),
              ),
            ],
          ),
        if (isLogin) FormVerticalSpace(),
        if (isLogin)
          GridResponsive(
            xl: 1,
            lg: 1,
            md: 1,
            sm: 1,
            xs: 1,
            children: [
              PrimaryButton(
                labelText: 'tournamentDashboard.delete'.tr,
                onPressed: () async {
                  ModalTeam.dialog(
                    context: context,
                    title: 'tournamentDashboard.delete'.tr,
                    content: Text('general.questionDelete'.tr),
                    onPressed: () async {
                      await controller.tournamentService.deleteTournament(
                        controller.currentId,
                      );
                      Get.back();
                    },
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TournamentDashboardController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) controller.setFecha(picked.toString().split(" ")[0]);
  }

  Future<void> _selectTime(
    BuildContext context,
    TournamentDashboardController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (picked != null) controller.setHora("${picked.hour}:${picked.minute}");
  }
}
